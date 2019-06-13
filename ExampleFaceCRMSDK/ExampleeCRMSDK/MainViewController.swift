import Foundation
import FaceCRM
import Alamofire

class MainViewController:UIViewController {
    @IBOutlet weak var ivCropPhoto: UIImageView!
    @IBOutlet weak var ivFullPhoto: UIImageView!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    @IBOutlet weak var btnClearDetect: UIButton!
    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    
    @IBOutlet weak var lbId: UILabel!
    @IBOutlet weak var lbMetaData: UILabel!
    @IBOutlet weak var tfId: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTokenSDK()
    }
    
    private func getTokenSDK(){
        var params =  [String:String]()
        let uuid = UUID().uuidString
        params.updateValue(uuid, forKey:"device_id")
        let header = ["Authorization":"ca55719568ae5416e34c260514ac4d3b"]
        let url = URL(string:"http://api.facecrm.co/api/v1/application/token-auth")
        
        Alamofire.request(url!,
                          method:Alamofire.HTTPMethod.post,
                          parameters:params,
                          headers:header)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    return
                }
                
                let value = response.result.value as? [String: Any]
                let status =  value!["status"] as? Int ?? -999
                let data = value!["data"]
                
                if status == 200 {
                    let dict = data as! Dictionary<String, Any>
                    let token = dict["token"] as? String
                    if token != nil {
                        FaceCRM.shared.setToken(token!)
                    }
                }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var rect = ivPhoto.frame
        rect.size.width = UIScreen.main.bounds.width - 160
        rect.size.height = rect.size.width*3/2
        
        FaceCRM.shared.startDetectByCamera(rect, view)
        
        FaceCRM.shared.onFoundFace { (cropImage:UIImage, fullImage:UIImage) in
            //print("Found faces")
            self.ivCropPhoto.image = cropImage
            self.ivFullPhoto.image = fullImage
        }
        
        FaceCRM.shared.onDetectFail { (cropImage:UIImage, fullImage:UIImage, status:Int, message:String) in
            print("Detect fail", status, message)
            self.ivCropPhoto.image = cropImage
            self.ivFullPhoto.image = fullImage
            Util.shared.showErrorToast(message, status, self)
        }
        
        FaceCRM.shared.onDetectSuccess { (cropImage:UIImage, fullImage:UIImage, faceId:String, metaData:String) in
            self.ivCropPhoto.image = cropImage
            self.ivFullPhoto.image = fullImage
            Util.shared.showToast("Detect success", self)
            self.fillData(faceId, metaData)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        FaceCRM.shared.stopCamera()
    }
    
    @IBAction func touchClearDetect(_ sender: Any) {
        Util.shared.showToast("Clear detect succcessfully. Detect again!", self)
        ivCropPhoto.image = nil
        ivFullPhoto.image = nil
        clearData()
    }
    
    private func fillData(_ faceId:String, _ metaData:String){
        clearData()
        
        btnClearDetect.isHidden = false
        btnHistory.isHidden = false
        self.tfId.text = faceId
        self.lbMetaData.text = metaData
    }

    private func clearData(){
        tfId.text = ""
        lbMetaData.text  = ""
        btnClearDetect.isHidden = true
        btnHistory.isHidden = true
    }
}
