import Foundation
import UIKit
import Alamofire

class Util{
    static let shared = Util()
    init(){
    }
    
    func showToast(_ message:String, _ viewController:UIViewController){
        let localMsg = message
        let font:UIFont? = UIFont.systemFont(ofSize: 14)
        let width = UIScreen.main.bounds.width - 20
        let bound = heightWithConstrainedWidth(localMsg, width, font ?? UIFont.systemFont(ofSize: 14))
        
        let toastLabel = UILabel(frame: CGRect(x:0,
                                               y: 20,
                                               width: bound.width + 20, height: bound.height + 20))
        toastLabel.center.x = viewController.view.center.x
        
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.text = localMsg
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = bound.height/2;
        toastLabel.clipsToBounds = true
        
        viewController.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    private func heightWithConstrainedWidth(_ text:String, _ width: CGFloat, _ font: UIFont) -> CGRect {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox
    }
    
    func showErrorToast(_ message:String, _ error:Int, _ viewController:UIViewController){
        let msg = "Lỗi " + String(error) + " - " + message
        showToast(msg, viewController)
    }
}


