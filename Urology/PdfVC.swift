//
//  PdfVC.swift
//  Urology
//
//  Created by Han on 5/19/18.
//  Copyright © 2018 Han. All rights reserved.
//

import UIKit
import MBProgressHUD
import WebKit

class PdfVC: UIViewController, WKNavigationDelegate  {

    @IBOutlet weak var webView: WKWebView!
    var loadingNotification: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        
        let pdfRef = storageRef.child(AppManager.shared.selectedPath)
        
        pdfRef.downloadURL { url, error in
            if let error = error {
            
                self.loadingNotification.hide(animated: true)
                AppManager.shared.showAlert(msg: error.localizedDescription, activity: self)
                
            } else {
                
                self.webView.load(URLRequest(url: url!))
                
            }
               
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        self.loadingNotification.hide(animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
