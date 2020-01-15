//
//  signin.swift
//  fh
//
//  Created by User07 on 2020/1/13.
//  Copyright © 2020 gza. All rights reserved.
//

import Firebase
import FirebaseStorage
import UIKit

class Register: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nuser: UITextField!
    @IBOutlet weak var npassword: UITextField!
    
    @IBAction func create(_ sender: Any) {
        let db = Firestore.firestore()
        let data: [String: Any] = ["name": "", "mail": nuser.text, "pic": ""]
        var reference: DocumentReference?
        reference = db.collection("user").addDocument(data: data) { (error) in
           if let error = error {
              print(error)
           } else {
              print(reference?.documentID)
           }
        }
        Auth.auth().createUser(withEmail: nuser.text! , password: npassword.text!) {(result, error) in
             guard error == nil else {
                 print(error?.localizedDescription)
                 return
             }
        }
    }
    

}
