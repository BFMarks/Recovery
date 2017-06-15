//
//  ScheduleCell.swift
//  RecoveryAI
//
//  Created by Bryan Marks on 2/12/17.
//  Copyright © 2017 Bryan Marks. All rights reserved.
//

import UIKit
import Foundation
import AVKit
import AVFoundation


class ScheduleViewCell: UITableViewCell {
    
    @IBOutlet weak var button: UIButton!
    //    var cellLabel: UILabel!
    
//    @IBOutlet weak var thumbnail: UIImageView!
    
    
    @IBOutlet weak var title: UILabel!
//    @IBOutlet weak var label: UILabel!
    
//    @IBOutlet weak var date: UILabel!
//    //    weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
