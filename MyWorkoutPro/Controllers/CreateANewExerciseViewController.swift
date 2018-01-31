//
//  CreateANewExerciseViewController.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 12/22/17.
//  Copyright © 2017 Fai Wu. All rights reserved.
//

import UIKit

class CreateANewExerciseViewController: UITableViewController{
    
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var strengthCell: UITableViewCell!
    @IBOutlet weak var durationSwitchBtn: UISwitch!
    @IBOutlet weak var distanceSwitchBtn: UISwitch!
    @IBOutlet weak var resistanceSwitchBtn: UISwitch!
    @IBOutlet weak var weigthSwitchBtn: UISwitch!
    var selectedIndex: IndexPath?
    var selectedSwitchBtn: UISwitch?
    let stack = (UIApplication.shared.delegate as! AppDelegate).stack
    //let helperClass = HelperViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New Exercise"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        textfield.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        selectedIndex = self.tableView.indexPath(for: strengthCell!)
        self.tableView.cellForRow(at: selectedIndex!)?.accessoryType = .checkmark
        distanceSwitchBtn.isEnabled = false
    }
    
    @objc func save(){
        if textfield.text == ""{
            displayError("Please fill the exercise name","")
        }
        else{
            let type: Int16 = selectedIndex?.row == 0 ? 0: 1
            _ = Exercise(distance: distanceSwitchBtn.isOn, duration: durationSwitchBtn.isOn, name: textfield.text!, resistance: resistanceSwitchBtn.isOn, type: type, weight: weigthSwitchBtn.isOn, context: stack.context)
            self.navigationController?.popViewController(animated: true)
            stack.save()
        }
    }

    @IBAction func switchButton(_ sender: UISwitch) {
        if selectedIndex?.row == 0 {
            durationSwitchBtn.setOn(true, animated: false)
        }else{
            oneSwitchBtnOn(sender)
        }
    }
    
    enum ButtonType: Int {
        case Distance = 0, Duration, Reps, Weight
    }
    
    
    func allSwitchBtns(_ state: Bool){
        durationSwitchBtn.setOn(state, animated: false)
        distanceSwitchBtn.setOn(state, animated: false)
        resistanceSwitchBtn.setOn(state, animated: false)
        weigthSwitchBtn.setOn(state, animated: false)
    }
    
    func oneSwitchBtnOn(_ onSwitchBtn : UISwitch){
        allSwitchBtns(false)
        switch (ButtonType(rawValue: onSwitchBtn.tag)!) {
        case .Distance:
            distanceSwitchBtn.setOn(true, animated: false)
        case .Duration:
            durationSwitchBtn.setOn(true, animated: false)
        case .Reps:
            resistanceSwitchBtn.setOn(true, animated: false)
        case .Weight:
            weigthSwitchBtn.setOn(true, animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if selectedIndex != nil {
                tableView.cellForRow(at: selectedIndex!)?.accessoryType = .none
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            selectedIndex = indexPath
            if selectedIndex?.row == 0 {
                allSwitchBtns(true)
                distanceSwitchBtn.isEnabled = true
                weigthSwitchBtn.setOn(false, animated: false)
                weigthSwitchBtn.isEnabled = false
            }else{
                allSwitchBtns(false)
                weigthSwitchBtn.isEnabled = true
                weigthSwitchBtn.setOn(true, animated: false)
                distanceSwitchBtn.isEnabled = false
            }
        }
    }
}

extension CreateANewExerciseViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
}
