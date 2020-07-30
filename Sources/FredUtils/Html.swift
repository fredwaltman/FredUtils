//
//  Html.swift
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

import Foundation

extension FredUtils {
    
    public class Html {
        
        /// Convert html text to attributed text
        /// - Parameters:
        ///   - htmlText: html text to convert
        ///   - returnCompletion: Returns a result object which signifies the status of the conversion
        
        public class func toAttributed(_ htmlText : String, returnCompletion: @escaping (ConversionResult<NSMutableAttributedString>) -> Void) {
            
            guard let data = htmlText.data(using: String.Encoding.utf8) else {
                let err = makeError("Unable to decode data from html string: \(htmlText.prefix(300))", code: -3)
                return returnCompletion(.failure(err))
            }
            
            DispatchQueue.main.async {
                // Needs to run on main thread, otherwise can crash
                if let attributedString = try? NSMutableAttributedString(data: data,
                                                                         options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) {
                    
                    return returnCompletion(.success(attributedString))
                } else {
                    let err =  makeError("Unable to create attributed string from html string: \(htmlText.prefix(300))", code: -2)
                    returnCompletion(.failure(err))
                    
                }
            }
        }
        
        public enum ConversionResult<Value> {
            case success(Value)
            case failure(Error?)
        }
        
        private class func makeError(_ msg: String, code: Int) -> NSError {
            
            let error = NSError(domain: "com.FredWaltman.FredUtils", code: code, userInfo: [NSLocalizedDescriptionKey: msg])
            
            return error
        }
    }
}
