require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/login_page/login_page_generator.rb'

describe Cms::Generators::Component::LoginPageGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'controllers' do
          file 'login_page_controller.rb'
        end

        directory 'models' do
          file 'login_page.rb' do
            contains 'class LoginPage < Obj'
          end
        end

        directory 'views' do
          directory 'login_page' do
            file 'index.html.haml'
            no_file 'details.html.haml'
            no_file 'thumbnail.html.haml'
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'login_page.rb'
        end
      end
    }
  end
end
