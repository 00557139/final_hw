//
//  Personalfile.swift
//  fh
//
//  Created by User07 on 2020/1/13.
//  Copyright © 2020 gza. All rights reserved.
//

import Firebase
import FirebaseStorage
import UIKit

class Personalfile: UIViewController,Changefiledalegate {
     func update(text: String?,image:UIImage?){
        self.img.image=image
        self.m_name.text=text
         
     }
let account:String
    @IBSegueAction func change(_ coder: NSCoder) -> ChangeFile? {
        return ChangeFile(coder: coder, account: account)
    }
    let db=Firestore.firestore()
    let storage=Storage.storage(url:"gs://my-project-1560861218642.appspot.com")
    override func viewDidLoad() {
        super.viewDidLoad()
        let query=db.collection("user").whereField("mail", isEqualTo: account)
        query.getDocuments(){
            (querySnapshot,err)in
            self.m_name.text=querySnapshot?.documents.first?.get("name").unsafelyUnwrapped as? String
            self.path=querySnapshot?.documents.first?.get("pic").unsafelyUnwrapped as? String
            if self.path?.isEmpty == true{
                
                }
                else{
                    let f_ref=self.storage.reference(forURL: self.path!)
                    f_ref.getData(maxSize: 1024*1024*1024){(data,error)in
                        self.img.image=UIImage(data: data!)
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    var path:String?
    
    init?(coder: NSCoder, account: String) {
    self.account = account
        super.init(coder: coder)
     }
     required init?(coder: NSCoder) {
        fatalError()
     }
    @IBOutlet weak var m_name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {let controller = segue.destination as? ChangeFile
       controller?.delegate = self
       
   }
    
   
    
    
}

