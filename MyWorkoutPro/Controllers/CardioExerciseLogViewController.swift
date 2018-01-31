//
//  CardioExerciseLogViewController.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/12/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CardioExerciseLogViewController: UIViewController {
    var workoutExercise: WorkoutExercise?
    let stack = (UIApplication.shared.delegate as! AppDelegate).stack
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceTextField: UITextField!
    let timeDelegate = TimeTextFieldDelegate()
    let distanceDelegate = DecimcalNumberTextFieldDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        //setting toolbar as inputAccessoryView
        durationTextField.inputAccessoryView = toolbar
        distanceTextField.inputAccessoryView = toolbar
        
        // setting default text
        distanceTextField.text = "0.0"
        durationTextField.text = "00:00:00"
        
        // setting delegate to the text field
        durationTextField.delegate = self.timeDelegate
        distanceTextField.delegate = self.distanceDelegate
        
        let request: NSFetchRequest<CardioExerciseSet> = CardioExerciseSet.fetchRequest()
        let pred = NSPredicate(format: "workoutexercise = %@", argumentArray: [workoutExercise!])
        let moc = stack.context
        request.predicate = pred
        do{
            let fetchedCardioSets = try moc.fetch(request)
            for cardioSet in fetchedCardioSets{

                durationTextField.text = cardioSet.duration
                distanceTextField.text = String(cardioSet.distance)
            }
        } catch {
            print("error")
        }
        if !(workoutExercise?.distance)! {
            distanceLabel.isHidden = true
            distanceTextField.isHidden = true
        }
        
    }
    // save the data 
    override func viewWillDisappear(_ animated: Bool) {
        if (durationTextField.text?.isEmpty)! {
            durationTextField.text = "00:00:00"
        }
        if (distanceTextField.text?.isEmpty)! {
            distanceTextField.text = "0.0"
        }
        
        let cardioSet = CardioExerciseSet(distance: Float(distanceTextField.text!)!, duration: durationTextField.text!, context: stack.context)
        cardioSet.workoutexercise = workoutExercise
    }
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
}

