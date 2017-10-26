//
//  DetailTableViewCell.swift
//  DiveAppFirebase
//
//  Created by Trym Lintzen on 24-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oceanLabel: UITextField!
    @IBOutlet weak var depthMetresLabel: UITextField!
    @IBOutlet weak var idLabel: UITextField!
    @IBOutlet weak var imageField: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
