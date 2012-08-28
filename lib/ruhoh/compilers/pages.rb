class Ruhoh
  module Compiler
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
  end # Compiler
end #Ruhoh