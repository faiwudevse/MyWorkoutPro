//
//  WorkoutExerciseTableViewCell.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/12/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//

import UIKit

class WorkoutExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var workoutDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        workoutDescription.isSelectable = false
        workoutDescription.isEditable = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
