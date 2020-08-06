//
//  Misc.swift
//  FredUtils
//
//  Created by Fred Waltman on 7/29/20.
//

import UIKit
import CoreTelephony

extension FredUtils {
    
    public class Misc {
        
        private static let dialing = [
             "us" : 1,
             "ca" : 1,
             "cz" : 420,
             "de" : 49,
             "be" : 32,
             "nl" : 31,
             "dk" : 45,
             "ie" : 353,
             "se" : 46,
             "gb" : 44
         ]
        
        /// Remove any local jpgs or web pages that are the same as what is in the bundle
        
        public class func cleanLocalImages() {
            
            let filemgr = FileManager.default
            
            let documentsUrl =  filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let extensions = ["jpg", "html"]
            
            for extn in extensions {
                if let directoryUrls =  try? filemgr.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsSubdirectoryDescendants) {
                    let localFiles = directoryUrls.filter(){ $0.pathExtension == extn }.map{ $0.lastPathComponent }
                    
                    for fn in localFiles {
                        let path = ((documentsUrl.path) as NSString).appendingPathComponent(fn)
                        let local = try? Data(contentsOf: URL(fileURLWithPath: path))
                        if let bundlePath = Bundle.main.path(forResource: (fn as NSString).deletingPathExtension, ofType: extn) {
                            if let bundle = try? Data(contentsOf: URL(fileURLWithPath: bundlePath)) {
                                if (local == bundle) {
                                    do {
                                        try filemgr.removeItem(atPath: path)
                                    } catch let error1 as NSError {
                                        // couldn't delete, just skip it
                                        print( error1.localizedDescription)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
        /// Calculate the minimum column size based on the current device and orientation
        /// - Parameter columns: Number of required columns (default 2)
        /// - Returns: The minimum column size
        
        public class func getMinColumnSize(columns: Int = 2) -> CGFloat {
            
            let fudge : CGFloat = 10.0
            let size = UIScreen.main.bounds.size.width
            var colSize : CGFloat = 0
            
            if UIScreen.main.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.regular && UIScreen.main.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular {
                //Regular+Regular == iPad
                colSize =  (size/CGFloat(columns + 2)) - fudge
                colSize = (colSize > 325.0) ? 325.0 : colSize
            } else if UIScreen.main.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact && UIScreen.main.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular {
                //Regular+Compact = iPhone 6+ landscape
                colSize =  (size/CGFloat(columns + 2)) - fudge
            } else if UIScreen.main.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact {
                // iphone in landscape
                colSize =  (size/CGFloat(columns + 1)) - fudge
                
            } else {
                // must be iphone portrait
                colSize =  (size/CGFloat(columns)) - fudge
            }
            
            return colSize
        }
        
        /// Construct a phone number string with optional international prefix
        /// - Parameters:
        ///   - number: number to dial
        ///   - isoCode: ISO country code of the app
        /// - Returns: formated phone number with appropriate prefix
        
        public class func buildPhoneNumber(_ number : String, with isoCode:String ) -> String {
            var  phoneStr = ""
             
            #if os(iOS)
            var numbers = onlyDigits(number)
            
            if  numbers.prefix(1) == "0" || numbers.prefix(1) == "1" {
                numbers = String(numbers.dropFirst())
            }

            if let info = CTTelephonyNetworkInfo().serviceSubscriberCellularProviders {
                var cc = ""
                
                for (_, carrier) in info {
                    // can be multiple SIMs -- if multiple have country code we don't care
                    if let code = carrier.isoCountryCode {
                        cc = code
                    }
                }
                
                if cc == isoCode {
                    //same country
                    phoneStr = numbers
                } else {
                    //need to add country code
                    if let prefix = dialing[isoCode] {
                        phoneStr =  "+\(prefix)\(numbers)"
                    } else {
                        phoneStr = numbers
                    }
                }
            } else {
                phoneStr =  ""
            }
            
            return phoneStr
            #else
                return number
            #endif
        }
        
        /// Reize an image to the specified width
        /// - Parameters:
        ///   - image: the image to resize
        ///   - newWidth: the requested new width
        /// - Returns: Optional UIImage of new image (nil if couldn't resize)
        
        public class func resizeImageWidth(_ image: UIImage, to newWidth: CGFloat) -> UIImage? {
            
            let scale = newWidth / image.size.width
            let newHeight = image.size.height * scale
            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        }
        
        internal class func onlyDigits(_ number: String) -> String {
            let filtredUnicodeScalars = number.unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
            return String(String.UnicodeScalarView(filtredUnicodeScalars))
        }
    }
}

