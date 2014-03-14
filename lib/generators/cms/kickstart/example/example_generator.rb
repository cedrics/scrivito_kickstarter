module Cms
  module Generators
    module Kickstart
      class ExampleGenerator < ::Rails::Generators::Base
        def create_examples
          Rails::Generators.invoke('cms:widget:teaser', [], behavior: behavior)
          Rails::Generators.invoke('cms:widget:teaser:example', [], behavior: behavior)

          Rails::Generators.invoke('cms:widget:image', [], behavior: behavior)
          Rails::Generators.invoke('cms:widget:image:example', [], behavior: behavior)

          Rails::Generators.invoke('cms:widget:headline', [], behavior: behavior)
          Rails::Generators.invoke('cms:widget:headline:example', [], behavior: behavior)

          Rails::Generators.invoke('cms:widget:maps', [], behavior: behavior)
          Rails::Generators.invoke('cms:widget:maps:example', [], behavior: behavior)

          Rails::Generators.invoke('cms:widget:text', [], behavior: behavior)
          Rails::Generators.invoke('cms:widget:text:example', [], behavior: behavior)

          Rails::Generators.invoke('cms:widget:two_column', [], behavior: behavior)
          Rails::Generators.invoke('cms:widget:two_column:example', [], behavior: behavior)

          Rails::Generators.invoke('cms:widget:three_column', [], behavior: behavior)
          Rails::Generators.invoke('cms:widget:three_column:example', [], behavior: behavior)

          Rails::Generators.invoke('cms:component:contact_page', [], behavior: behavior)
          Rails::Generators.invoke('cms:component:contact_page:example', ['/en'], behavior: behavior)

          Rails::Generators.invoke('cms:component:blog')
          Rails::Generators.invoke('cms:component:blog:example', [], behavior: behavior)
        end
      end
    end
  end
end
