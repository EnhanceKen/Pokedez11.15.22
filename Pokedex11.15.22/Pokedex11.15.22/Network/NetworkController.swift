//
//  File.swift
//  Pokedex11.15.22
//
//  Created by Consultant on 11/18/22.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
}

class NetworkManager {
    
    let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    //
    static let shared = NetworkManager()

    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var pokemon: Pokemon?
    

    func getPokemon(with searchText: String) {
        let requestURL = baseURL.appendingPathComponent(searchText)

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching pokemon: \(error)")
                return
            }

            guard let data = data else { return }

            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemon = pokemon
                print(pokemon.name, pokemon.abilities, pokemon.moves)
            } catch {
                print("Error decoding Pokemon: \(error)")
                return
            }
        }.resume()
    }
}
extension NetworkManager {
    //Fetch Page Result
    func fetchPageResult(with urlStr: String, completion: @escaping (PageResult?) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            completion(nil)
            return
        }
        
        let task = self.session.dataTask(with: url) { data, response, error in
            
            // TODO: implement more error handling
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let pageResult = try JSONDecoder().decode(PageResult.self, from: data)
                completion(pageResult)
            } catch {
                print(error)
                completion(nil)
            }
            
        }
        
        task.resume()
        
    }
    
    func fetchRawData(with urlStr: String, completion: @escaping (Data?) -> Void) {
        // Fetch Image
        guard let url = URL(string: urlStr) else {
            completion(nil)
            return
        }
        
        let task = self.session.dataTask(with: url) { data, response, error in
            
            // TODO: implement more error handling
            
            completion(data)
            
        }
        
        task.resume()
        
        
    }
    
    func fetchPokemon(with urlStr: String, completion: @escaping (Pokemon?) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            completion(nil)
            return
        }
        
        let task = self.session.dataTask(with: url) { data, response, error in
            
            // TODO: implement more error handling
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let pageResult = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pageResult)
            } catch {
                print(error)
                completion(nil)
            }
            
        }
        
        task.resume()
        
    }
    
    
}
