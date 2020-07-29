//
//  Networking.swift
//  FredUtils
//
//  Created by Fred Waltman on 7/28/20.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) {data, _, error in
            completionHandler(data, error)
        }
        
        task.resume()
    }
}

extension FredUtils {
    
    public class Networking {
        
        /// Resposible for handling all networking calls
        /// -Warning: Must create before using any public APIs
        
        public class Manager {
             public init() {}
          
            internal var session:  NetworkSession = URLSession.shared
            
            ///  Calld to the live internet to retrieve Data from a specific location
            /// - Parameters:
            ///   - url: url you wish to fetch
            ///   - completionHandler: returns a result object which signifies the status of the request
            
            public func loadData(from url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                session.get(from: url) { data, error in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completionHandler(result)
                }
            }
            
            public enum NetworkResult<Value> {
                case success(Value)
                case failure(Error?)
            }
        }
    }
}
