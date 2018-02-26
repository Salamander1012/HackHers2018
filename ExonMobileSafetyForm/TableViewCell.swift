//
//  TableViewCell.swift
//  ExonMobileSafetyForm
//
//  Created by Salman Fakhri on 2/25/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var safetyPicture: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var severityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var severityNum: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
