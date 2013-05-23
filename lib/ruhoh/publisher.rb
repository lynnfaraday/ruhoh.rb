class Ruhoh
  module Publisher
    def self.publish(opts)
      pages = Ruhoh::Compiler.pages_to_process(opts)
      target = Ruhoh::Compiler.target_dir(opts)
      host = Ruhoh::DB.site['config']['publish']['host']
      root = Ruhoh::DB.site['config']['publish']['root']

      # If there are a lot of pages changed, it's more efficient to 
      # just copy everything, but if there are only a few it's actually
      # faster to rebuild them and copy them one by one.
      if (pages.count < 10)
        page = Ruhoh::Page.new
        pages.each_value do |p|
          page.change(p['id'])
          system "scp -r #{target}/#{page.compiled_path} #{host}:#{root}/#{page.compiled_path}"
        end
      else
        system "scp -r #{target}/posts #{host}:#{root}"
      end
      
      system "scp -r #{target}/index/* #{host}:#{root}/index"
      system "scp #{target}/*rss.xml #{host}:#{root}"      
    end
  end
end