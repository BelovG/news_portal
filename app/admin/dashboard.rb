ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        para "Number of posts: #{Post.count}"
        para "Number of all users: #{User.count}"
        para "Number of users registrated today: #{User.joined_within_one_days.count}"
      end
    end
  end
end
