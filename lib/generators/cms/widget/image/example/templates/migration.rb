require 'open-uri'

class ImageWidgetExample < RailsConnector::Migration
  def up
    asset_url = 'http://lorempixel.com/1170/400/abstract'

    asset = Image.create(blob: File.new(open(asset_url).path))

    homepage = Obj.find_by_path('<%= example_cms_path %>')

    add_widget(homepage, '<%= example_widget_attribute %>', {
      _obj_class: 'ImageWidget',
      source: asset['id'],
    })
  end

  private

  def add_widget(obj, attribute, widget_params)
    workspace_id = RailsConnector::Workspace.current.id
    obj_params = RailsConnector::CmsRestApi.get("workspaces/#{workspace_id}/objs/#{obj.id}")
    widget_id = RailsConnector::BasicObj.generate_widget_pool_id

    params = {}
    params['_widget_pool'] = { widget_id => widget_params }
    params[attribute] = obj_params[attribute] || {}
    params[attribute]['list'] ||= []
    params[attribute]['list'] << { widget: widget_id }

    update_obj(obj_params['id'], params)
  end
end
