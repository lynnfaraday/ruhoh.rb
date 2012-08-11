class Ruhoh
  module Compiler
    module Pagination   
      def self.run(target, opts)
        
        # We're basically just replicating index.html over and over with 
        # different pagination content.
        page = Ruhoh::Page.new
        page.change(Ruhoh.config.pagination_base_page)

        base_dir = target + "/index"
        FileUtils.mkdir_p base_dir

        Ruhoh::Friend.say { green "Creating pagination files." }

        Ruhoh::DB.payload['db']['posts']['pagination']['index_pages'].each do |p|  
            dir = "#{base_dir}/#{p['page_number']}"
            FileUtils.mkdir_p dir
            file_name = "#{dir}/index.html"
                    
          File.open(file_name, 'w:UTF-8') do |file|
            page.data['pagination'] = p
            file.puts page.render
          end
        end
      end # self.run            
    end # Pagination
  end # Compiler
end # Ruhoh