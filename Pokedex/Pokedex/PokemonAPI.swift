//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_218 on 2/28/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc (sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([TACPokemon]?,Error?) -> Void) {
        
        var requestURL = URLRequest(url: baseURL)
        requestURL.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil,error)
                return
            }
            guard let data = data else {
                completion(nil, errorWithMessage("Bad data", LSIDataNilError.rawValue))
                return
            }
            
            do {
                if let pokemonAPI = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let pokemonResults = pokemonAPI["results"] as? Array<[String: Any]> {
                        var pokemons = [TACPokemon]()
                        for pokemonDictionary in pokemonResults {
                            let pokemon = TACPokemon(dictionary: pokemonDictionary)
                            pokemons.append(pokemon)
                        }
                        completion(pokemons, nil);
                    }
                }
            } catch {
                completion(nil, errorWithMessage("Bad json decoding", LSIJSONDecodeError.rawValue))
            }
            
        }.resume()
    }
    
    
    @objc func fillInDetails(for pokemon: TACPokemon) {

        var requestURL = URLRequest(url: pokemon.detailsURL)
        requestURL.httpMethod = "GET"

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in

            if let error = error {
                print("Error fetching data!: \(error)")
                return
            }

            guard let data = data else {
                errorWithMessage("Bad Data!", LSIDataNilError.rawValue)
                return
            }

            do {
                if let pokemonDetails = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    pokemon.pokemonDetails(with: pokemonDetails)
                }
            } catch {
                errorWithMessage("Json decode error", LSIJSONDecodeError.rawValue)
            }

        }.resume()

    }

}
