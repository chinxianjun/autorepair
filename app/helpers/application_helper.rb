require 'tabular_form_builder'
module ApplicationHelper
  def l_or_humanize(s, options={})
    k = "#{options[:prefix]}#{s}".to_sym
    ::I18n.t(k, :default => s.to_s.humanize)
  end

  # Renders tabs and their content
  def render_tabs(tabs)
    if tabs.any?
      render :partial=> 'common/tabs', :locals=>  {:tabs=>  tabs}
    else
      content_tag 'p', 'no_data', :class=>  "nodata"
    end
  end

  def principals_check_box_tags(name, principals)
    users_list = ''
    principals.sort.each do |principal|
      users_list << "<label>#{ check_box_tag name, principal.id, false } #{principal.username}</label>\n"
    end
    raw users_list
  end

  def roles_check_box_tags(name, roles)
    roles_list = ''
    roles.sort.each do |role|
      roles_list << "<label>#{ check_box_tag name, role.id, false } #{role.name}</label>\n"
    end
    raw roles_list
  end

  # 404 error page error message
  def html_title(*args)
    if args.empty?
      title = []
      title << @project.name if @project
      title += @html_title if @html_title
      title << Setting.app_title
      title.select {|t| !t.blank? }.join(' - ')
    else
      @html_title ||= []
      @html_title += args
    end
  end

  # Displays a link to user's account page
  def link_to_user(user)
    if user.is_a?(User)
      name = raw(user.username)
      if user
        link_to name, :controller=>'users',  :action=>'show', :id=>user
      else
        name
      end
    else
      raw(user.to_s)
    end
  end

  # Displays a link to user's account page
  def link_to_role(role)
    if role.is_a?(Role)
      name = raw(role.name)
      if role
        link_to name, :controller=>'roles', :action=>'show', :id=>role
      else
        name
      end
    else
      raw(role.to_s)
    end
  end

  def labelled_tabular_form_for(name, options, &proc)
    options[:html] ||= {}
    options[:html][:class] = 'tabular' unless options[:html].has_key?(:class)
    form_for(name, options.merge({ :builder=>  TabularFormBuilder, :lang=>  I18n.locale}), &proc)
  end

  def reorder_links(name, url)
    link_to(image_tag('2uparrow.png', :alt=> 'highest'), url.merge({"#{name}[move_to]" => 'highest'}), :method=>:post, :title=>"highest") +
    link_to(image_tag('1uparrow.png', :alt=> 'higher'), url.merge({"#{name}[move_to]" => 'higher'}), :method=>:post, :title=>  "higher") +
    link_to(image_tag('1downarrow.png', :alt=> 'lower'), url.merge({"#{name}[move_to]" => 'lower'}), :method=>:post, :title=>  "lower") +
    link_to(image_tag('2downarrow.png', :alt=> 'lowest'), url.merge({"#{name}[move_to]" => 'lowest'}), :method=>:post, :title=>  "lowest")
  end

  def check_all_links(form_name)
    link_to_function('check_all', "checkAll('#{form_name}', true)") +
    " | " +
    link_to_function('check_all', "checkAll('#{form_name}', false)")
  end

  def back_url_hidden_field_tag
    back_url = params[:back_url] || request.env['HTTP_REFERER']
    back_url = CGI.unescape(back_url.to_s)
    hidden_field_tag('back_url', CGI.escape(back_url)) unless back_url.blank?
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def link_to_warehouse(warehouse, options={}, html_options = nil)
    #if warehouse.archived?
    #  h(warehouse)
    #else
      url = {:controller => 'admin/warehouses', :action => 'show', :id => warehouse}.merge(options)
      link_to(h(warehouse), url, html_options)
    #end
  end

  def render_warehouse_nested_lists(warehouses)
    s = ''
    if warehouses.any?
      ancestors = []
      original_warehouse = @warehouse

      warehouses.sort_by(&:lft).each do |warehouse|
        @warehouse = warehouse
        if (ancestors.empty? || warehouse.is_descendant_of?(ancestors.last))
          s << "<ul class='warehouses #{ancestors.empty? ? 'root' : nil}'>\n"
        else
          ancestors.pop
          s << "</li>"
          while (ancestors.any? && !warehouse.is_descendant_of?(ancestors.last))
            ancestors.pop
            s << "</ul></li>\n"
          end
        end
        classes = (ancestors.empty? ? 'root' : 'child')
        s << "<li class='#{classes}'><div class='#{classes}'>"
        s << h(block_given? ? yield(warehouse) : warehouse.name)
        s << "<a href='/admin/companies/#{@company.id}/warehouses/#{warehouse.id}/edit'>edit</a>"
        s << "<a href='/admin/companies/#{@company.id}/warehouses/#{warehouse.id}/new_users'>user</a>"
        s << "<a href='/admin/companies/#{@company.id}/warehouses/#{warehouse.id}/new_roles'>role</a>"
        s << "</div>\n"
        #
        ancestors << warehouse
      end
      s << ("</li></ul>\n" * ancestors.size)
      @warehouse = original_warehouse
    end
    s.html_safe
  end

  def textilizable(*args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    case args.size
      when 1
        obj = options[:object]
        text = args.shift
      when 2
        obj = args.shift
        attr = args.shift
        text = obj.send(attr).to_s
      else
        raise ArgumentError, 'invalid arguments to textilizable'
    end
    return '' if text.blank?
    warehouse = options[:warehouse] || @warehouse || (obj && obj.respond_to?(:company) ? obj.warehouse : nil)
    only_path = options.delete(:only_path) == false ? false : true

    text = Redmine::WikiFormatting.to_html(Setting.text_formatting, text, :object => obj, :attribute => attr)

    @parsed_headings = []
    @heading_anchors = {}
    @current_section = 0 if options[:edit_section_links]

    parse_sections(text, warehouse, obj, attr, only_path, options)
    text = parse_non_pre_blocks(text) do |text|
      [:parse_inline_attachments, :parse_wiki_links, :parse_redmine_links, :parse_macros].each do |method_name|
        send method_name, text, warehouse, obj, attr, only_path, options
      end
    end
    parse_headings(text, warehouse, obj, attr, only_path, options)

    if @parsed_headings.any?
      replace_toc(text, @parsed_headings)
    end

    text.html_safe
  end

  def parse_sections(text, project, obj, attr, only_path, options)
    return unless options[:edit_section_links]
    text.gsub!(HEADING_RE) do
      heading = $1
      @current_section += 1
      if @current_section > 1
        content_tag('div',
                    link_to(image_tag('edit.png'), options[:edit_section_links].merge(:section => @current_section)),
                    :class => 'contextual',
                    :title => l(:button_edit_section)) + heading.html_safe
      else
        heading
      end
    end
  end

  def parse_headings(text, project, obj, attr, only_path, options)
    return if options[:headings] == false

    text.gsub!(HEADING_RE) do
      level, attrs, content = $2.to_i, $3, $4
      item = strip_tags(content).strip
      anchor = sanitize_anchor_name(item)
      # used for single-file wiki export
      anchor = "#{obj.page.title}_#{anchor}" if options[:wiki_links] == :anchor && (obj.is_a?(WikiContent) || obj.is_a?(WikiContent::Version))
      @heading_anchors[anchor] ||= 0
      idx = (@heading_anchors[anchor] += 1)
      if idx > 1
        anchor = "#{anchor}-#{idx}"
      end
      @parsed_headings << [level, anchor, item]
      "<a name=\"#{anchor}\"></a>\n<h#{level} #{attrs}>#{content}<a href=\"##{anchor}\" class=\"wiki-anchor\">&para;</a></h#{level}>"
    end
  end
end
