//
//  Networking.swift
//  FredUtils
//
//  Created by Fred Waltman on 7/28/20.
//
/*
* Copyright (c) Fred Waltman
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

protocol NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request) {data, _, error in
            completionHandler(data, error)
 
        }
        
        task.resume()
    }
    
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
            
            ///  Calls to the live internet to retrieve Data from a specific location
            /// - Parameters:
            ///   - url: url you wish to fetch
            ///   - completionHandler: returns a result object which signifies the status of the request
            
            public func loadData(from url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                session.get(from: url) { data, error in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completionHandler(result)
                }
            }
            
            /// Calls to internet to send data to a URL
            /// -Warning: Make sure that the URL can accept POST requests
            /// - Parameters:
            ///   - url: the location to send the data
            ///   - body: the data to send
            ///   - completionHandler: Returns a result object which signifies the status of the request
            
            public func sendData<I: Codable>(to url: URL, body: I, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                
                var request = URLRequest(url: url)
                
                do {
                    let httpBody = try JSONEncoder().encode(body)
                    request.httpBody = httpBody
                    request.httpMethod = "POST"
                    session.post(with: request) {data, error in
                        let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                        completionHandler(result)
                    }
                } catch let error {
                    return completionHandler(.failure(error)
                    )
                }
            }
            
            
            public enum NetworkResult<Value> {
                case success(Value)
                case failure(Error?)
            }
        }
        
        public class func parseJSONWithCompletionHandler(_ data: Data, completionHandler: (_ result: AnyObject?, _ error: NSError?) -> Void) {
            
            var parsingError: NSError? = nil
            
            let parsedResult: Any?
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            } catch let error as NSError {
                parsingError = error
                parsedResult = nil
            }
            
            if let error = parsingError {
                completionHandler(nil, error)
            } else {
                completionHandler(parsedResult as AnyObject?, nil)
            }
        }
        
         /// Constructs a URL Object, possibly adding http://
         /// - Parameter url: url string
         /// - Returns: Option URL object referencing the supplied string. If device can't open the URL it returns nil
         
         public class func parseURL(_ url : String) -> URL? {
             var newUrl = ""
             var prefix = ""
             
             if url.count >= 8 {
                 if url.prefix(7) == "http://" {
                     newUrl = String(url.dropFirst(7))
                     prefix = "http://"
                 } else if url.prefix(8) == "https://" {
                     newUrl = String(url.dropFirst(8))
                     prefix = "https://"
                 } else if url.prefix(12) == "itms-apps://" {
                     newUrl = String(url.dropFirst(12))
                     prefix = "itms-apps://"
                 } else {
                     newUrl = url
                     prefix = "http://"
                 }
                 
                 if let urlPrefix = URL(string: prefix) {
                    
                     if UIApplication.shared.canOpenURL(urlPrefix) {
                         if let tryURL = URL(string: "\(prefix)\(newUrl)") {
                             return tryURL
                         }
                     }
                 }
             }
             
             return nil
         }
    }
}
