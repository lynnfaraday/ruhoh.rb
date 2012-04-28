class Ruhoh
  module Templaters
    module Base
    
      def build_payload(page=nil)
        {
          "db" => {
            "pages" =>  Ruhoh::DB.pages,
            "posts" => Ruhoh::DB.posts,
          },
          "page" => (page ? page.attributes : {}),
          "site" => Ruhoh::DB.site,
          "paths" => {
            "theme"   => Ruhoh.config.theme_path,
            "syntax"  => Ruhoh.config.syntax_path,
            "media"   => Ruhoh.config.media_path
          }
        }
      end
    
      # Render a given page object.
      # This is different from parse only in that rendering a page
      # assumes we use page.content and its layouts as the incoming view.
      def render(page)
        parse(expand(page), page)
      end

      # Parse arbitrary content relative to a given page.
      def parse(output, page)
        Ruhoh::Templaters::RMustache.render(output, build_payload(page))
      end
    
      # Expand the page.
      # Places page content into sub-template then into master template if available.
      def expand(page)
        if page.sub_layout
          output = page.sub_layout['content'].gsub(Ruhoh::Utils::ContentRegex, page.content)
        else
          output = page.content
        end

        # An undefined master means the page/post layouts is only one deep.
        # This means it expects to load directly into a master template.
        if page.master_layout && page.master_layout['content']
          output = page.master_layout['content'].gsub(Ruhoh::Utils::ContentRegex, output);
        end
      
        output
      end
    
    end #Base
  end #Templaters
end #Ruhoh