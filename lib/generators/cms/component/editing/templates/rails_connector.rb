
# Register a JavaScript search API result format used by the media browser.
RailsConnector::Configuration.register_obj_format('mediabrowser') do |obj|
  format = {
    id: obj.id,
    title: obj.title || obj.name,
  }

  if obj.image?
    format[:preview] = obj.body_data_url
  end

  format
end
