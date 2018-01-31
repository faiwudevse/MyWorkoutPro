//
//  WorkoutExeciseViewController.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 12/15/17.
//  Copyright © 2017 Fai Wu. All rights reserved.
//

import UIKit
import CoreData

class WorkoutExercisesViewController: UIViewController {
    // MARK: Properties
    var myWorkoutExercise = [WorkoutExercise]()
    var workout : Workout?
    let stack = (UIApplication.shared.delegate as! AppDelegate).stack
    var rowHeights = [Int]()
    
    // MARK: Outlets
    @IBOutlet weak var workoutNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    // MAKR: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Workout"
        if workout != nil {
            workoutNameTextField.text = workout?.name
            let request: NSFetchRequest<WorkoutExercise> = WorkoutExercise.fetchRequest()
            let pred = NSPredicate(format: "workout = %@", argumentArray: [workout!])
            let moc = stack.context
            request.predicate = pred
            do{
                let fetchedWorkoutExercises = try moc.fetch(request)
                for workoutExercise in fetchedWorkoutExercises{
                    myWorkoutExercise.append(workoutExercise)
                }
            } catch {
                print("error")
            }
        }else{
             self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save" , style: .plain, target: self, action: #selector(self.saveWorkOut(_:)))
        }
    }
    // save the exisst exercise to the workout
    override func viewWillDisappear(_ animated: Bool) {
        if workout != nil {
            workout?.name = workoutNameTextField.text!
            stack.save()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rowHeights = []
        tableView.reloadData()
    }
    
    @objc func saveWorkOut(_ sender:UIBarButtonItem!){
        let workoutName = workoutNameTextField.text!
        let myWorkoutRoutine = Workout(name: workoutName, context: stack.context)
        for exercise in myWorkoutExercise{
            exercise.workout = myWorkoutRoutine
        }
        stack.save()
        self.navigationController?.popViewController(animated: true)
    }
    @objc func cancelButtn(_ sender:UIBarButtonItem!){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addExercises(_ sender: Any) {        
        let controller = storyboard?.instantiateViewController(withIdentifier: "ExercisesListTableViewController") as! ExercisesListTableViewController
        
        if workout != nil {
            controller.workout = workout
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension WorkoutExercisesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWorkoutExercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // fetch  strength and cardio exercises and display the detail of them
        let myCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! WorkoutExerciseTableViewCell
        let workoutExercise = myWorkoutExercise[indexPath.item]
        myCell.workoutLabel.text = workoutExercise.name
        var mydescription = ""
        var rowHeight = 0
        if workoutExercise.type == 0{
            let request: NSFetchRequest<CardioExerciseSet> = CardioExerciseSet.fetchRequest()
            let pred = NSPredicate(format: "workoutexercise = %@", argumentArray: [workoutExercise])
            let moc = stack.context
            request.predicate = pred
            do{
                let fetchedCardioSets = try moc.fetch(request)
                for cardioSet in fetchedCardioSets{
                    
                    mydescription += "Duration: " + cardioSet.duration!
                    mydescription += " Distance: " + String(cardioSet.distance)
                }
            } catch {
                print("Error not able to fetch the results")
            }
        }else {
            let request: NSFetchRequest<StrengthExerciseSet> = StrengthExerciseSet.fetchRequest()
            let pred = NSPredicate(format: "workoutexercise = %@", argumentArray: [workoutExercise])
            let moc = stack.context
            request.predicate = pred
            var cnt = 1
            do{
                let fetchedStrengthSets = try moc.fetch(request)
                for strengthSet in fetchedStrengthSets{
                    
                    if workoutExercise.weight{
                        mydescription += String(cnt) + ". " + String(describing: strengthSet.resistance) + " x " + String(describing: strengthSet.weight) + "lb\n"
                    }
                    else{
                        mydescription += String(cnt) + ". " + String(describing: strengthSet.resistance) + " x "
                    }
                    cnt += 1
                }
            } catch {
                print("error")
            }
            rowHeight = cnt
        }
        rowHeights.append(rowHeight)
        myCell.workoutDescription.text = mydescription
        myCell.workoutDescription.isEditable = false
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if myWorkoutExercise[indexPath.item].type == 0{
            let controller = storyboard?.instantiateViewController(withIdentifier: "CardioExerciseLogViewController") as! CardioExerciseLogViewController
            controller.workoutExercise = myWorkoutExercise[indexPath.item]
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            let controller = storyboard?.instantiateViewController(withIdentifier: "StrengthExerciseLogViewController") as! StrengthExerciseLogViewController
            controller.workoutExercise = myWorkoutExercise[indexPath.item]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if rowHeights.count > indexPath.row{
            if rowHeights[indexPath.row] != 0{
                var row = rowHeights[indexPath.row]
                row = row * 12 + 60
                return CGFloat(row)
            }
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            stack.context.delete(myWorkoutExercise[indexPath.row])
            myWorkoutExercise.remove(at: indexPath.row)
            rowHeights.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}





