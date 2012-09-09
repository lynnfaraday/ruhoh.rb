class Ruhoh
  module Publisher
    def self.publish(opts)
      pages = Ruhoh::Compiler.pages_to_process(opts)
      target = Ruhoh::Compiler.target_dir(opts)
      host = Ruhoh::DB.site['config']['publish']['host']
      root = Ruhoh::DB.site['config']['publish']['root']

      page = Ruhoh::Page.new
      pages.each_value do |p|
        page.change(p['id'])
        system "scp -r #{target}/#{page.compiled_path} #{host}:#{root}/#{page.compiled_path}"
      end
      system "scp -r #{target}/index/* #{host}:#{root}/index"
      system "scp #{target}/rss.xml #{host}:#{root}/rss.xml"      
    end
  end
end