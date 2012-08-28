class Ruhoh
  # Public: Rack application used to render singular pages via their URL.
  # 
  # This class depends on a correctly loaded Ruhoh environment;
  # it should only be used as part of a Ruhoh 'program' routine.
  # See Ruhoh::Program for usage.
  #
  class Previewer
    
    def initialize(page)
      Ruhoh.config.env ||= 'development'
      @page = page
    end

    def call(env)
      return favicon if env['PATH_INFO'] == '/favicon.ico'
      # Always remove trailing slash if sent unless it's the root page.
      env['PATH_INFO'].gsub!(/\/$/, '') unless env['PATH_INFO'] == "/"
      return admin if env['PATH_INFO'] == Ruhoh.urls.dashboard
      return pagination($~[1]) if env['PATH_INFO'].match(/\/index\/(\d+)\/?/)
      
      id = Ruhoh::DB.routes[env['PATH_INFO']]
      raise "Page id not found for url: #{env['PATH_INFO']}" unless id
      @page.change(id)

      [200, {'Content-Type' => 'text/html'}, [@page.render]]
    end
    
    def favicon
      [200, {'Content-Type' => 'image/x-icon'}, ['']]
    end

    def pagination(page_number)
      pagination_data = Ruhoh::DB.payload['db']['posts']['pagination']['index_pages'][(page_number.to_i - 1)]
      if pagination_data.nil?
        raise "Page does not exist. Your current pagination settings " +
              "call for only #{Ruhoh::DB.payload['db']['posts']['pagination']['index_pages'].length} pages."
      end
      @page.change(Ruhoh.config.pagination_base_page)
      @page.data['pagination'] = pagination_data
      return [200, {'Content-Type' => 'text/html'}, [@page.render]]
    end
    
    def admin
      template = nil
      [
        Ruhoh.paths.theme_dashboard_file,
        Ruhoh.paths.dashboard_file,
        Ruhoh.paths.system_dashboard_file
      ].each do |path|
        template = path and break if File.exist?(path)
      end
      template = File.open(template, 'r:UTF-8') {|f| f.read }
      output = @page.templater.render(template, Ruhoh::DB.payload)
      
      [200, {'Content-Type' => 'text/html'}, [output]]
    end
        
  end #Previewer
end #Ruhoh