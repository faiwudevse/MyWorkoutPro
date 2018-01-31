//
//  TextFieldDelegate.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/19/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//

import Foundation
import UIKit

class DecimcalNumberTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)
        let newTextString = String(newText)
        var myRet = true
        if newTextString == "." {
            return false
        }
        if newTextString.contains(".") {
            let newTextStringSplit = newTextString.split(separator: ".", maxSplits: 1)
            if newTextStringSplit.count == 2{
                if newTextStringSplit[0].contains(".") || newTextStringSplit[1].contains("."){
                    myRet = false
                }
                else{
                    if newTextStringSplit[1].count > 2{
                        myRet = false
                    }
                    if newTextStringSplit[0].count > 3{
                        myRet = false
                    }
                }
            }
        }
        else{
            if newTextString.count > 3{
                myRet = false
            }
        }
        return myRet
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
