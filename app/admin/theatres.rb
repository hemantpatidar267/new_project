ActiveAdmin.register Theatre do

  permit_params :name, :address, :user_id
 
  index do
    selectable_column
    id_column
    column :name
    column :address
    column :user_id
    actions
  end

  filter :name
  filter :address
  filter :user_id

  form do |f|
    f.inputs do
      f.input :name
      
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  # #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
