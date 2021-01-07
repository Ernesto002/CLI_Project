class CLI

    def start
        input = ''
        welcome_image
        puts "Welcome to the Pokedex!"
        welcome_menu
    end

    def prompt
        puts "Enter '1' for a list of all Pokemon!"
        puts "Enter '2' for a list of all Pokemon special abilities!"
        puts "Enter '3' for a list of all Pokemon moves!"
        puts "Enter '4' to search for  list of any Pokemons' special abilities!"
        puts "Enter '5' to search for a list of any Pokemons' moves!"
        puts "Enter '6' for a description of any Pokemon special ability!"
        puts "Enter '7' for a description of any Pokemon move!"
        puts "Enter 'quit' to leave Pokedex"
    end

    def menu
        puts ''
        prompt 
        puts ''
        input = gets.strip.downcase
        while input != 'exit'
            case input 
            when '1'
                #lists all pokemon
                characters = Api.get_pokemon_endpoint('pokemon')
                character_results = characters["results"]

                character_results.each do |character|
                    display_character(character)
                end
            when '2'
                #lists all pokemon abilities
                abilities = Api.get_ability_endpoint('ability')
                ability_results = abilities["results"]

                ability_results.each do |ability|
                    display_ability(ability)
                end
            when '3'
                #lists all pokemon moves
                moves = Api.get_move_endpoint('move')
                move_results = moves["results"]

                move_results.each do |move|
                    display_move(move)
                end
            when '4'
                #lists a specific pokemons ability(s)
                character_prompt
                input = gets.strip.downcase
                character_search = Api.search_endpoint('pokemon', input)
                character_search_results = character_search["abilities"]
                
               character_search_results.each do |ability|
                    display_character_abilities(ability)
               end

            when '5'
                #lists a specific pokemons moves
                character_prompt
                input = gets.strip.downcase 
                character_search = Api.search_endpoint('pokemon', input)
                character_search_results = character_search["moves"]
                
                character_move = character_search_results.each do |move|
                    display_character_moves(move)
                end
                
            when '6'
                #ability description
                ability_prompt
                input = gets.strip.downcase
                ability_search = Api.search_endpoint('ability', input)
                ability_search_results = ability_search["effect_entries"]
                
                english_effect = ability_search_results.find do |effect| 
                    effect["language"]["name"] == "en"
                end

                if english_effect == nil
                    ability_unavailable
                    menu
                else
                    display_ability_effect(english_effect)
                end

            when '7'
                #move description
                move_prompt
                input = gets.strip.downcase
                move_search = Api.search_endpoint('move', input)
                move_search_results = move_search["effect_entries"]
                
                english_effect = move_search_results.find do |move_effect|
                    move_effect["language"]["name"] == "en"
                end

                if english_effect == nil
                    move_unavailable
                    menu
                else
                    display_move_effect(english_effect)
                end
                
            when 'quit'
                exit_image
                goodbye
                exit
            else
                print_error
            end
            prompt
            input = gets.strip
        end
    end

    def character_prompt
        puts ''
        puts "Enter which Pokemon you're searching for!
        "
    end

    def ability_prompt
        puts ''
        puts "Enter which ability you're searching for!
        "
    end

    def move_prompt
        puts ''
        puts "Enter which move you're searching for!
        "
    end

    def display_character(character)
        name = character["name"]
        puts ''
        puts "Pokemon: #{name.capitalize}
        "
    end
    
    def display_ability(ability)
        name = ability["name"]
        puts ''
        puts "Ability: #{name.capitalize}
        "
    end

    def display_move(move)
        name = move["name"]
        puts ''
        puts "Move: #{name.capitalize}
        "
    end
    
    def display_character_abilities(ability)
        character_ability = ability["ability"]["name"]
        puts ''
        puts "Special Ability: #{character_ability.capitalize}
        " 
    end

    def display_ability_effect(effect)
        ability = effect["effect"]
        puts ''
        puts "Effect: #{ability}
        "
    end

    def display_move_effect(move_effect)
        move = move_effect["effect"]
        puts ''
        puts "Effect: #{move}
        "
    end

    def display_character_moves(move)
        character_move = move["move"]["name"]
        puts ''
        puts "Move: #{character_move.capitalize}
        "
    end
    
    def print_error
        puts ''
        puts 'Not sure what you meant there
        '
    end

    def ability_unavailable 
        puts ''
        puts 'Sorry! Data for this ability is not yet available. Try another ability!
        '
    end

    def move_unavailable
        puts ''
        puts 'Sorry! Data for this move is not yet available. Try another move!
        '
    end

    def goodbye
        puts ''
        puts "Come back anytime!"
    end

    def welcome 
        puts "Ready to start your research?"
        puts "Enter 'yes' to start"
        puts "Enter 'no' to exit"
    end
    
    def welcome_menu
        puts ''
        welcome
        puts ''
        input = gets.strip.downcase
        while input != 'exit'
            case input 
            when 'yes'
                #goes to menu
                menu
            when 'no'
                #exits program
                exit_image
                goodbye
                exit
            else
                print_error
                welcome
            end
            input = gets.strip
        end

    end

    def welcome_image
        puts "
        _______  _______  ___   _  _______  __   __  _______  __    _  __  
       |       ||       ||   | | ||       ||  |_|  ||       ||  |  | ||  | 
       |    _  ||   _   ||   |_| ||    ___||       ||   _   ||   |_| ||  | 
       |   |_| ||  | |  ||      _||   |___ |       ||  | |  ||       ||  | 
       |    ___||  |_|  ||     |_ |    ___||       ||  |_|  ||  _    ||__| 
       |   |    |       ||    _  ||   |___ | ||_|| ||       || | |   | __  
       |___|    |_______||___| |_||_______||_|   |_||_______||_|  |__||__| 
       "
    end

    def exit_image
       puts "
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈████≈
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈█████≈
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈███████
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈████████
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈█████████
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈███▒▒████
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈████▒▒▒███
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈███▒▒▒▒▒██
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈███▒▒▒▒▒▒██
       ≈≈≈≈≈≈████████≈≈≈≈≈≈≈≈≈≈≈≈██▒▒▒▒▒▒▒██
       ≈≈≈≈███████████≈≈≈≈≈≈≈≈≈≈≈██▒▒▒▒▒▒▒██
       ≈≈██████████████≈≈≈≈≈≈≈≈≈≈█▒▒▒▒▒▒▒▒██
       ███████████▒▒▒▒██≈≈≈≈≈≈≈≈≈█▒▒▒▒▒▒▒▒██
       ████████▒▒▒▒▒▒▒▒██≈≈≈≈≈≈≈≈█▒▒▒▒▒▒▒▒██
       ██████▒▒▒▒▒▒▒▒▒▒▒█≈≈████≈≈██▒▒▒▒▒▒▒██
       ███████▒▒▒▒▒▒▒▒▒▒███████████▒▒▒▒▒▒▒██
       ███████▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒▒██▒▒▒▒▒▒▒██
       ≈█████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██≈
       ≈≈█████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██≈≈
       ≈≈≈█████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██≈≈≈
       ≈≈≈≈██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██≈≈≈≈
       ≈≈≈≈≈██████▒▒▒▒▒▒██▒▒▒▒▒▒▒▒▒██▒██≈≈≈≈
       ≈≈≈≈≈≈████████▒▒█▌▐█▒▒▒▒▒▒▒█▌▐█▒█≈≈≈≈
       ≈≈≈≈≈≈≈≈█████▒▒▒█▌▐█▒▒▒▒▒▒▒█▌▐█▒█≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈█▒▒▒████▒▒▒▒▒▒▒████▒██≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈█▒▒▒████▒▒▒▒█▒▒████▒██≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈██▒▒▒███▒▒▒▒▒▒▒▒▒███▒▒█≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈██▒▒▒▒▒▒▒▒██████▒▒▒▒▒▒█≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈██▒███▒▒▒▒██████▒▒▒████≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈████▒██▒▒▒██████▒▒█▒▒██≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈██▒▒▒█▒▒▒██████▒▒█▒▒██≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈██▒▒▒█▒▒▒██████▒▒█▒▒█≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈██▒▒▒█▒▒▒██████▒▒█▒▒█≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈≈██▒██▒▒▒▒████▒▒▒█▒█≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈████▒▒▒▒▒▒▒▒▒▒▒▒▒▒██≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈██████▒▒▒▒▒▒▒▒▒▒▒▒▒██≈≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈██▒▒▒▒█▒▒▒▒▒▒▒▒▒▒▒█████≈≈≈≈
       ≈≈≈≈≈≈≈≈≈███▒▒▒▒▒██▒▒▒▒▒▒▒██▒▒▒███≈≈≈
       ≈≈≈≈≈≈≈≈≈≈█▒▒▒▒▒▒██████████▒▒▒▒▒██≈≈≈
       ≈≈≈≈≈≈≈≈≈≈██▒▒▒▒▒▒█████████▒▒▒▒▒██≈≈≈
       ≈≈≈≈≈≈≈≈≈████▒▒▒▒▒█████████▒▒▒▒██≈≈≈≈
       ≈≈≈≈≈≈≈≈███████▒▒▒███▒████▒▒▒▒██≈≈≈≈≈
       ≈≈≈≈≈≈███████████▒▒██▒▒▒█▒▒▒███≈≈≈≈≈≈
       ≈≈≈≈≈██████████▒▒▒▒█▒▒▒▒█▒███≈≈≈≈≈≈≈≈
       ≈≈≈≈███████████▒▒▒▒▒▒▒▒▒▒▒██≈≈≈≈≈≈≈≈≈
       ≈≈≈≈████████≈≈██▒▒▒▒▒▒▒▒▒▒█≈≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈██████≈≈███▒▒▒▒▒▒▒▒▒▒█≈≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈████≈≈██▒▒█▒▒▒▒▒▒▒▒▒█≈≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈███≈≈██▒▒▒▒█▒▒▒▒▒▒▒██≈≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈██▒▒▒▒████▒▒▒█▒█≈≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈█▒▒▒▒▒█≈≈████▒▒██≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈█▒█▒█▒█≈≈≈≈█▒▒▒▒█≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈█████≈≈≈≈≈█▒▒▒▒█≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈█▒▒▒▒█≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈█▒▒▒▒█≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈█▒█▒█≈≈≈≈≈≈≈≈≈
       ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈███≈≈≈≈≈≈≈≈≈≈"
    end
end
