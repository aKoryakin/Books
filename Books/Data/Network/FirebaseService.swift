//
//  FirebaseService.swift
//  Books
//
//  Created by Alex on 22.02.2024.
//

//import Foundation
//import FirebaseRemoteConfig
//
//protocol DataRetrieving {
//    func fetchData(forKey key: String, completion: @escaping (Result<Data, Error>) -> Void)
//}
//
//class FirebaseService: DataRetrieving {
//
//    private let remoteConfig = RemoteConfig.remoteConfig()
//
//    init() {}
//
//    func fetchData(forKey key: String, completion: @escaping (Result<Data, Error>) -> Void) {
//        self.remoteConfig.fetch { [weak self] (status, error) in
//            guard let self = self else { return }
//
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            self.remoteConfig.activate { (success, error) in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//
//                let data = self.remoteConfig.configValue(forKey: key).dataValue
//                completion(.success(data))
//            }
//        }
//    }
//}


import Foundation
import FirebaseRemoteConfig
import Combine

protocol Networking {
    func fetchData(forKey key: String) -> AnyPublisher<Data, Error>
}

class FirebaseService: Networking {
    static let shared = FirebaseService()
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    init() {}
    
    func fetchData(forKey key: String) -> AnyPublisher<Data, Error> {
        return Future<Data, Error> { promise in
            self.remoteConfig.fetch { [weak self] (status, error) in
                guard let self = self else { return }
                
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                self.remoteConfig.activate { (success, error) in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    
                    let data = self.remoteConfig.configValue(forKey: key).dataValue
                    promise(.success(data))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
