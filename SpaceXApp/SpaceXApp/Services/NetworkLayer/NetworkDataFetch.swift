//
//  NetworkDataFetch.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 23.07.2022.
//

import Foundation

protocol NetworkDataFetchProtocol {
    
    func fetchRockets(searchTerm: UserAPI, completion: @escaping ([Rocket]?) -> ())
    
    func fetchLaunches(searchTerm: UserAPI, completion: @escaping ([Launch]?) -> ())
}

final class NetworkDataFetch: NetworkDataFetchProtocol {
    
    private var networkLayer = NetworkLayer()
    
    func fetchRockets(searchTerm: UserAPI, completion: @escaping ([Rocket]?) -> ()) {
        networkLayer.request(searchTerm: searchTerm.path) { data, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
            
            let rockets = self.decodeJSON(T: [Rocket].self, from: data)
            completion(rockets)
        }
    }
    
    func fetchLaunches(searchTerm: UserAPI, completion: @escaping ([Launch]?) -> ()) {
        networkLayer.request(searchTerm: searchTerm.path) { data, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
            
            let launches = self.decodeJSON(T: [Launch].self, from: data)
            completion(launches)
        }
    }
    
    private func decodeJSON<T: Decodable>(T: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(T.self, from: data)
            return objects
        } catch let error {
            print("Failed to decode JSON", error)
            return nil
        }
    }
    
}
