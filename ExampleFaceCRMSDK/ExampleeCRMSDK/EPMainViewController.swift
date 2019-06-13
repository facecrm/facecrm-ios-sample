import Foundation
import eCRM
import Alamofire

class MainViewController:UIViewController {
    
    @IBOutlet weak var ivCropPhoto: UIImageView!
    @IBOutlet weak var ivFullPhoto: UIImageView!
    
    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var btnCheckOut: UIButton!
    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    
    @IBOutlet weak var lbId: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    var isDetecting:Bool = false
    
    override func setupUI() {
        super.setupUI()
        
        let params = getGetTokenParams()
        let header = ["Authorization":"ca55719568ae5416e34c260514ac4d3b"]
        Util.shared.mAPIBuilder.request(.GET_TOKEN, params, header) { (status, message, data) in
            if status == MTConstants.API_SUCCESS {
                let dict = data as! Dictionary<String, Any>
                let token = dict["token"] as? String ?? ""
                print("TOKEN get from server:", token)
                if token.count > 0 {
                    MTUtil.shared.mToken = token
                    eCRMSDK.shared.setToken(token)
                }
            }
        }
        
        Util.shared.setViewCorner(btnCheckIn)
        Util.shared.setViewCorner(btnCheckOut)
        Util.shared.setViewCorner(ivPhoto)
        Util.shared.setViewCorner(btnNew, btnNew.bounds.height/2)
        if btnHistory != nil {
            Util.shared.setViewCorner(btnHistory, btnHistory.bounds.height/2)
        }
        
        var color = UIColor(red: 56.0/255.0, green: 49.0/255.0, blue: 145.0/255.0, alpha: 1.0)
        btnNew.layer.borderColor = color.cgColor
        btnNew.layer.borderWidth = 1.0
        
        if btnHistory != nil {
            btnHistory.layer.borderColor = color.cgColor
            btnHistory.layer.borderWidth = 1.0
        }
        
        color = UIColor(red: 255.0/255.0, green: 123.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        btnCheckOut.layer.borderColor = color.cgColor
        btnCheckOut.layer.borderWidth = 1.0
        
        ivPhoto.layer.borderColor = MTConstants.main_color.cgColor
        ivPhoto.layer.borderWidth = 1.0
    }
    
    private func getGetTokenParams() -> [String:String]{
        var dictionary =  [String:String]()
        let uuid = UUID().uuidString
        dictionary.updateValue(uuid, forKey:"device_id")
    
        return dictionary
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var rect = ivPhoto.frame
        rect.size.width = UIScreen.main.bounds.width - 160
        rect.size.height = rect.size.width*3/2
        
        eCRMSDK.shared.startDetectByCamera(rect, view)
        
        eCRMSDK.shared.onFoundFace { (cropImage:UIImage, fullImage:UIImage) in
            //print("Tim thay khuon mat")
            self.ivCropPhoto.image = cropImage
            self.ivFullPhoto.image = fullImage
        }
        
        eCRMSDK.shared.onDetectFail { (cropImage:UIImage, fullImage:UIImage, status:Int, message:String) in
            print("Nhan dien that bai:", status, message)
            self.ivCropPhoto.image = cropImage
            self.ivFullPhoto.image = fullImage
            Util.shared.showErrorToast(message, status)
        }
        
        eCRMSDK.shared.onDetectSuccess { (cropImage:UIImage, fullImage:UIImage, faceId:String, metaData:String) in
            self.ivCropPhoto.image = cropImage
            self.ivFullPhoto.image = fullImage
            Util.shared.showToast("Nhận diện thành công!")
            //print("Thong tin detect:", faceId, metaData)
            self.fillData(faceId, metaData)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        eCRMSDK.shared.stopCamera()
    }
    
    private func fillData(_ faceId:String, _ metaData:String){
        clearData()
        
        btnCheckIn.isHidden = false
        
        if btnHistory != nil {
            btnHistory.isHidden = false
        }
        
        self.tfId.text = faceId
        self.lbName.text = metaData
    }
    
    
    @IBAction func touchCheckIn(_ sender: Any) {
        Util.shared.showToast("Xóa thành công! Vui lòng nhận diện lại!")
        ivCropPhoto.image = nil
        ivFullPhoto.image = nil
        clearData()
    }
    
    @IBAction func touchCheckOut(_ sender: Any) {
        isDetecting = false
        Util.shared.showToast("Check out thành công! Vui lòng check in ngày tiếp theo")
        clearData()
    }
    
    private func clearData(){
        tfId.text = ""
        lbName.text  = ""
        btnCheckIn.isHidden = true
        btnCheckOut.isHidden = true
        isDetecting = false
        
        if btnHistory != nil {
            btnHistory.isHidden = true
        }
        if mTableView != nil{
            mTableView?.isHidden = true
            mTableView?.resetData()
        }
    }
}
