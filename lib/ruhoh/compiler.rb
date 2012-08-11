require 'ruhoh/compilers/theme'
require 'ruhoh/compilers/rss'
require 'ruhoh/compilers/pagination'

class Ruhoh
  module Compiler

    # TODO: seems rather dangerous to delete the incoming target directory?
    def self.compile(opts)
      Ruhoh::Friend.say { plain "Compiling for environment: '#{Ruhoh.config.env}'" }
      post = opts['post'] rescue nil
      target = self.target_dir(opts)
      clean = true if post.nil?

      if (clean)      
        Ruhoh::Friend.say { green "Erasing directory #{target}." }
        FileUtils.rm_r target if File.exist?(target)
        FileUtils.mkdir_p target
      elsif (!File.exist?(target))
        raise "Cannot do partial compile if the directory doesn't exist."
      end

      self.constants.each {|c|
        task = self.const_get(c)
        next unless task.respond_to?(:run)
        task.run(target, opts)
      }  
      true
    end
    
    def self.target_dir(opts)
      target = opts['target'] rescue nil
      target = "#{Ruhoh.names.compiled}" if target.nil?
      target
    end
    
    def self.pages_to_process(opts)
      post_name = opts['post'] rescue nil
      
      if (post_name.nil?)
        pages = Ruhoh::DB.all_pages
      else
        pages = Ruhoh::DB.pages
        post_name = "posts/#{post_name}"
        post = Ruhoh::DB.posts['dictionary'][post_name]
        if (post.nil?)
          raise "Cannot find post #{post_name}."
        end
        pages[post_name] = post
      end
      pages
    end
    
    module CompilePages
      def self.run(target, opts)        
        pages = Ruhoh::Compiler.pages_to_process(opts)
        page = Ruhoh::Page.new

        FileUtils.cd(target) {
          pages.each_value do |p|
            page.change(p['id'])
            self.process_page(page)
          end
        }
      end

      def self.process_page(page)
        FileUtils.mkdir_p File.dirname(page.compiled_path)
        File.open(page.compiled_path, 'w:UTF-8') { |p| p.puts page.render }
        Ruhoh::Friend.say { green "processed: #{page.id}" }
      end
    end

    module CompileMedia

      def self.run(target, opts)
        return unless FileTest.directory? Ruhoh.paths.media
        media = Ruhoh::Utils.url_to_path(Ruhoh.urls.media, target)
        FileUtils.mkdir_p media
        FileUtils.cp_r File.join(Ruhoh.paths.media, '.'), media
      end

    end 

  end #Compiler
end #Ruhoh