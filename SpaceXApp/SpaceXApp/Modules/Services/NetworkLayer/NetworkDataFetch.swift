//
//  NetworkDataFetch.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 23.07.2022.
//

import Foundation

final class NetworkDataFetch {
    
    var networkLayer = NetworkLayer()
    
    
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
    
    // TRY implement DRY
//    func fetchData<T: Decodable>(searchTerm: UserAPI, completion: @escaping ([T]?) -> ()) {
//        networkLayer.request(searchTerm: searchTerm.path) { data, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                completion(nil)
//            }
//
//            completion(self.getObjects(searchTerm: searchTerm, data: data))
//        }
//    }
//    private func getObjects<T: Decodable>(searchTerm: UserAPI, data: Data?) -> T? {
//        switch searchTerm {
//        case .getRockets:
//            return self.decodeJSON(T: [Rocket].self, from: data) as? T
//        case .getLaunches:
//            return self.decodeJSON(T: [Launch].self, from: data) as? T
//        }
//    }
    
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
