//
//  NetworkLayer.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 23.07.2022.
//

import Foundation

protocol NetworkLayerProtocol {
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkLayer: NetworkLayerProtocol {
    
    static let v4 = "v4"
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = self.url(searchTerm: searchTerm)
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        let task = createDataTask(with: request, completion: completion)
        task.resume()
    }

    private func url(searchTerm: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spacexdata.com"
        components.path = "/\(NetworkLayer.v4)/\(searchTerm)"
        return components.url!
    }
    
    
    private func createDataTask(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
