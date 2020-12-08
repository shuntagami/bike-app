module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def header_link_item(name, path)
    class_name = 'nav-item'
    class_name << ' active' if current_page?(path)

    content_tag :li, class: class_name do
      link_to name, path, class: 'nav-link'
    end
  end

  def nav_link_add_active(name, path)
    class_name = 'nav-link nav-item'
    class_name << ' active' if current_page?(path)

    link_to name, path, class: class_name
  end

  def date_range_link_active(name, path, range)
    class_name = 'btn '
    class_name << if params[:date_range].nil? && range == 'all'
                    'btn-danger'
                  elsif range == params[:date_range]
                    'btn-danger'
                  else
                    'btn-outline-secondary'
                  end
    link_to name, "#{path}?date_range=#{range}", class: class_name
  end
end
