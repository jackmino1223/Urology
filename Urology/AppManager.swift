//
//  AppManager.swift
//  Parikramas
//
//  Created by Admin on 10/12/17.
//  Copyright © 2017 Han. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseStorage

let databaseRef: DatabaseReference = Database.database().reference()
let storageRef: StorageReference = Storage.storage().reference()

final class AppManager {
    
    static let shared: AppManager = {
        return AppManager()
    }()
    
    private init() { }
    
    var selectdSectionIndex: Int!
    var selectedPath: String!
    
    func showAlert(msg: String, activity: UIViewController) -> Void {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        activity.present(alert, animated: true, completion: nil)
    }

    
    
}
