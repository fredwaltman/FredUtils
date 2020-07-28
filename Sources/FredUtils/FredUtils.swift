
import UIKit

public class FredUtils {
    
    /// Allows you to convert a 6 degit hexadecimal string unto a UIColor instance
    /// - Warning: The "#" symbol is stripped from the begining of the string submitted here
    /// - Parameters:
    ///   - hexString: A 6 digit hexadecimal string (without alpha)
    ///   - alpha: Optional number between 0 and 1 indicating transparency
    /// - Returns: UIColor instance defined by the parameters
    
    internal class func colorFromHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        
      let r, g, b: CGFloat
      let offset = hexString.hasPrefix("#") ? 1 : 0
      let start = hexString.index(hexString.startIndex, offsetBy: offset)
      let hexColor = String(hexString[start...])
      let scanner = Scanner(string: hexColor)
      var hexNumber: UInt64 = 0
      if scanner.scanHexInt64(&hexNumber) {
        r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        b = CGFloat(hexNumber & 0x0000ff) / 255
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
      }
      return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
    }
    
    /// A nice color
    public static var fredColor: UIColor {
        return self.colorFromHexString("006736")
    }
    
    /// Another nice color
    public static var secondaryColor: UIColor {
        return self.colorFromHexString("FCFFFD")
    }
}
