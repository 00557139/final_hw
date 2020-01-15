//
//  ChangeFile.swift
//  fh
//
//  Created by User07 on 2020/1/13.
//  Copyright © 2020 gza. All rights reserved.
//
import FirebaseStorage
import Firebase
import UIKit

protocol Changefiledalegate {
       func update(text: String?,image:UIImage?) 
}
class ChangeFile: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
  var delegate: Changefiledalegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    let db = Firestore.firestore()
    
    @IBOutlet weak var n_name: UITextField!
    @IBAction func Done(_ sender: Any) {
        db.collection("user").whereField("mail", isEqualTo: self.account).getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
               let document = querySnapshot.documents.first
                document?.reference.updateData(["name": self.n_name.text,"pic":self.m_url], completion: { (error) in
               })
            }
        }
        delegate?.update(text: n_name.text, image: n_image.image)
       
        //self.performSegue(withIdentifier: "done", sender: nil)
        
    }
   // var p_file: Personalfile?
    @IBOutlet weak var n_image: UIImageView!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any]){
        dismiss(animated: true, completion: nil)
        let image=info[UIImagePickerController.InfoKey.originalImage] as?UIImage
        n_image.image=image
        let fileReference = Storage.storage().reference().child(UUID().uuidString+".jpg")
        if let data=n_image.image?.jpegData(compressionQuality: 1.0){
            fileReference.putData(data,metadata:  nil){(metadata,error) in
                guard let _ = metadata, error == nil else{return}
                fileReference.downloadURL(completion:{(url,error) in
                    guard let downloadURL = url else{return}
                    self.m_url=downloadURL.absoluteString
                    print(downloadURL.absoluteString)
                }
                
                )
            }
            
        }
        
    }
    var m_url:String?
    let account:String
    init?(coder: NSCoder, account: String) {
    self.account = account
        super.init(coder: coder)
     }
     required init?(coder: NSCoder) {
        fatalError()
     }
    @IBAction func upload(_ sender: Any) {
        let picker=UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate=self
        picker.allowsEditing=true
        self.present(picker,animated:true,completion: nil)
        
    }
}
    

