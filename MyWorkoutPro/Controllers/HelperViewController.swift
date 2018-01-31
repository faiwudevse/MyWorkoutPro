//
//  Helper.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/29/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func displayError(_ title:String, _ error:String){
        let alertView = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Dismiss", style: .`default`, handler: nil))
        let messageFont = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: 15.0)!]
        let messageAttrString = NSMutableAttributedString(string: error, attributes: messageFont)
        alertView.setValue(messageAttrString, forKey: "attributedMessage")
        self.present(alertView, animated: true, completion: nil)
    }
}
