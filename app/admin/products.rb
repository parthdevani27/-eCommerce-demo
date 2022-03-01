ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :image, :price, :quantity, :description, :active
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :image, :price, :quantity, :description, :active]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    id_column
    column :title
    column :image
    column :price
    column :quantity
    column :active
    column :description do |my_resource|
      truncate(my_resource.description, length: 50)
    end
    actions
  end
  
end
