class Ruhoh
  module Parsers
    module Posts

      class Paginator
        
        PagesToShowBeforeAndAfter = 3
        
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
            'prev'          => prev_indices(page_number),
            'next'          => next_indices(page_number, total_pages),
            'prev_truncated'=> prev_truncated(page_number),
            'next_truncated'=> next_truncated(page_number, total_pages)
            
          }
        end
                
        def prev_indices(page_number)
          return nil if page_number == 1
          prev_start = page_number - PagesToShowBeforeAndAfter
          prev = []
          for p in (prev_start..page_number - 1)
            if (p < 1)
              next
            end
            prev << { 'page_number' => p, 'url' => index_page_url(p) }
          end
          prev
        end
        
        def prev_truncated(page_number)
          prev = page_number - PagesToShowBeforeAndAfter - 1
          prev > 0 ? index_page_url(prev) : nil
        end
        
        
        def next_indices(page_number, total_pages)
          return nil if page_number == total_pages
          next_end = page_number + PagesToShowBeforeAndAfter
          next_pages = []
          for p in (page_number + 1..next_end)
            if (p > total_pages)
              next
            end
            next_pages << { 'page_number' => p, 'url' => index_page_url(p) }
          end
          next_pages
        end
        
        def next_truncated(page_number, total_pages)
          next_shown = page_number + PagesToShowBeforeAndAfter + 1
          next_shown <= total_pages  ? index_page_url(next_shown) : nil
        end

        def get_next_index_page(page_number, total_pages)
          return nil if page_number == total_pages
           index_page_url(page_number + 1)
        end
        
        def index_page_url(page_number)
          page_number == 1 ? "/" : "/index/#{page_number}/"
        end

      end
    end
  end
end