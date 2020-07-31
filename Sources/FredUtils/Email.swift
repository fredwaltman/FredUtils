//
//  Email.swift
//  FredUtils
//
//  Created by Fred Waltman on 7/31/20.
//

import Foundation
import MessageUI

extension FredUtils {
    
    public class Email {
        
        public class func makeMailComposeViewControllerOfType(type : String,
                                                       about subject : String,
                                                       with info: [String : String]) -> MFMailComposeViewController {
            var to: String
            var prefix : String = ""
            
            if let cd = info["code"]  {
                if cd == "bam" {
                    to = "support@bambergbeerguide.com"
                } else {
                    to = "support@beerguide\(cd).com"
                }
                prefix  = "BeerGuide\(cd.uppercased())"
            } else {
                to = "support@beerguideapps.com"
            }
            
            var desc : String
            
            switch(type) {
            case "P" :
                desc = "Please describe the errors or corrections below:"
            case "F" :
                desc = "Please send your feedback or comments below:"
            default :
                desc = "Please describe the problems you are having below. If you are reporting errors in the data, please describe them:"
            }
            
            let mailComposerVC = MFMailComposeViewController()
            
            guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
                fatalError("CFBundleShortVersionString not found!")
            }
            
            guard let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
                fatalError("CFBundleVersion not found!")
            }
            
            let os = ProcessInfo().operatingSystemVersion
            
            mailComposerVC.setToRecipients([to])
            mailComposerVC.setSubject("\(prefix) \(subject)")
            
            var body = "<p>\(desc)</p><br><br><br><br><br><br>"
            body += "<p>The following details relate to your application and device. It helps us "
            body += "diagnose technical issues but you may delete it if you wish.<p>"
            body += "<ul><li>OS Version: \(os.majorVersion).\(os.minorVersion)</li>"
            body += "<li>App Version: \(version) Build: \(build)</li>"
            
            if let id = info["id"] {
                body += "<li>Application serial number: \(id)"
            }
            
            if let vers = info["vers"] {
                body += "<li>Database Version: \(vers)</li>"
            }
            
            if let device = info["device"] {
                body += "<li>Device: \(device)</li>"
            }
            
            if let home = info["home"] {
                body += "<li>Country: \(home)"
            }
            
            body += "</ul>"
            
            mailComposerVC.setMessageBody(body, isHTML: true)
            
            return mailComposerVC
        }
        
        public class func makeSendMailErrorAlert() -> UIAlertController {
            let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email",
                                                       message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
            
            sendMailErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            return sendMailErrorAlert
        }
        
    }
}
