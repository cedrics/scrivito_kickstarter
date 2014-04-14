require 'uri'

module Cms
  module Generators
    class KickstartGenerator < ::Rails::Generators::Base
      include Migration

      class_option :examples,
        type: :boolean,
        default: false,
        desc: 'Creates example content along with setting up your project.'

      source_root File.expand_path('../templates', __FILE__)

      def install_gems
        gem('haml-rails')

        Bundler.with_clean_env do
          run('bundle --quiet')
        end
      end

      def remove_erb_layout
        path = Rails.root + 'app/views/layouts/application.html.erb'

        if File.exist?(path)
          remove_file(path)
        end
      end

      def extend_gitignore
        destination = '.gitignore'

        if File.exist?(destination)
          append_file(destination, "config/scrival.yml\n")
        end
      end

      def set_timezone
        gsub_file(
          'config/application.rb',
          "# config.time_zone = 'Central Time (US & Canada)'",
          "config.time_zone = 'Berlin'"
        )

        log(:info, "set timezone to 'Berlin'")
      end

      def update_production_environment
        data = []

        data << '# Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)'
        data << '  config.assets.precompile += %w(editing.css editing.js)'
        data << ''

        data = data.join("\n")

        environment(data, env: :production)

        log(:environment, 'production: config.assets.precompile += %w(editing.css editing.js)')
      end

      def create_structure_migration_file
        migration_template('migration.rb', 'cms/migrate/kickstart.rb')
        migration_template('create_structure.rb', 'cms/migrate/create_structure.rb')
      rescue Rails::Generators::Error
      end

      def override_application
        directory('lib')
        directory('config')
        directory('app', force: true)
      end

      def create_example_content
        if examples?
          Rails::Generators.invoke('cms:component:sitemap', [], behavior: behavior)
          Rails::Generators.invoke('cms:kickstart:example', [], behavior: behavior)
        end
      end

      private

      def examples?
        options[:examples]
      end
    end
  end
end
