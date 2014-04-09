require 'rake'
require 'rake/tasklib'

require 'scrival_kickstarter/rake/configuration_helper'
require 'scrival_kickstarter/rake/cms_client'

module ScrivalKickstarter
  module Rake
    class IntegrationTask < ::Rake::TaskLib
      def initialize
        namespace :test do
          desc 'Run Kickstarter Integration Tests'

          task :reset do
            reset_cms
          end

          task :integration do
            create_application
            create_configuration_files

            cd(app_path) do
              Bundler.with_clean_env do
                bundle
                call_generators
                reset_cms
                migrate
                publish
              end
            end
          end

          task :app do
            create_application
            create_configuration_files

            cd(app_path) do
              Bundler.with_clean_env do
                bundle
                call_generators
              end
            end
          end
        end
      end

      private

      def create_application
        rm_rf(app_path)

        sh("rails new #{app_path} --skip-test-unit --skip-active-record --skip-bundle --template lib/scrival_kickstarter/rake/template.rb")
      end

      def create_configuration_files
        path = Pathname.new(app_path) + 'config'
        ConfigurationHelper.new(path).copy
      end

      def bundle
        sh('bundle --quiet')
      end

      def reset_cms
        CmsClient.new.reset_cms
      end

      def call_generators
        generators = [
          'cms:kickstart --examples',
          'cms:component:redirect',
          'cms:component:deployment --provider=opsworks',
          'cms:component:language_switch',
          'cms:component:language_switch:example',
          'cms:component:social_sharing',
          'cms:component:social_sharing:example',
          'cms:component:breadcrumbs',
          'cms:widget:accordion',
          'cms:widget:accordion:example',
          'cms:widget:video',
          'cms:widget:video:example',
          'cms:widget:youtube',
          'cms:widget:youtube:example',
          'cms:widget:vimeo',
          'cms:widget:vimeo:example',
          'cms:widget:diagram',
          'cms:widget:diagram:example',
          'cms:widget:flickr',
          'cms:widget:flickr:example',
          'cms:widget:slider',
          'cms:widget:slider:example',
          'cms:widget:slideshare',
          'cms:widget:slideshare:example',
          'cms:widget:text_image',
          'cms:widget:text_image:example',
        ]
        generators.each do |generator|
          sh("rails generate #{generator}")
        end
      end

      def migrate
        sh('bundle exec rake cms:migrate')
      end

      def publish
        sh('bundle exec rake cms:migrate:publish')
      end

      def app_path
        File.expand_path('../../../../tmp/test_app', __FILE__)
      end
    end
  end
end
