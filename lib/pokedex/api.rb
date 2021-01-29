class API 
    def self.pokemon_name 
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/")
        pokemon_hash = JSON.parse(response.body)["results"]
        pokemon_hash.each do |pokemon|
            Pokemon.new(pokemon["name"])
        end
    end
    
    def self.get_data(pokemon)
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/#{pokemon}")
        pokemon = Pokemon.find_by_name(pokemon)[0]
        moves_hash = JSON.parse(response.body)["moves"].map do |move|
            move["move"]["name"] 
        end
        abilities_hash = JSON.parse(response.body)["abilities"].map do |ability|
            ability["ability"]["name"]
        end
        pokemon.type = JSON.parse(response.body)["types"][0]["type"]["name"]
        pokemon.moves = moves_hash.join(", ")
        pokemon.ability = abilities_hash.join(", ")
        pokemon
    end
end
