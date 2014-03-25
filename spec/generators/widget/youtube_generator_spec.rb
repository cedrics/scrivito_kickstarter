require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/youtube/youtube_generator.rb'

describe Cms::Generators::Widget::YoutubeGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'views' do
          directory 'youtube_widget' do
            file 'show.html.haml'
            file 'edit.html.haml'
            file 'thumbnail.html.haml'
          end
        end

        directory 'models' do
          file 'youtube_widget.rb' do
            contains 'class YoutubeWidget < Widget'
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'youtube_widget'
        end
      end
    }
  end
end
