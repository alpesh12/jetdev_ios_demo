//
//  UIViewController+JetDevs.swift
//  JetDevsHomeWork
//
//  Created by Avruti on 09/12/22.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
   func showHUD() {
      let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
       indicator.label.text = "please wait..."
       indicator.isUserInteractionEnabled = false
       indicator.detailsLabel.text = ""
       indicator.show(animated: true)
   }
   func hideHUD() {
      MBProgressHUD.hide(for: self.view, animated: true)
   }
}
