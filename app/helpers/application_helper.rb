module ApplicationHelper
  WEBSITE_NAME = 'GoToTouring'.freeze
  # PostのSelectBoxを定義
  WEATHERS = %w[晴れ 曇り 小雨 雨 豪雨 雷 みぞれ 雪 霧].freeze
  FEELINGS = %w[うだる暑さ 暑い 暖かい ちょうどいい 肌寒い 凍えるほど寒い].freeze
  ROAD_CONDITION = %w[問題なし 一部凍っている ほとんど凍結している 落ち葉に注意 砂利に注意].freeze

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

  def full_title(page_title = '')
    base_title = WEBSITE_NAME
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
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
