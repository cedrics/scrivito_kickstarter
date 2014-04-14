require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/contact_page/contact_page_generator.rb'

describe Cms::Generators::Component::ContactPageGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  it 'creates file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'contact_page.rb' do
            contains 'class ContactPage < Obj'
          end
        end

        directory 'controllers' do
          file 'contact_page_controller.rb'
        end

        directory 'views' do
          directory 'contact_page' do
            file 'index.html.erb'
            file 'thumbnail.html.erb'
          end
        end

        directory 'presenters' do
          file 'contact_page_presenter.rb'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'contact_page'
        end
      end
    }
  end
end
