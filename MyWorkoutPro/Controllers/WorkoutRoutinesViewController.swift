//
//  WorkoutViewController.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 12/5/17.
//  Copyright © 2017 Fai Wu. All rights reserved.
//

import UIKit
import CoreData

class WorkoutRoutinesViewController: CoreDataTableViewController {
    
    let stack = (UIApplication.shared.delegate as! AppDelegate).stack
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addWorkoutexercises))
        self.navigationItem.title = "Workout Routines"
        //self.navigationController?.title = "Workout Routines"
        // fetch all the workouts
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")
        fr.sortDescriptors = []
        
        // Create the FetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wr = fetchedResultsController!.object(at: indexPath) as! Workout
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath)
        cell.textLabel?.text = wr.name
        return cell
    }
    
    @objc func addWorkoutexercises(_ sender:UIBarButtonItem!){
        let controller = storyboard?.instantiateViewController(withIdentifier: "WorkoutExercisesViewController") as! WorkoutExercisesViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "WorkoutExercisesViewController") as! WorkoutExercisesViewController
        controller.workout = fetchedResultsController?.object(at: indexPath) as? Workout
        self.navigationController?.pushViewController(controller, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let context = fetchedResultsController?.managedObjectContext, let workout = fetchedResultsController?.object(at: indexPath) as? Workout, editingStyle == .delete {
            context.delete(workout)
        }
    }
    
}
