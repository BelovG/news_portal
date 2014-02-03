ActiveAdmin.register Post do

  permit_params :title, :description, :content, :approval, :user_id

  index do
    column :title
    column :description
    column :content
    column :approval
    default_actions
  end

  controller do
    after_action :mail, only: :update

    private
    def mail
      HardWorker.perform_async(params[:id])
    end
  end

  form do |f|
    f.inputs "Approval" do
      f.input :title
      f.input :description
      f.input :content
      f.input :approval
    end
    f.actions
  end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
