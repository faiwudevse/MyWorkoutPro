//
//  TmeTextFieldDelegate.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/18/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//

import Foundation
import UIKit

class TimeTextFieldDelegate: NSObject, UITextFieldDelegate{
    // Time Format
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        var newText = oldText.replacingCharacters(in: range, with: string)
        var newTextString = String(newText)
        
        let digits = CharacterSet.decimalDigits
        var digitText = ""
        for c in newTextString.unicodeScalars {
            if digits.contains(UnicodeScalar(c.value)!) {
                digitText.append("\(c)")
            }
        }
        let digitNum = Int(digitText)!
        digitText = String(describing: digitNum)
        if digitText.count > 6 {
            return false
            
        }
        else{
            if digitText.count > 0 {
                newText = ""
                
                while digitText.count < 6{
                    digitText = "0" + digitText
                }
                
                let digitTextArray = Array(digitText)
                
                newText.append(digitTextArray[0])
                newText.append(digitTextArray[1])
                newText.append(":")
                newText.append(digitTextArray[2])
                newText.append(digitTextArray[3])
                newText.append(":")
                newText.append(digitTextArray[4])
                newText.append(digitTextArray[5])
            } else {
                newText = "00:00:00"
            }
        }
        
        textField.text = newText
        
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
