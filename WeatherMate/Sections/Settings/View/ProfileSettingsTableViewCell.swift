//
//  ProfileSettingsTableViewCell.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 29/05/2022.
//

import UIKit

class ProfileSettingsTableViewCell: UITableViewCell {

    static let cellNibName = "ProfileSettingsTableViewCell"
    static let cellReuseIdentifier = "profileSettingsTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
