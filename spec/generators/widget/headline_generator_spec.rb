require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/widget/headline/headline_generator.rb'

describe Cms::Generators::Widget::HeadlineGenerator do
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
          directory 'headline_widget' do
            file 'show.html.haml'
            file 'details.html.haml'
            file 'thumbnail.html.haml'
          end
        end

        directory 'models' do
          file 'headline_widget.rb' do
            contains 'class HeadlineWidget < Widget'
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'headline_widget'
        end
      end
    }
  end
end
