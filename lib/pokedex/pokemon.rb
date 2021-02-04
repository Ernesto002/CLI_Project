class Pokemon 
    attr_accessor :name, :type, :moves, :ability

    @@all = []

    def initialize(name) 
        @name = name 
        save
    end

    def save 
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_name(name)
        self.all.select do |x|
            x.name == name
        end
    end
end
