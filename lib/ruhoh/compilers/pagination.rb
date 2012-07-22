class Ruhoh
  module Compiler
    module Pagination   
      def self.run(target, page)
        page.change('index.html')
        posts_db = Ruhoh::DB.payload['db']['posts']
        posts_db['pagination'].each do |p|             
          File.open(target + "/index#{p['page_number']}.html", 'w:UTF-8') do |index_file|
            page.data['layout'] = "index_page"
            p['posts'] = self.to_posts(p['posts'], posts_db)
            page.data['pagination'] = p
            index_file.puts page.render
          end
        end
      end # self.run
      
      def self.to_posts(abbreviated_posts, posts_db)
         Array(abbreviated_posts).map { |id|
             posts_db['dictionary'][id]
          }.compact
      end
    end # Pagination
  end # Compiler
end # Ruhoh