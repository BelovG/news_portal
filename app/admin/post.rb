ActiveAdmin.register Post do

  permit_params :title, :description, :content, :approval, :user_id

  index do
    column :title
    column :description
    column :content
    column :approval
    default_actions
  end

  sidebar "Send approval by email", :only => :show do
    @post = Post.find(params[:id])
    render "admin/admin_sidebar"
  end

  member_action :approval, :method => :put do
    post = Post.find(params[:id])
    post.update_attribute(:approval, params[:approval])
    if post.approval
      UserMailer.delay.approval(post.id)
      post.subscription_mailer
    else
      UserMailer.delay.disapproval(post.id)
    end
    redirect_to admin_posts_path
  end

  form do |f|
    f.inputs "Approval" do
      f.input :title
      f.input :description
      f.input :content
    end
    f.actions
  end
end
