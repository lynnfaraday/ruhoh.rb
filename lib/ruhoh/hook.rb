class Ruhoh
  class Hook
    class << self
      attr_accessor :setup, :database, :page
    end
    
    def self.inherited(base)
      puts 'inherited'
      subclasses << base
    end

    def self.subclasses
      @subclasses ||= []
    end
    
    def self.page
      @page ||= []
    end
          
    def self.run(event)
      puts 'RUN'
      if event == :as_page
        puts 'as page'
        self.page << self.ancestors[0]
      end
    end
      
  end #Hook
end #Ruhoh
