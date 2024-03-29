import Foundation
import FaceCRM

class RegisterViewController: UIViewController {
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnAddPhoto: UIButton!
    @IBOutlet weak var ivMainPhoto: UIImageView!
    private var bPhotoArray:Array<Bool> = Array<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...4 {
            bPhotoArray.append(false)
        }
        
        FaceCRM.shared.onCapture { (cropImage, fullImage) in
            print("Capture success:", cropImage, fullImage)
            for i in 0..<self.bPhotoArray.count{
                if !self.bPhotoArray[i] {
                    self.bPhotoArray[i] = true
                    let iv = self.view.viewWithTag(11+i) as! UIImageView
                    iv.image = cropImage
                    let btn = self.view.viewWithTag(21+i)
                    btn?.isHidden = false
                    
                    if i == self.bPhotoArray.count - 1{
                        self.btnAddPhoto.isHidden = true
                    }
                    
                    break
                }
            }
        }
        
        FaceCRM.shared.onUploadFail { (face, status, message) in
            print("Upload fail:", face, status, message)
        }
        
        FaceCRM.shared.onUploadSuccess { (face) in
            print("Upload success:", face)
        }
        
        FaceCRM.shared.onRegisterFail { (faces, status, message) in
            self.loadingView.isHidden = true
            print("Register fail:", faces.count, status, message)
            Util.shared.showToast(message, self)
        }
        
        FaceCRM.shared.onRegisterSuccess { (faces, faceId) in
            self.loadingView.isHidden = true
            print("Register success:", faces.count, faceId)
            self.dismiss(animated: true, completion:nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var rect = ivMainPhoto.frame
        rect.size.width = UIScreen.main.bounds.width - 180
        rect.size.height = rect.size.width*3/2
        FaceCRM.shared.startRegisterByCamera{ (cameraView) in
            cameraView.frame = rect
            self.vContainer.layer.addSublayer(cameraView)
            self.btnAddPhoto.layer.zPosition = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        FaceCRM.shared.stopCamera()
    }
    
    @IBAction func touchAddPhoto(_ sender: Any) {
        FaceCRM.shared.captureFace()
    }
    
    @IBAction func touchRegister(_ sender: Any) {
        var faceArray = Array<UIImage>()
        for i in 1...bPhotoArray.count{
            let iv = view.viewWithTag(10+i) as! UIImageView
            if iv.image != nil {
                faceArray.append(iv.image!)
            }
        }
        
        loadingView.isHidden = false
        FaceCRM.shared.setRegisterMetaData("{\"description\":\"I am a developer. I am 18 years old\"}")
        FaceCRM.shared.registerFaces(faceArray)
    }
    
    @IBAction func touchBack(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    
    @IBAction func touchRemovePhoto(_ sender: Any) {
        let btn = sender as! UIButton
        btn.isHidden = true
        let iv = view.viewWithTag(btn.tag-10) as! UIImageView
        iv.image = nil
        bPhotoArray[btn.tag-21] = false
        btnAddPhoto.isHidden = false
    }
}
