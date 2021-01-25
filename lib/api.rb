class Api 

    URL              = 'https://pokeapi.co/api/v2/'
    ENDPOINTS        = %W(pokemon ability move)
    POKEMONPAGE      = '?offset=1&limit=1118'
    ABILITYPAGE      = '?offset=1&limit=327'
    MOVEPAGE         = '?offset=1&limit=813'

    def self.get_pokemon_endpoint(endpoint)
        pokemon_url = URL + endpoint + '/' + POKEMONPAGE
        self.call_api(pokemon_url)
    end

    def self.get_ability_endpoint(endpoint)
        ability_url = URL + endpoint + '/' + ABILITYPAGE
        self.call_api(ability_url)
    end

    def self.get_move_endpoint(endpoint)
        move_url = URL + endpoint + '/' + MOVEPAGE
        self.call_api(move_url)
    end

    def self.search_endpoint(endpoint, search_term)
        search_url = URL + endpoint + '/' + search_term 
        self.call_api(search_url) 
    end

    def self.call_api(url)
        HTTParty.get(url)
    end
end