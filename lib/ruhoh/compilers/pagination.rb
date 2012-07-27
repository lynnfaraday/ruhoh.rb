class Ruhoh
  module Compiler
    module Pagination   
      def self.run(target, page)
        
        # We're basically just replicating index.html over and over with 
        # different pagination content.
        page.change('index.html')

        base_dir = target + "/index"
        FileUtils.mkdir_p base_dir

        Ruhoh::DB.payload['db']['posts']['pagination']['index_pages'].each do |p|  
          if (p['page_number'] == 1)
            # Index.html is rendered separately
            next
          else
            dir = "#{base_dir}/#{p['page_number']}"
            FileUtils.mkdir_p dir
            file_name = "#{dir}/index.html"
          end
          
          Ruhoh::Friend.say { green "processed: #{file_name}" }          
          
          File.open(file_name, 'w:UTF-8') do |file|
            page.data['pagination'] = p
            file.puts page.render
          end
        end
      end # self.run
    end # Pagination
  end # Compiler
end # Ruhoh