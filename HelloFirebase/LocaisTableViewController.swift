//
//  LocaisTableViewController.swift
//  HelloFirebase
//
//  Created by alunor17 on 06/06/2019.
//  Copyright © 2019 Daniel Valente. All rights reserved.
//

import UIKit
import Firebase

class LocaisTableViewController: UITableViewController {

    
    var locations = [Location]()
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locais"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.ref.child("locations").observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value as! [String: Any]
            
            let newLocation = Location(location: value["location"] as! String, members: value["members"] as! Int, isFull: value["isFull"] as! Bool, ref: snapshot.ref)
            
            self.locations.append(newLocation)
            
            let indexPath = IndexPath(row: self.locations.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
        })
        //Remover
        //Item removido
//        self.ref.child("items").observe(.childRemoved, with: { (snapshot) in
//            let key = snapshot.key
//            
//            for (index, item) in self.items.enumerated() {
//                if item.ref!.key == key {
//                    self.items.remove(at: index)
//                    let indexPath = IndexPath(row: index, section: 0)
//                    self.tableView.deleteRows(at: [indexPath], with: .fade)
//                    break;
//                }
//            }
//        })
//        
//        //Alterar
//        //Item alterado
//        self.ref.child("items").observe(.childChanged, with: { (snapshot) in
//            let key = snapshot.key
//            let updatedValue = snapshot.value as! [String:Any]
//            
//            for (index, item) in self.items.enumerated() {
//                if item.ref!.key == key {
//                    self.items[index].completed = updatedValue["completed"] as! Bool
//                    break;
//                }
//            }
//            
//            self.tableView.reloadData()
//        })
//        // Do any additional setup after loading the view.
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.locations.count
    }
    
    @IBAction func LogOutButton(_ sender: UIBarButtonItem) {
        try? Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
