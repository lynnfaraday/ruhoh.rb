module Ruhoh::Views::Helpers
  module Paginator
    # current_page is set via a compiler or previewer
    # in which it can discern what current_page to serve
    def paginator
      per_page = config["paginator"]["per_page"] rescue 5
      current_page = master.page_data['current_page'].to_i
      current_page = current_page.zero? ? 1 : current_page
      offset = (current_page-1)*per_page

      page_batch = all[offset, per_page]
      raise "Page does not exist" unless page_batch
      page_batch
    end

    def paginator_navigation
      page_count = all.length
      paginator_config = config["paginator"] || {}
      total_pages = (page_count.to_f/paginator_config["per_page"]).ceil
      current_page_number = master.page_data['current_page'].to_i
      current_page_number = current_page_number.zero? ? 1 : current_page_number
      current_page_index = current_page_number - 1
      
      prev = []
      for i in 10.downto(1)
        if current_page_number - i >= 1
          prev << {
            "page_number" => current_page_number - i,
            "url" => paginator_url(current_page_index - i, paginator_config, total_pages)
            }
          end
      end
      
      more_prev = {
        "page_number" => current_page_number - 11,
        "url" => paginator_url(current_page_index - 11, paginator_config, total_pages)
        }
        
        more_next = {
          "page_number" => current_page_number + 11,
          "url" => paginator_url(current_page_index + 11, paginator_config, total_pages)
          }
          
      nxt = []
      for i in 1.upto(10)
        if current_page_number + i < total_pages
          nxt << {
            "page_number" => current_page_number + i,
            "url" => paginator_url(current_page_index + i, paginator_config, total_pages)
            }
          end
      end
      
      {
        "current" => current_page_number,       
        "prev" => prev,
        "next" => nxt,
        "more_prev" => more_prev,
        "more_next" => more_next        
      }
    end
    
    def paginator_url(page_index, paginator_config, total_pages)
      return nil if page_index < 0
      return nil if page_index >= total_pages
      
      url = if page_index.zero? && paginator_config["root_page"]
        paginator_config["root_page"]
      else
        "#{paginator_config["url"]}/#{page_index + 1}"
      end
      ruhoh.to_url(url)  
    end
  end
end