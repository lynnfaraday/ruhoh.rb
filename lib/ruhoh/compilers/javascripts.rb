class Ruhoh
  module Compiler
    module CompileMedia

      # Create all the javascripts.
      # Javascripts may be registered from either a theme or a widget.
      # Technically the theme compiler may create javascripts relative to the theme.
      # This ensures the widget javascripts are created as well.
      def self.run(target, opts)
        Ruhoh::DB.javascripts.each do |type, assets|
          assets.each do |asset|
            url = asset['url'].gsub(/^\//, '')
            next unless File.exist?(asset['id'])
            file_path = Ruhoh::Utils.url_to_path(File.dirname(url), target)
            FileUtils.mkdir_p file_path
            FileUtils.cp(asset['id'], file_path)
          end
        end
      end

    end # CompileMedia
  end # Compiler
end #Ruhoh