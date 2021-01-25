class Api::Pokemon
    attr_accessor :name

    @@all  = []

    def initialize(name)
        @name    = name
        @@all    << self
    end

    def self.all
        @@all
    end

    def self.find_by_name
        @@all.each do |n|
            if n.name.downcase == name.downcase
                return n 
            end
        end
    end
    
end