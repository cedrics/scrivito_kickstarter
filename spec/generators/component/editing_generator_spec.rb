require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/editing/editing_generator'

describe Cms::Generators::Component::EditingGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['--editor=redactor']

  before do
    # We are calling a sub generator, so we need to make sure to set the correct destination root for
    # the test. This is not done globally, as this is the only test, were the sub generator is called.
    require 'generators/cms/component/editing/redactor/redactor_generator'
    Cms::Generators::Component::Editing::RedactorGenerator.send(:include, TestDestinationRoot)
    require 'generators/cms/component/editing/mediabrowser/mediabrowser_generator'
    Cms::Generators::Component::Editing::MediabrowserGenerator.send(:include, TestDestinationRoot)

    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    javascripts_path = "#{destination_root}/app/assets/javascripts"
    stylesheets_path = "#{destination_root}/app/assets/stylesheets"
    environments_path = "#{destination_root}/config/environments"
    layouts_path = "#{destination_root}/app/views/layouts"
    config_path = "#{destination_root}/config"
    initializers_path = "#{destination_root}/config/initializers"

    mkdir_p(javascripts_path)
    mkdir_p(stylesheets_path)
    mkdir_p(environments_path)
    mkdir_p(layouts_path)
    mkdir_p(config_path)
    mkdir_p(initializers_path)

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{environments_path}/production.rb", 'a') { |f| f.write('Test::Application.configure do') }
    File.open("#{layouts_path}/application.html.haml", 'w') { |file| file.write("  %body{body_attributes(@obj)}\n") }
    File.open("#{config_path}/routes.rb", 'w') { |file| file.write('Dummy::Application.routes.draw do') }
    File.open("#{config_path}/application.rb", 'w') { |file| file.write("# config.time_zone = 'Central Time (US & Canada)'") }
    File.open("#{initializers_path}/scrival.rb", 'w')
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'assets' do
          directory 'fonts' do
            file 'editing_icons-webfont.eot'
            file 'editing_icons-webfont.ttf'
            file 'editing_icons-webfont.woff'
          end

          directory 'stylesheets' do
            directory 'editing' do
              file 'base.css'
              file 'icons.css.erb'
              file 'buttons.css'
              file 'base.css'
              file 'menubar.css'

              directory 'editors' do
                file 'text_editor.css'
                file 'linklist_editor.css'
                file 'reference_editor.css'
                file 'referencelist_editor.css'
              end
            end

            file 'editing.css' do
              contains '*= require jquery.ui.datepicker'
              contains '*= require jquery.ui.slider'
              contains '*= require jquery-ui-timepicker-addon.min'
            end
          end

          directory 'javascripts' do
            directory 'editing' do
              file 'base.js.coffee'

              directory 'editors' do
                file 'string_editor.js.coffee'
                file 'text_editor.js.coffee'
                file 'linklist_editor.js.coffee'
                file 'reference_editor.js.coffee'
                file 'referencelist_editor.js.coffee'
                file 'enum_editor.js.coffee'
                file 'multienum_editor.js.coffee'
                file 'date_editor.js.coffee'
                file 'slider_editor.js.coffee'
              end
            end

            file 'editing.js' do
              contains '//= require jquery.ui.sortable'
              contains '//= require jquery.ui.datepicker'
              contains '//= require jquery.ui.slider'
              contains '//= require jquery-ui-timepicker-addon.min'
            end
          end
        end

        directory 'helpers' do
          file 'editing_helper.rb'
        end

        directory 'views' do
          directory 'layouts' do
            file '_menubar.html.haml'

            file 'application.html.haml' do
              contains "    = render('layouts/menubar', current_user: current_user)"
            end
          end
        end
      end

      directory 'config' do
        directory 'initializers' do
          file 'scrival.rb' do
            contains "Scrival::Configuration.register_obj_format('mediabrowser')"
          end
        end

        directory 'environments' do
          file 'production.rb' do
            contains 'config.assets.precompile += %w(editing.css editing.js)'
          end
        end

        file 'application.rb' do
          contains "config.time_zone = 'Berlin'"
        end
      end

      directory 'vendor' do
        directory 'assets' do
          directory 'javascripts' do
            file 'jquery-ui-timepicker-addon.min.js'
          end

          directory 'stylesheets' do
            file 'jquery-ui-timepicker-addon.min.css'
          end
        end
      end

      file 'Gemfile' do
        contains 'gem "jquery-ui-rails"'
      end
    }
  end
end
