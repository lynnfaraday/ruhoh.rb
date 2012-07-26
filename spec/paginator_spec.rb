require "test/unit"
require "ap"
require 'ruhoh'

class PaginatorTests < Test::Unit::TestCase 
   def setup()      
     @ten_posts = [ 
      { 'title' => "A", 'content' => "My A", 'id' => "A"}, 
      { 'title' => "B", 'content' => "My B", 'id' => "B" }, 
      { 'title' => "C", 'content' => "My C", 'id' => "C" }, 
      { 'title' => "D", 'content' => "My D", 'id' => "D" }, 
      { 'title' => "E", 'content' => "My E", 'id' => "E" },
      { 'title' => "F", 'content' => "My F", 'id' => "F" }, 
      { 'title' => "G", 'content' => "My G", 'id' => "G" }, 
      { 'title' => "H", 'content' => "My H", 'id' => "H" }, 
      { 'title' => "I", 'content' => "My I", 'id' => "I" }, 
      { 'title' => "J", 'content' => "My J", 'id' => "J" } 
    ]

    @five_posts = [ 
      { 'title' => "A", 'content' => "My A", 'id' => "A"}, 
      { 'title' => "B", 'content' => "My B", 'id' => "B" }, 
      { 'title' => "C", 'content' => "My C", 'id' => "C" }, 
      { 'title' => "D", 'content' => "My D", 'id' => "D" }, 
      { 'title' => "E", 'content' => "My E", 'id' => "E" } ]

      @one_post = [ { 'title' => "A", 'content' => "My A", 'id' => "A" } ]

      @no_posts = []
   end

    def test_five_posts_two_posts_per_page_page_count
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      assert_equal(3, pages.count)
    end

    def test_five_posts_four_posts_per_page_count
      pg = Ruhoh::Parsers::Posts::Paginator.new(4, @five_posts)
      pages = pg.paginate()
      assert_equal(2, pages.count)
    end

    def test_five_posts_one_posts_per_page_count
      pg = Ruhoh::Parsers::Posts::Paginator.new(1, @five_posts)
      pages = pg.paginate()
      assert_equal(5, pages.count)
    end

    def test_one_post_many_posts_per_page_count
      pg = Ruhoh::Parsers::Posts::Paginator.new(3, @one_post)
      pages = pg.paginate()
      assert_equal(1, pages.count)
    end  

    def test_one_post_one_per_page_count
      pg = Ruhoh::Parsers::Posts::Paginator.new(1, @one_post)
      pages = pg.paginate()
      assert_equal(1, pages.count)
    end 

    def test_no_posts_count
      pg = Ruhoh::Parsers::Posts::Paginator.new(3, @no_posts)
      pages = pg.paginate()
      assert_equal(0, pages.count)
    end 

    def test_first_page_metadata
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      assert_equal(1, pages[0]['page_number'])
      assert_equal(2, pages[0]['per_page'])
      assert_equal(3, pages[0]['total_pages'])
      assert_equal(5, pages[0]['total_posts'])
    end

    def test_first_page_posts
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      assert_equal(2, pages[0]['posts'].count)
      assert_equal("A", pages[0]['posts'][0])
      assert_equal("B", pages[0]['posts'][1])
    end

    def test_second_page_metadata
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      assert_equal(2, pages[1]['page_number'])
      assert_equal(2, pages[1]['per_page'])
      assert_equal(3, pages[1]['total_pages'])
      assert_equal(5, pages[1]['total_posts'])
    end

    def test_second_page_posts
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      assert_equal(2, pages[1]['posts'].count)
      assert_equal("C", pages[1]['posts'][0])
      assert_equal("D", pages[1]['posts'][1])
    end

    def test_third_page_metadata
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      assert_equal(3, pages[2]['page_number'])
      assert_equal(2, pages[2]['per_page'])
      assert_equal(3, pages[2]['total_pages'])
      assert_equal(5, pages[2]['total_posts'])
    end

    def test_third_page_posts
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      assert_equal(1, pages[2]['posts'].count)
      assert_equal("E", pages[2]['posts'][0])
    end

    def test_get_pages_returns_nil_if_not_paginated
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      assert_equal(nil, pg.get_page(1))
    end

    def test_get_pages_returns_nil_if_index_out_of_range
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      assert_equal(nil, pg.get_page(0))
      assert_equal(nil, pg.get_page(4))
    end

    def test_get_pages_returns_page
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      page = pg.get_page(1)
      assert_equal(1, page['page_number'])
    end
    
    def test_returns_all_pages_if_per_page_nil
      pg = Ruhoh::Parsers::Posts::Paginator.new(nil, @five_posts)
      pages = pg.paginate()  
      assert_equal(1, pages.count)
      assert_equal(5, pages[0]['posts'].count)
    end

    def test_previous_nil_for_first_page
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      page = pg.get_page(1)
      assert_equal(nil, page['prev'])
    end

    def test_next_nil_for_last_page
      pg = Ruhoh::Parsers::Posts::Paginator.new(2, @five_posts)
      pages = pg.paginate()
      page = pg.get_page(3)
      assert_equal(nil, page['next'])
    end
    
    # 0 1 2  3   4
    # x x x (C)  - 
    def test_previous_when_fewer_than_three_prev_pages
      pg = Ruhoh::Parsers::Posts::Paginator.new(1, @five_posts)
      pages = pg.paginate()
      page = pages[3]
      assert_equal([1, 2, 3],  page['prev'].map {|p| p['page_number']})
      assert_equal(['/', '/index/2/', '/index/3/'], page['prev'].map { |p| p['url'] })
      assert_equal(nil, page['prev_truncated'])
    end

    # 0 1 2 3 4 
    # * x x x (C) 
    def test_previous_when_more_than_three_prev_pages
      pg = Ruhoh::Parsers::Posts::Paginator.new(1, @five_posts)
      pages = pg.paginate()
      page = pages[4]
      assert_equal([2, 3, 4],  page['prev'].map {|p| p['page_number']})      
      assert_equal(['/index/2/', '/index/3/', '/index/4/'], page['prev'].map { |p| p['url'] })
      assert_equal('/', page['prev_truncated'])
    end


    #  0  1  2 3 4
    #  - (C) x x x
    def test_next_not_truncated_when_fewer_than_three_next_pages
      pg = Ruhoh::Parsers::Posts::Paginator.new(1, @five_posts)
      pages = pg.paginate()
      page = pages[1]
      assert_equal([3, 4, 5],  page['next'].map {|p| p['page_number']})
      assert_equal(['/index/3/', '/index/4/', '/index/5/'], page['next'].map { |p| p['url'] })
      assert_equal(nil, page['next_truncated'])
    end

    #  0   1 2 3 4
    #  (C) x x x *
    def test_next_is_truncated_when_more_than_three_next_pages
      pg = Ruhoh::Parsers::Posts::Paginator.new(1, @five_posts)
      pages = pg.paginate()
      page = pages[0]
      assert_equal([2, 3, 4],  page['next'].map {|p| p['page_number']})      
      assert_equal(['/index/2/', '/index/3/', '/index/4/'], page['next'].map { |p| p['url'] })
      assert_equal('/index/5/', page['next_truncated'])
    end
end