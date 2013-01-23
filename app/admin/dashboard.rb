# encoding: UTF-8
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1

  action_item do
    link_to "View site", "/"
  end

  content do
    section "Numbers" do
      ul do
        li link_to(pluralize(User.users.count, "user"), admin_users_path)
        li link_to(pluralize(Guest.count, "guest"), admin_guests_path)
        li link_to(pluralize(Friend.count, "friend"), admin_friends_path)
        li link_to(pluralize(Bill.count, "bill"), admin_bills_path)
        li "#{Participation.sum(:payment)}$ shared"
      end
    end

    section "Recent Bills" do
      ul do
        Bill.last(5).reverse.collect do |bill|
          li link_to(bill.title.inspect, admin_bill_path(bill)) + " by " + link_to(bill.user.display_name, admin_user_path(bill.user))
        end
      end
    end

    section "Recent Users" do
      ul do
        User.users.last(5).reverse.collect do |user|
          li link_to(user.display_name, admin_user_path(user))
        end
      end
    end

    # == Render Partial Section
    # The block is rendered within the context of the view, so you can
    # easily render a partial rather than build content in ruby.
    #
    #   section "Recent Posts" do
    #     div do
    #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
    #     end
    #   end

    # == Section Ordering
    # The dashboard sections are ordered by a given priority from top left to
    # bottom right. The default priority is 10. By giving a section numerically lower
    # priority it will be sorted higher. For example:
    #
    #   section "Recent Posts", :priority => 10
    #   section "Recent User", :priority => 1
    #
    # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  end
end
