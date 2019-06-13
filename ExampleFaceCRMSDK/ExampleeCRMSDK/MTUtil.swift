import Foundation
import UIKit
//import CommonCrypto
//import MessageUI
import Alamofire

class Util{
    static let shared = Util()
    init(){
    }
    
//    var mImageLoader = KingFisherImageLoader()
//    var mAPIBuilder = AlamofireAPIBuilder()
//    var mLoadBuilder = NVALoadBuilder()
//    var mUser:EPUserModel?
//    var mToken:String?
    
//    func heightWithConstrainedWidth(_ text:String, _ width: CGFloat, _ font: UIFont) -> CGRect {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = text.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
//        return boundingBox
//    }
//
//    func showErrorToast(_ message:String, _ error:Int){
//        let msg = "Lỗi " + String(error) + " - " + message
//        showToast(msg)
//    }
//
//    func showToast(_ message:String){
//        let localMsg = message//NSLocalizedString(message, comment: "")
//        let font:UIFont? = UIFont.systemFont(ofSize: 14)
//        let width = UIScreen.main.bounds.width - 20
//        let bound = heightWithConstrainedWidth(localMsg, width, font ?? UIFont.systemFont(ofSize: 14))
//
//        let toastLabel = UILabel(frame: CGRect(x:0,
//                                               y: 20,
//                                               width: bound.width + 20, height: bound.height + 20))
//        toastLabel.center.x = MTUtil.shared.getCurrentVC().view.center.x
//
//        toastLabel.backgroundColor = UIColor.black
//        toastLabel.textColor = UIColor.white
//        toastLabel.textAlignment = .center;
//        toastLabel.font = UIFont.systemFont(ofSize: 14)
//        toastLabel.text = localMsg
//        toastLabel.numberOfLines = 0
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = bound.height/2;
//        toastLabel.clipsToBounds = true
//
//        MTUtil.shared.getCurrentVC().view.addSubview(toastLabel)
//        UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseOut, animations: {
//            toastLabel.alpha = 0.0
//        }, completion: {(isCompleted) in
//            toastLabel.removeFromSuperview()
//        })
//    }
    
//    func setRootViewController(_ isLogin:Bool){
//        let storyboard = UIStoryboard(name:"Main", bundle: nil)
//        var screenName = ""
//        if isLogin {
//            screenName = String(describing: EPLoginViewController.self)
//        }else{
//            screenName = String(describing: EPProfileViewController.self)
//        }
//        let vc = storyboard.instantiateViewController(withIdentifier:screenName)
//        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.5, options: .transitionCrossDissolve, animations: {
//            UIApplication.shared.keyWindow?.rootViewController = vc
//            UIApplication.shared.keyWindow?.makeKeyAndVisible()
//        }, completion:nil)
//    }
    
    
//    func getDefaultParams() -> Dictionary<String, String>{
//
//        var userId:String
//
//        if mUser != nil{
//            userId = String(mUser!.mId)
//        }else{
//            userId = "0"
//        }
//
//        var dictionary =  [String:String]()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyyMMddHHmmss"
//        dateFormatter.locale = Locale(identifier:MTConstants.LOCALE_DEFAULT)
//
//        let deviceId = UIDevice.current.identifierForVendor!.uuidString
//        let platform = "ios"
//        let clientIp = "127.120.120.1" //getIPAddress()
//        let time = dateFormatter.string(from: Date())
//        //md5(user_id,device_id,platform,client_ip,time,CLIENT_KEY)
//        let md5Data = userId + deviceId + platform + clientIp + time + MTConstants.CLIENT_KEY
//        let md5String = getMD5(md5Data)
//
//        dictionary.updateValue(deviceId, forKey:"device_id")
//        dictionary.updateValue(userId, forKey:"user_id")
//        dictionary.updateValue(platform, forKey:"platform")
//        dictionary.updateValue(clientIp, forKey:"client_ip")
//        dictionary.updateValue(time, forKey:"time")
//        dictionary.updateValue(md5String!, forKey:"hash")
//
//        return dictionary
//
////        ["device_id": "82417BD6-E426-4DD8-AA69-C37136AB5A3B",
////         "client_ip": "2001:ee0:4101:34e0:8c8e:f8fa:de2a:2dad",
//    }
    
//    func openPhone(_ phone:String){
//        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url)
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        }
//    }
//
//    func openEmail(_ email:String, _ title:String?){
//        if !MFMailComposeViewController.canSendMail() {
//            MTUtil.shared.showToast("Bạn cần thêm email trong phần Settings của máy!")
//            return
//        }
//
//        let composeVC = MFMailComposeViewController()
//        composeVC.view.tintColor = UIColor(red:252.0/255.0, green:172.0/255.0, blue:48.0/255.0, alpha:1.0)
//        composeVC.mailComposeDelegate = getCurrentVC() as? MFMailComposeViewControllerDelegate
//
//        composeVC.setToRecipients([email])
//        if title != nil{
//            composeVC.setSubject(title!)
//        }
//
//        //composeVC.setMessageBody("Message content.", isHTML: false)
//        getCurrentVC().present(composeVC, animated: true, completion: nil)
//    }
//
//    func formatNumber(_ number:String)->String{
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        let newNumber = numberFormatter.string(from: NSNumber(value:Double(number)!))
//        return newNumber!
//    }
//
//    func getMD5(_ string: String) -> String? {
//        let length = Int(CC_MD5_DIGEST_LENGTH)
//        var digest = [UInt8](repeating: 0, count: length)
//
//        if let d = string.data(using: String.Encoding.utf8) {
//            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
//                CC_MD5(body, CC_LONG(d.count), &digest)
//            }
//        }
//
//        return (0..<length).reduce("") {
//            $0 + String(format: "%02x", digest[$1])
//        }
//    }
//
//    func getIPAddress() -> String? {
//        var address: String?
//        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
//
//        if getifaddrs(&ifaddr) == 0 {
//            var ptr = ifaddr
//            while ptr != nil {
//                defer { ptr = ptr?.pointee.ifa_next }
//                let interface = ptr?.pointee
//                let addrFamily = interface?.ifa_addr.pointee.sa_family
//                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
//                    let name: String = String(cString: (interface?.ifa_name)!)
//                    if name == "en0" || name == "en1" {
//                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
//                        address = String(cString: hostname)
//                    }
//                }
//            }
//            freeifaddrs(ifaddr)
//        }
//
//        return address
//    }
//
//    func addDoneButtonKeyboard(_ textField:UITextField, _ action: Selector, _ vc: UIViewController){
//        let doneToolbar: UIToolbar = UIToolbar()
//        doneToolbar.barStyle = UIBarStyle.default
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title:"Xong", style: UIBarButtonItem.Style.done, target: vc, action: action)
//        done.tintColor = MTConstants.main_color
//
//        var items = [UIBarButtonItem]()
//        items.append(flexSpace)
//        items.append(done)
//        doneToolbar.items = items
//        doneToolbar.sizeToFit()
//        textField.inputAccessoryView = doneToolbar
//    }
//
//    func addDoneButtonKeyboard(_ textField:UITextField, _ action: Selector){
//        let doneToolbar: UIToolbar = UIToolbar()
//        doneToolbar.barStyle = UIBarStyle.default
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        print("xem lai nao2:", getCurrentVC(), UIApplication.shared.keyWindow!.rootViewController!.presentedViewController, UIApplication.shared.keyWindow!.rootViewController!.presentingViewController, UIApplication.shared.keyWindow!.rootViewController!.presentationController)
//        let done: UIBarButtonItem = UIBarButtonItem(title:"Xong", style: UIBarButtonItem.Style.done, target: getCurrentVC(), action: action)
//        done.tintColor = MTConstants.main_color
//
//        var items = [UIBarButtonItem]()
//        items.append(flexSpace)
//        items.append(done)
//        doneToolbar.items = items
//        doneToolbar.sizeToFit()
//        textField.inputAccessoryView = doneToolbar
//    }
//
//    func showPopup(_ message:String, _ yesTitle:String, _ noTitle:String, _ handler: (() -> Void)? = nil){
//        let messageStr = NSLocalizedString(message, comment: "")
//        let yesStr = NSLocalizedString(yesTitle, comment: "")
//        let noStr = NSLocalizedString(noTitle, comment: "")
//
//        let alert = UIAlertController(title: "Thông báo", message:messageStr, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: yesStr, style: UIAlertAction.Style.default, handler: { action in
//            handler!()
//            alert.dismiss(animated: true, completion: nil)
//        }))
//        alert.addAction(UIAlertAction(title: noStr, style: UIAlertAction.Style.cancel, handler:{ action in
//            alert.dismiss(animated: true, completion: nil)
//        }))
//        alert.view.tintColor = MTConstants.main_color
//        getCurrentVC().present(alert, animated: true, completion: {() -> Void in
//
//        })
//    }
//
//    func checkNotEqual(_ string1:String!, _ string2:String!) -> Bool{
//        if string1 == nil || string2 == nil {
//            return true
//        }
//         let value1 = string1.trimmingCharacters(in: .whitespaces)
//        let value2 = string2.trimmingCharacters(in: .whitespaces)
//
//        if value1 != value2 {
//            return true
//        }
//
//        return false
//    }
//
//
//
//    func getImage(_ name: String) -> UIImage? {
//        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
//            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(name).path)
//        }
//        return nil
//    }
//
//    func log(_ message: String)  {
//        print("sondeptrai:" + message)
//    }
//
//    func isEmptyString(_ string: String?) -> Bool{
//        guard let text = string?.trimmingCharacters(in:.whitespaces), !text.isEmpty else {
//            return true
//        }
//        return false
//    }
//
//    func formatPhoneNumber(_ string: inout String){
//        string = string.trimmingCharacters(in: .whitespaces)
//        string = string.replacingOccurrences(of: "+", with: "", options: .literal, range: nil)
//
//        var characters = Array(string)
//        var pos = -1
//        for i in 0..<characters.count {
//            if characters[i] == "0"{
//                pos = i
//            }else {
//                break
//            }
//        }
//
//        if pos > -1{
//            string = String(string.dropFirst(pos+1))
//        }
//
//        if string.hasPrefix("84"){
//            string = String(string.dropFirst(2))
//
//            characters = Array(string)
//            pos = -1
//            for i in 0..<characters.count {
//                if characters[i] == "0"{
//                    pos = i
//                }else {
//                    break
//                }
//            }
//
//            if pos > -1{
//                string = String(string.dropFirst(pos+1))
//            }
//        }
//
//        string = "84" + string
//    }
//
//    func resizeImage(_ image: UIImage, _ targetSize: CGSize) -> UIImage {
//        let size = image.size
//
//        let widthRatio  = targetSize.width  / size.width
//        let heightRatio = targetSize.height / size.height
//
//        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width:size.width * heightRatio, height:size.height * heightRatio)
//        } else {
//            newSize = CGSize(width:size.width * widthRatio, height:size.height * widthRatio)
//        }
//
//        let rect = CGRect(x:0, y:0, width:newSize.width, height:newSize.height)
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        image.draw(in: rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//    }
//
//    func convertImageToBase64(_ image:UIImage) -> String{
//        let newImage:UIImage?
//        if image.size.height > 150 {
//            let size = CGSize(width: (image.size.width*150)/image.size.height, height: 150)
//            newImage = resizeImage(image, size)
//        }else{
//            newImage = image
//        }
//
//        let imageData: NSData = newImage!.jpegData(compressionQuality:1)! as NSData
//        let base64:String = imageData.base64EncodedString()
//        return base64
//    }
//
//    func isInvalidPhone(_ string: String?) -> Bool{
//        if string == nil{
//            return true
//        }
//
//        let newString = string?.trimmingCharacters(in: .whitespaces)
//        if newString!.count < 10{
//            return true
//        }
//
//        do {
//            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
//            let matches = detector.matches(in: newString!, options: [], range: NSMakeRange(0, newString!.count))
//            if let res = matches.first {
//                return !(res.resultType == .phoneNumber
//                    && res.range.location == 0
//                    && res.range.length == newString!.count)
//            } else {
//                return true
//            }
//        } catch {
//            return true
//        }
//    }
//
//    func hasNetwork()-> Bool{
//        return true
//    }
//
//    func setViewCorner(_ button:UIView){
//        button.layer.cornerRadius = CGFloat(MTConstants.border_button)
//        button.clipsToBounds = true
//    }
//
//    func setViewCorner(_ button:UIView, _ radius:CGFloat){
//        button.layer.cornerRadius = radius
//        button.clipsToBounds = true
//    }
//
//
//    func getCurrentVC() -> UIViewController{
//        return findViewController(UIApplication.shared.keyWindow!.rootViewController!)
//    }
//
//
//    private func findViewController(_ viewController:UIViewController) -> UIViewController {
//        if viewController is UINavigationController {
//            let navigationController = viewController as! UINavigationController
//            return findViewController(navigationController.visibleViewController!)
//        }else if viewController is UITabBarController {
//            let tabbarController = viewController as! UITabBarController
//            return findViewController(tabbarController.selectedViewController!)
//        }else if viewController.presentedViewController != nil {
//            return findViewController(viewController.presentedViewController!)
//        }else{
//            return viewController
//        }
//    }
}


