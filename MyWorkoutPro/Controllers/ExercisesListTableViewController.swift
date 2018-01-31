//
//  ExerciseListTableViewController.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/24/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//

import UIKit
import CoreData

class ExercisesListTableViewController: CoreDataTableViewController {
    // MARK: Properties
    var workout: Workout?
    let stack = (UIApplication.shared.delegate as! AppDelegate).stack
    let searchController = UISearchController(searchResultsController: nil)
    var filteredExercises = [Exercise]()
    var exercises = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Exercises"
        // Create a fetchrequest
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        fr.sortDescriptors = []
        
        // Create the FetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        exercises = fetchedResultsController?.fetchedObjects as! [Exercise]
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Exercises"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = ["All", "Cardio", "Strength"]
        searchController.searchBar.delegate = self
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewExercise))
    }
    
    @objc func addNewExercise(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "CreateANewExerciseViewController") as! CreateANewExerciseViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredExercises.count
        }
        if let fc = fetchedResultsController {
            return fc.sections![section].numberOfObjects
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
        
        let exercise: Exercise
        
        if  isFiltering() {
            exercise = filteredExercises[indexPath.row]
        } else{
            exercise = fetchedResultsController!.object(at: indexPath) as! Exercise
        }
        cell.textLabel?.text = exercise.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let exercise: Exercise
        
        if isFiltering() {
            exercise = filteredExercises[indexPath.row]
        } else {
            exercise = fetchedResultsController!.object(at: indexPath) as! Exercise
        }
        
        let myExercise = WorkoutExercise(distance: exercise.distance, duration: exercise.duration, name: exercise.name!, resistance: exercise.resistance, type: exercise.type, weight: exercise.weight, context: stack.context)
        
        if exercise.type == 0 {
            myExercise.strengthexercises = nil
        }
        else{
            myExercise.cardioexercise = nil
        }
        
        let controller = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2] as! WorkoutExercisesViewController
        controller.myWorkoutExercise.append(myExercise)
        if workout != nil{
            myExercise.workout = workout
        }
        self.navigationController?.popViewController(animated: true)
    }

    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filteredExercises = exercises.filter({( exercise : Exercise) -> Bool in
            let categoryTypeStr: String
            if exercise.type == 0{
                categoryTypeStr = "Cardio"
            }
            else{
                categoryTypeStr = "Strength"
            }
            let doesCategoryMatch = (scope == "All") || (categoryTypeStr == scope)
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else{
                return doesCategoryMatch && (exercise.name?.lowercased().contains(searchText.lowercased()))!
            }
        })
        
        tableView.reloadData()
    }
}

extension ExercisesListTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension ExercisesListTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

