//
//  SectionVC.swift
//  Urology
//
//  Created by Han on 5/19/18.
//  Copyright © 2018 Han. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var sectionTableView: UITableView!
    
    var sectionArray = ["Sample Dictations", "Common order sets", "Common Medications/Dosages", "Common on call presentations/ trouble shooting"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        databaseRef.child("sections").observe(.value, with: { (snapshot) in
            
            if snapshot.exists(){
            
                let section = snapshot.value as! [String: String]
                
                let extras = Array(section.values)
                
                self.sectionArray += extras
                
                self.sectionTableView.reloadData()
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
            
        sectionTableView.delegate = self
        sectionTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SectionCell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! SectionCell
        cell.sectionLabel.text = sectionArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppManager.shared.selectdSectionIndex = indexPath.row
        self.performSegue(withIdentifier: "SectionSegue", sender: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
