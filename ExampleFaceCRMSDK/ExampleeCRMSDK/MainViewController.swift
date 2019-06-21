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
    
    @IBOutlet weak var lbOthers: UILabel!
    @IBOutlet weak var lbId: UILabel!
    @IBOutlet weak var lbMetaData: UILabel!
    @IBOutlet weak var tfId: UITextField!
   
    @IBOutlet weak var btnSwitchCamera: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //71726c5c-3178-49f4-98dd-f01a356a91fc
        
        FaceCRM.shared.setAppId("146e1fe7-3c17-460d-81a3-b5441eb5dc70")
        getTokenSDK()
    }
    
    private func getTokenSDK(){
        let url = URL(string:"http://api.facecrm.co/api/v1/auth/token")
        let header = ["appId":"146e1fe7-3c17-460d-81a3-b5441eb5dc70"]
        var params =  [String:String]()
        let uuid = UUID().uuidString
        params.updateValue(uuid, forKey:"device_id")
        
        Alamofire.request(url!,
                          method:Alamofire.HTTPMethod.post,
                          parameters:params,
                          headers:header)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    return
                }
                
                print("Response:", response.result.value as Any)
                
                let value = response.result.value as? [String: Any]
                let status =  value!["status"] as? Int ?? -999
                let data = value!["data"]
                
                if status == 200 {
                    let dict = data as! Dictionary<String, Any>
                    let token = dict["token"] as? String
                    if token != nil {
                        print("Get token:", token!)
                        FaceCRM.shared.setToken(token!)
                    }
                }
        }
    }
    
    @IBAction func switchCamera(_ sender: Any) {
        FaceCRM.shared.switchCameraPosition()
        //FaceCRM.shared.setCameraPosition(FaceCRM.CAMERA_POSITION_FRONT)
        //FaceCRM.shared.setCameraPosition(FaceCRM.CAMERA_POSITION_REAR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var rect = ivPhoto.frame
        rect.size.width = UIScreen.main.bounds.width - 160
        rect.size.height = rect.size.width*3/2
        
        FaceCRM.shared.setFaceRectangle(UIColor.green, 2)
        FaceCRM.shared.setDetectRate(50)
        
        FaceCRM.shared.setCollectionId(5)
        FaceCRM.shared.setTagId(4)
        
        let type = [FaceCRM.DETECT_TYPE_EMOTION, FaceCRM.DETECT_TYPE_AGE, FaceCRM.DETECT_TYPE_GENDER]
        FaceCRM.shared.setDetectType(type)
        
        FaceCRM.shared.startDetectByCamera { (cameraView) in
            cameraView.frame = rect
            self.view.layer.addSublayer(cameraView)
            self.btnSwitchCamera.layer.zPosition = 1
        }
        
        FaceCRM.shared.onFoundFace { (cropImage, fullImage) in
            //print("Found faces")
            self.ivCropPhoto.image = cropImage
            self.ivFullPhoto.image = fullImage
        }
        
        FaceCRM.shared.onDetectFail { (face, fullImage, errorCode, errorMessage) in
            print("Detect fail", errorCode, errorMessage)
            self.ivCropPhoto.image = face
            self.ivFullPhoto.image = fullImage
            Util.shared.showErrorToast(errorMessage, errorCode, self)
        }
        
        FaceCRM.shared.onDetectSuccess { (face, fullImage, model) in
            self.ivCropPhoto.image = face
            self.ivFullPhoto.image = fullImage
            Util.shared.showToast("Detect success", self)
            self.fillData(model)
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
    
    private func fillData(_ model:FCUserModel){
        clearData()
        
        btnClearDetect.isHidden = false
        btnHistory.isHidden = false
        self.tfId.text = model.faceId
        if model.metaData.count >  0 {
            self.lbMetaData.text = model.metaData.first
        }
        
        self.lbOthers.text = "Age:" + String(model.age) + " - Gender:" + model.gender + " - Emotion:" + model.emotion
    }

    private func clearData(){
        tfId.text = ""
        lbMetaData.text  = ""
        lbOthers.text = ""
        btnClearDetect.isHidden = true
        btnHistory.isHidden = true
    }
}
