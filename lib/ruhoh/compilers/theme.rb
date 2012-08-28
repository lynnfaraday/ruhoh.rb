class Ruhoh
  module Compiler
    module Theme
      
<<<<<<< HEAD
      def self.run(target, opts)
        self.stylesheets(target, opts)
        self.javascripts(target, opts)
        self.media(target, opts)
      end
      
      def self.stylesheets(target, opts)
        Ruhoh::DB.stylesheets.each do |type, assets|
          assets.each do |asset|
            next unless File.exist?(asset['id'])
            file_path = Ruhoh::Utils.url_to_path(File.dirname(asset['url']), target)
            FileUtils.mkdir_p file_path
            FileUtils.cp(asset['id'], file_path)
          end
        end
      end

      def self.javascripts(target, opts)
        Ruhoh::DB.javascripts.each do |type, assets|
          assets.each do |asset|
            next unless File.exist?(asset['id'])
            file_path = Ruhoh::Utils.url_to_path(File.dirname(asset['url']), target)
            FileUtils.mkdir_p file_path
            FileUtils.cp(asset['id'], file_path)
          end
        end
      end
      
      def self.media(target, opts)
        return unless FileTest.directory? Ruhoh.paths.theme_media
        theme_media = Ruhoh::Utils.url_to_path(Ruhoh.urls.theme_media, target)
        FileUtils.mkdir_p theme_media
        FileUtils.cp_r File.join(Ruhoh.paths.theme_media, '.'), theme_media
=======
      def self.run(target, page)
        self.copy(target, page)
      end

      # Copies all theme assets over to the compiled site.
      # Note the compiled assets are namespaced at /assets/<theme-name>/
      # theme.yml may specify exclusion rules for excluding assets.
      def self.copy(target, page)
        url = Ruhoh.urls.theme.gsub(/^\//, '')
        theme = Ruhoh::Utils.url_to_path(url, target)
        FileUtils.mkdir_p theme

        self.files.each do |file|
          original_file = File.join(Ruhoh.paths.theme, file)
          compiled_file = File.join(theme, file)
          FileUtils.mkdir_p File.dirname(compiled_file)
          FileUtils.cp_r original_file, compiled_file
        end
      end
      
      # Returns list of all files from the theme that need to be
      # compiled to the production environment.
      # Returns Array of relative filepaths
      def self.files
        FileUtils.cd(Ruhoh.paths.theme) {
          return Dir["**/*"].select { |filepath|
            next unless self.is_valid_asset?(filepath)
            true
          }
        }
>>>>>>> 9dd1d6f1f3f8ca70745e5e8ee1d4e43a736a6d99
      end

      # Checks a given asset filepath against any user-defined exclusion rules in theme.yml
      def self.is_valid_asset?(filepath)
        return false if FileTest.directory?(filepath)
        Ruhoh::DB.theme_config["exclude"].each {|regex| return false if filepath =~ regex }
        true
      end
      
    end #Theme
  end #Compiler
end #Ruhoh