require 'rake'
require 'rake/tasklib'
require 'yaml'

module ScrivalKickstarter
  module Rake
    class TravisTask < ::Rake::TaskLib
      def initialize
        desc 'Turn configuration variables into travis secure environment variables'

        task :travis_encrypt do
          travis_encrypt
        end

        task travis: ['spec', 'test:integration']
      end

      private

      def travis_encrypt
        if %x{which travis}.empty?
          puts 'Please make sure to install the travis command line client with
            `gem install travis` and then run the rake task again.'

          return
        end

        configuration = {
          'CONTENT_SERVICE_URL' => content_service_config['url'],
          'CONTENT_SERVICE_LOGIN' => content_service_config['login'],
          'CONTENT_SERVICE_API_KEY' => content_service_config['api_key'],
          'CMS_URL' => cms_config['url'],
          'CMS_LOGIN' => cms_config['login'],
          'CMS_API_KEY' => cms_config['api_key'],
        }

        contributor = %x(whoami).strip

        puts "Please add the following to your .travis.yml file:\n\n"
        puts "# #{contributor}'s credentials"

        Bundler.with_clean_env do
          configuration.map do |key, value|
            token = %x{travis encrypt #{key}=#{value}}

            puts "- secure: #{token}"
          end
        end
      end

      def content_service_config
        YAML.load_file('config/scrival.yml')['content_service']
      end

      def cms_config
        YAML.load_file('config/scrival.yml')['cms_api']
      end
    end
  end
end
