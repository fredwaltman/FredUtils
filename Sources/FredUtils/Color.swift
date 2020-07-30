
import UIKit

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

extension FredUtils {
    public class Color {
        /// Allows you to convert a 6 degit hexadecimal string unto a UIColor instance
        /// - Warning: The "#" symbol is stripped from the begining of the string submitted here
        /// - Parameters:
        ///   - hexString: A 6 digit hexadecimal string (without alpha)
        ///   - alpha: Optional number between 0 and 1 indicating transparency
        /// - Returns: UIColor instance defined by the parameters
        
        public class func fromHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
            
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
    }
}
