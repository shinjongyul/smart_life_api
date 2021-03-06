# == Schema Information
#
# Table name: subdistricts
#
#  id             :integer          not null, primary key
#  province       :string
#  city           :string
#  subdistrict    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  district       :string
#  property_phone :string
#  alarm_phone    :string
#

class Subdistrict < ActiveRecord::Base
	# 社区模型
	# province 省 city 市 subdistrict 街道 
	has_many :users
	has_many :admin_user
	has_many :communities
	has_many :home_blocks
	# has_many :sports
	# has_many :sport_weeklies
	# has_many :sport_monthlies
	# has_many :sport_yearlies

	after_create :check_submeter_tables unless ENV['RAILS_ENV'] == "test"
	after_destroy :drop_its_submeter_tables unless ENV['RAILS_ENV'] == "test"

	# customer_services

	def name
		"#{province}#{city}#{district}#{subdistrict}"
	end
	
	def self.list
		_all = Subdistrict.all.to_a
		_all.chunk{ |x| x.province }.map{|province| {province[0] => province[1].chunk{ |x| x.city }.map{|city| {city[0] => city[1].chunk{ |x| x.district  }.map{|district| { district[0] => district[1].map{ |x| { x.subdistrict => x.output }}}}}}}}
	end 

	def self.list2
		_data = {"province" => Subdistrict.list}
		
		_provinces = Subdistrict.get_son(_data).values[0]
		_cities = _data.values[0].map{|province| Subdistrict.get_son(province)}[0]
		_districts = {}
		_subdistricts = {}
		_data.values[0].each do |province| 
		 	_x = []
		 	province.values[0].each do |city|
		 		_x = Subdistrict.get_son(city)
		 		_districts[_x.keys[0]] = _x.values[0]
		 		_xx = []
		 		city.values[0].each do |district|
		 			_xx = Subdistrict.get_son(district, true)
		 			_subdistricts[_xx.keys[0]] = _xx.values[0]
	 			end
	 		end
	 	end
	 	{
	 		"provinces" => _provinces,
	 		"citys" => _cities,
	 		"districts" => _districts,
	 		"subdistricts" => _subdistricts
	 	}
	end

	def self.get_son some, last=false
		last ?
		{some.keys[0] => some.values[0].map { |x| "#{x.keys[0]}@*@#{x.values[0][:id]}"}} :
		{some.keys[0] => some.values[0].map { |x| x.keys[0] }}  
	end

	def output
		{
			"id": id,
		  "province": province,
      "city": city,
      "subdistrict": subdistrict,
      "district": district,
      "communities": communities.collect(&:name)
    }

	end

	def self.migrate_data old_id, new_id, user_id
		NeedSubmeter.each do |class_name|
			_old_class = class_name.safe_constantize.get_const(old_id)
			_new_class = class_name.safe_constantize.get_const(new_id)

			_old_class.where(user_id: user_id).each do |_old_item|
				_new_item = _new_class.new(_old_item.attributes.except("id", "updated_at", "created_at", "subdistrict_id"))
				ActiveRecord::Base.transaction do  
					_old_item.destroy!
					_new_item.save!
				end
			end
		end
		rescue => error
			error
	end
 # q.attributes.merge({"subdistrict_id"=>1, "id"=> nil, "updated_at" => nil, "created_at" => nil})
 # q.attributes.except("id", "updated_at", "created_at").merge({"subdistrict_id"=>1})
 # q.attributes.except("id", "updated_at", "created_at", "subdistrict_id")

	def drop_its_submeter_tables
		ActiveRecord::Base.transaction do 
			NeedSubmeter.each do |class_name|
				class_name.constantize.drop_submeter_table(self.id)
			end
		end
		rescue => error
			error
	end

	def check_submeter_tables
		NeedSubmeter.each do |class_name|
			Subdistrict.all.each do |subdistrict|
				class_name.constantize.create_submeter_table(subdistrict.id)
			end
		end
	end

end
