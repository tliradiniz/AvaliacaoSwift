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
        
        self.ref.child("locations").observe(.childRemoved, with: { (snapshot) in
            let key = snapshot.key
            
            for (index, location) in self.locations.enumerated() {
                if location.ref!.key == key {
                    self.locations.remove(at: index)
                    let indexPath = IndexPath(row: index, section: 0)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    break;
                }
            }
        })
        
    

        
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

        let location = self.locations[indexPath.row]
        
        cell.textLabel?.text = location.location
        cell.detailTextLabel?.text = "Disponibilidade :"
        
        if (location.isFull) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        let local = self.locations[indexPath.row]
        let newFull = local.isFull
        let newMember = local.members
        let newLocation = local.location
        local.ref?.updateChildValues(["isFull":newFull, "members":newMember ,"location":newLocation])
    }
    
  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let location = self.locations[indexPath.row]
            location.ref?.removeValue()
        }
    }
 

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

   
//PARAMOS AQUI
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Update" {
            if let novaView = segue.destination as? LocalViewController{
                let localPos = tableView.indexPathForSelectedRow?.row
                self.local = self.locations[localPos!]
                let newFull = local.isFull
                let newMember = local.members
                let newLocation = local.location
                local.ref?.updateChildValues(["isFull":newFull, "members":newMember ,"location":newLocation])
            }
        }
    }



}
