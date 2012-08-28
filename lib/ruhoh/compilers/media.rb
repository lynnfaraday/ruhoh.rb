class Ruhoh
  module Compiler
    module CompileMedia

      def self.run(target, opts)
        return unless FileTest.directory? Ruhoh.paths.media
        url = Ruhoh.urls.media.gsub(/^\//, '')
        media = Ruhoh::Utils.url_to_path(url, target)
        FileUtils.mkdir_p media
        FileUtils.cp_r File.join(Ruhoh.paths.media, '.'), media
      end

    end # CompileMedia
  end # Compiler
end #Ruhoh