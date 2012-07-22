class Ruhoh
  module Compiler
    module Pagination   
      def self.run(target, page)
        page.change('index.html')
        posts_db = Ruhoh::DB.payload['db']['posts']
        posts_db['pagination'].each do |p|             
          File.open(target + "/index#{p['page_number']}.html", 'w:UTF-8') do |index_file|
            page.data['layout'] = "index_page"
            page.data['pagination'] = p
            index_file.puts page.render
          end
        end
      end # self.run
    end # Pagination
  end # Compiler
end # Ruhoh