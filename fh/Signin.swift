//
//  Signin.swift
//  fh
//
//  Created by User07 on 2020/1/13.
//  Copyright © 2020 gza. All rights reserved.
//

import Firebase
import UIKit

class Signin: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
           try Auth.auth().signOut()
        } catch {
           print(error)
        }
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBSegueAction func success(_ coder: NSCoder) -> Personalfile? {
        return Personalfile(coder: coder, account: user.text!)
    }
    @IBAction func m_signin(_ sender: Any) {
        Auth.auth().signIn(withEmail: user.text!, password: password.text!) { [weak self] (result, error) in
                    guard let self = self else { return }
                    guard error == nil else {
                        print(error?.localizedDescription)
                        return
                    }
                    self.dismiss(animated: true, completion: nil)
                    self.performSegue(withIdentifier: "success", sender: nil)        }
    }
}
