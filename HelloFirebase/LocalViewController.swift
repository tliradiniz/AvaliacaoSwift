//
//  LocalViewController.swift
//  HelloFirebase
//
//  Created by Aluno R17 on 07/06/19.
//  Copyright © 2019 Daniel Valente. All rights reserved.
//

import UIKit
import Firebase

class LocalViewController: UIViewController {

    var count = 0
    var ref: DatabaseReference! = Database.database().reference()
    @IBOutlet weak var grupoNome: UITextField!
    
    @IBOutlet weak var localNome: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func Count(_ sender: UIStepper) {
        label.text = Int(sender.value).description
        //UIStepper.set
    }
    @IBAction func salvar(_ sender: Any) {
       
        let newLocation = Location(location: localNome!.text!, members: Int(label!.text!)!, isFull: false, ref: nil)
        self.ref.child("locations").childByAutoId().setValue(newLocation.toAnyObject())
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = String(count)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
