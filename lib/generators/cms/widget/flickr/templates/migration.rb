class FlickrWidget < ::Scrivito::Migration
  def up
    Scrivito::ObjClass.create(
      name: 'FlickrWidget',
      is_binary: false,
      attributes: [
        {
          name: 'display',
          type: :enum,
          values: %w(latest random),
        },
        {
          name: 'count',
          type: :enum,
          values: %w(1 2 3 4 5 6 7 8 9 10),
        },
        {
          name: 'size',
          type: :enum,
          values: %w(small thumbnail medium),
        },
        {
          name: 'source',
          type: :enum,
          values: %w(all user all_tag user_tag),
        },
        {
          name: 'user',
          type: :string,
        },
        {
          name: 'tags',
          type: :string,
        },
      ]
    )
  end
end
