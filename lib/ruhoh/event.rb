require 'observer'
class Ruhoh
  class Event
    class << self
      include Observable
      
      def trigger(event)
        self.changed
        self.notify_observers(event)
      end
      
      # The setup event
      def setup
        Ruhoh::Event.trigger(:before_setup)
        Ruhoh.setup
        Ruhoh::Event.trigger(:after_setup)
      end
      
      def database
        Ruhoh::Event.trigger(:before_database)
        Ruhoh::DB.update_all
        Ruhoh::Event.trigger(:after_database)
      end
      
      # page event
      def page
        Ruhoh::Event.trigger(:before_page)
        page = Ruhoh::Page.new
        Ruhoh::Event.trigger(:after_page)
        page
      end

      def preview
        page = Ruhoh::Event.page
        Ruhoh::Watch.start
        Rack::Builder.new {
          use Rack::Lint
          use Rack::ShowExceptions
          use Rack::Static, {:urls => ["/#{Ruhoh.folders.media}", "/#{Ruhoh.folders.templates}"]}
          run Ruhoh::Previewer.new(page)
        }
      end
      
      def compile
        page = Ruhoh::Event.page
        compiler = Ruhoh::Compiler.new
        compiler.page = page
        compiler.compile
      end
      
    end
  end #Event
end #Ruhoh