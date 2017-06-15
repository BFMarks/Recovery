//
//  TableViewCell.swift
//  MorseCode
//
//  Created by Bryan Marks on 8/3/16.
//  Copyright © 2016 Bryan Marks. All rights reserved.
//
import UIKit
import Foundation
import AVKit
import AVFoundation


class TableViewCell: UITableViewCell {
    var button: UIButton!
//    var cellLabel: UILabel!

    @IBOutlet weak var thumbnail: UIImageView!
    
    
    @IBOutlet weak var title: UILabel!
   @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textFieldExercises: UITextView!
//    weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
