class NycShows::Show

    attr_accessor :name, :url, :location, :duration, :story, :genre

    @@all = []

    def initialize(shows_hash)
        @name = shows_hash[:name]
        @url = shows_hash[:url]
        @location = shows_hash[:location]
        @duration = shows_hash[:duration]
        @story = shows_hash[:story]
        @genre = shows_hash[:genre]
        @@all << self
    end

    def self.all
        @@all
    end
    
    def add_show_attributes(attr_hash)
        @location = attr_hash[:location]
        @duration = attr_hash[:duration]
        @story = attr_hash[:story]
        @genre = attr_hash[:genre]
    end
    
    def self.create_new(show_hash)
        self.new(show_hash)
        # show_hash.each {|show| self.new(show_hash)}
    end

    def self.find_by_name(name)
        @@all.find {|show| show.name == name}
    end
      
    def self.find_or_create_by_name(show_hash)
        self.find_by_name(show_hash[:name]) || self.create_new(show_hash)
    end

end