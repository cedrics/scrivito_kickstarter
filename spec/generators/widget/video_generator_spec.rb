require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/video/video_generator.rb'

describe Cms::Generators::Widget::VideoGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    javascripts_path = "#{destination_root}/app/assets/javascripts"
    stylesheets_path = "#{destination_root}/app/assets/stylesheets"

    mkdir_p(javascripts_path)
    mkdir_p(stylesheets_path)

    File.open("#{javascripts_path}/application.js", 'w') { |file| file.write("\n//= require_self") }
    File.open("#{stylesheets_path}/application.css", 'w') { |file| file.write("\n *= require_self") }
    File.open("#{destination_root}/Gemfile", 'w')
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'assets' do
          directory 'javascripts' do
            file 'application.js' do
              contains '//= require projekktor'
            end

            directory 'application' do
              file 'projekktor.config.js.coffee'
            end
          end

          directory 'stylesheets' do
            file 'application.css' do
              contains '*= require projekktor'
            end
          end
        end

        directory 'views' do
          directory 'video_widget' do
            file 'show.html.haml'
            file 'details.html.haml'
            file 'thumbnail.html.haml'
          end
        end

        directory 'models' do
          file 'video_widget.rb' do
            contains 'class VideoWidget < Widget'
          end
        end
      end

      file 'Gemfile' do
        contains 'gem "projekktor-rails"'
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'video_widget'
        end
      end
    }
  end
end
