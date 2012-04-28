class Ruhoh
  module Programs
    
    # Public: A program for running ruhoh as a rack application
    # which renders singular pages via their URL.
    # 
    # Examples
    #
    #  In config.ru:
    #
    #   require 'ruhoh'
    #   run Ruhoh::Programs.preview
    # 
    # this whole program is the "preview" event
    def self.preview
      Ruhoh::Event.setup
      Ruhoh::Event.database
      Ruhoh::Event.preview
    end
    
    # Public: A program for compiling the ruhoh blog.
    # this whole program is the compile event
    def self.compile
      Ruhoh::Event.setup
      Ruhoh::Event.database
      Ruhoh::Event.compile
    end
    
  end #Programs
end #Ruhoh