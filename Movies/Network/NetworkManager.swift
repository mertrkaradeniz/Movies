//
//  NetworkManager.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import Alamofire
import Foundation

final class NetworkManager {
    static let shared: NetworkManager = NetworkManager()

    var networkIsReachable: Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }

    func request<T: Codable>(_ request: URLRequestConvertible,
                             decodeToType type: T.Type,
                             completionHandler: @escaping (Result<T, Error>) -> Void) {

        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(type.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
