class Ruhoh
  module Compiler
    module Theme
      
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
      end
    end #Theme
  end #Compiler
end #Ruhoh