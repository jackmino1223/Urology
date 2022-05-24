//
//  DictationVC.swift
//  Urology
//
//  Created by Han on 5/19/18.
//  Copyright © 2018 Han. All rights reserved.
//

import UIKit
import MBProgressHUD

class DictationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dictationTable: UITableView!
    
    var dictationTitleArray: [String] = []
    var dictationPathArray: [String] = []
    
    var loadingNotification: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""

        dictationTable.delegate = self
        dictationTable.dataSource = self
        
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        
        databaseRef.child(String(AppManager.shared.selectdSectionIndex)).observe(.value, with: { (snapshot) in
            
            if snapshot.exists(){
                
                var value = snapshot.value as! [String: String]
                
                self.dictationTitleArray = Array(value.keys)
                self.dictationTitleArray.sort(by: {$0 < $1} )

                for title in self.dictationTitleArray{
                    self.dictationPathArray.append(value[title]!)
                }
                
                self.dictationTable.reloadData()
                
            }
            
            self.loadingNotification.hide(animated: true)

        }) { (error) in
            AppManager.shared.showAlert(msg: error.localizedDescription, activity: self)
            self.loadingNotification.hide(animated: true)
        }
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dictationTitleArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.dictationTitleArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        AppManager.shared.selectedPath = dictationPathArray[indexPath.row]
        self.performSegue(withIdentifier: "PdfSegue", sender: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
