Subdistrict.all.each do  |s|
  ActiveAdmin.register Sport::Weekly.get_const(s.id) do 

    menu parent: "健步达人", priority: 2, label: "每周统计", if: proc{ current_admin_user.subdistrict_id == s.id}
    config.sort_order = 'count_desc'

    index do
      label "查看其它社区信息，请登录对应社区管理员账号"
      column :rank
      column :user_phone do |obj|
        obj.try(:user).try(:phone)
      end
      column :user_nickname do |obj|
        obj.try(:user).try(:nickname)
      end
      column :year
      column :cweek
      column :count
      column :updated_at
    end

    csv do
      column :rank
      column :user_phone do |obj|
        obj.try(:user).try(:phone)
      end
      column :user_nickname do |obj|
        obj.try(:user).try(:nickname)
      end
      column :year
      column :cweek
      column :count
      column :updated_at
    end  

  end
end

# ActiveAdmin.register Sport::Weekly do
#   menu parent: "健步达人"
#   config.sort_order = 'count_desc'

#   controller do 
#     #更改默认搜索范围
#     #index仅显示 正在销售
#     def scoped_collection
#       Sport::Weekly.get_const(current_admin_user.subdistrict_id)
#     end
#   end
  
#   index do
#     column :rank
#     column :user_phone do |obj|
#       obj.try(:user).try(:phone)
#     end
#     column :user_nickname do |obj|
#       obj.try(:user).try(:nickname)
#     end
#     column :year
#     column :cweek
#     column :count
#     column :updated_at
#   end

#   csv do
#     column :rank
#     column :user_phone do |obj|
#       obj.try(:user).try(:phone)
#     end
#     column :user_nickname do |obj|
#       obj.try(:user).try(:nickname)
#     end
#     column :year
#     column :cweek
#     column :count
#     column :updated_at
#   end  
# end