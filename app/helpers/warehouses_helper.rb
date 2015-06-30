module WarehousesHelper
  def render_warehouse_hierarchy(warehouses)
      render_warehouse_nested_lists(warehouses) do |warehouse|
        s = link_to_warehouse(warehouse, {}, :class => "#{warehouse.css_classes}")
        if warehouse.description.present?
          s << content_tag('div', textilizable(warehouse.short_description, :warehouse => warehouse), :class => 'wiki description')
        end
        s
      end
  end

  def link_to_warehouse(warehouse, options={}, html_options = nil)
      url = {:controller => '/warehouses', :action => 'show', :id => warehouse}.merge(options)
      link_to(h(warehouse), url, html_options)
  end
end
