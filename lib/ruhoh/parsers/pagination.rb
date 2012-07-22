class Ruhoh
  module Parsers
    module Posts

      class Paginator
        def initialize(posts_per_page, posts)
          @posts_per_page = posts_per_page
          @posts = posts
        end

        def get_page(page_number)
          page_index = page_number - 1
          if (@pages == nil || page_index < 0 || page_index > @pages.count - 1)
            return nil
          end 
          return @pages[page_index]
        end

        def paginate
          total_posts = @posts.count
          @pages = []
          if (@posts_per_page == nil)
            @pages << build_page_metadata(0, 1, total_posts, @posts)
          else
            total_pages = (total_posts.to_f / @posts_per_page).ceil
            (0..total_pages - 1).each do |page_index|
              current_page_posts = @posts[page_index * @posts_per_page, @posts_per_page]        
              @pages << build_page_metadata(page_index, total_pages, total_posts, current_page_posts)
            end
          end
          @pages
        end

        def build_page_metadata(page_index, total_pages, total_posts, posts)
          page_number = page_index + 1
          {
            'page_number'   => page_number,
            'total_pages'   => total_pages,
            'total_posts'   => total_posts,
            'per_page'      => @posts_per_page,
            'posts'         => posts.map { |p| p['id'] },       
            'previous_page' => page_index == 0 ? nil : page_number - 1,
            'next_page'     => page_index == total_pages - 1 ? nil : page_number + 1
          }
        end

      end
    end
  end
end