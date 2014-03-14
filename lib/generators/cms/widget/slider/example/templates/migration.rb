class SliderWidgetExample < Scrival::Migration
  def up
    urls = [
      'http://lorempixel.com/1170/400/abstract',
      'http://lorempixel.com/1170/400/sports',
      'http://lorempixel.com/1170/400/city',
    ]

    image_ids = urls.map do |url|
      image = Image.create(blob: File.new(open(url).path))

      image['id']
    end

    homepage = Obj.find_by_path('<%= example_cms_path %>')

    add_widget(homepage, '<%= example_widget_attribute %>', {
      _obj_class: 'SliderWidget',
      images: image_ids,
    })
  end

  private

  def add_widget(obj, attribute, widget_params)
    workspace_id = Scrival::Workspace.current.id
    obj_params = Scrival::CmsRestApi.get("workspaces/#{workspace_id}/objs/#{obj.id}")
    widget_id = Scrival::BasicObj.generate_widget_pool_id

    params = {}
    params['_widget_pool'] = { widget_id => widget_params }
    params[attribute] = obj_params[attribute] || {}
    params[attribute]['list'] ||= []
    params[attribute]['list'] << { widget: widget_id }

    update_obj(obj_params['id'], params)
  end
end
