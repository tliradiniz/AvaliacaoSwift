//
//  ViewController.swift
//  HelloFirebase
//
//  Created by Daniel Valente on 16/05/19.
//  Copyright © 2019 Daniel Valente. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var handler: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handler = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let _ = user {
                print("LOGOU")
                self.performSegue(withIdentifier: "LoggedIn", sender: nil)
            }
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { authResult, error in
            
            guard let user = authResult else {
                print("Não foi possível logar com o usuário!")
                return
            }
            
            print("Usuário logado com sucesso \(user.user.email!)")
        }
    }    
    
    @IBAction func signUpButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { authResult, error in
            
            guard let user = authResult?.user else {
                print("Não foi possível criar o usuário!")
                return
            }
            
            print("Usuário criado com sucesso \(user.email!)")
        }
    }
}

