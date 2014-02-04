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
end
