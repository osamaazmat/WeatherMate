//
//  SettingsTableViewCell.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 28/05/2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    static let cellNibName = "SettingsTableViewCell"
    static let cellReuseIdentifier = "settingsTableViewCell"
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
