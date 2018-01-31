//
//  NumberTextFieldDelegate.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/20/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//

import Foundation
import UIKit
class NumberTextFieldDelegate: NSObject, UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)
        let newTextString = String(newText)
        
        return newTextString.count > 3 ? false : true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
