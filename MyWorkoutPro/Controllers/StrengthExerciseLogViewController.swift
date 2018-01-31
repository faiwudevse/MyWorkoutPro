//
//  StrengthExerciseLogViewController.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/12/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//

import UIKit
import CoreData
class StrengthExerciseLogViewController: UIViewController {
    // MARK: Properties
    var workoutExercise: WorkoutExercise?
    var strengthLogExerciseSets = [StrengthExerciseSet]()
    let context = (UIApplication.shared.delegate as! AppDelegate).stack.context
    let floatNumberTextFieldDelegate = DecimcalNumberTextFieldDelegate()
    let numberTextFieldDelegate = NumberTextFieldDelegate()
    
    // MAKR: Outlets
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
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
        repsTextField.inputAccessoryView = toolbar
        repsTextField.inputAccessoryView = toolbar
        
        weightTextField.inputAccessoryView = toolbar
        weightTextField.inputAccessoryView = toolbar
        
        repsTextField.text = "0"
        weightTextField.text = "0.0"
        
        repsTextField.delegate = self.numberTextFieldDelegate
        weightTextField.delegate = self.floatNumberTextFieldDelegate
        
        if (workoutExercise?.resistance)! {
            weightLabel.isHidden = true
            weightTextField.isHidden = true
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Set" , style: .plain, target: self, action: #selector(addSet))
        let request : NSFetchRequest<StrengthExerciseSet> = StrengthExerciseSet.fetchRequest()
        let pred = NSPredicate(format: "workoutexercise = %@", argumentArray: [workoutExercise!])
        request.predicate = pred
        do{
            let fetchedStrenghtExerciseSets = try context.fetch(request)
            for strengthExerciseSet in fetchedStrenghtExerciseSets{
                strengthLogExerciseSets.append(strengthExerciseSet)
            }
            
        }catch{
            print("error")
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    @objc func addSet(){
        if (weightTextField.text?.isEmpty)!{
            weightTextField.text = "0.0"
        }

        if (repsTextField.text?.isEmpty)!{
            repsTextField.text = "0"
        }

        let set = StrengthExerciseSet(weight: Float(weightTextField.text!)!, resistance: Int16(repsTextField.text!)!, context: context)
        set.workoutexercise = workoutExercise
        strengthLogExerciseSets.append(set)
        tableView.reloadData()
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
}

extension StrengthExerciseLogViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strengthLogExerciseSets.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setCell", for: indexPath)
        let set = strengthLogExerciseSets[indexPath.row]
        let rep = set.resistance
        let weight = set.weight
        var text = ""
        if (workoutExercise?.resistance)! {
            text += String(indexPath.row + 1) + ". " + String(describing: rep)
        }else{
            text += String(indexPath.row + 1) + ". " + String(describing: rep) + " x " + String(describing: weight) + "lb"
        }
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(strengthLogExerciseSets[indexPath.row])
            strengthLogExerciseSets.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.reloadData()
        }
    }
    
}


