//
//  SwitchCell.swift
//  Yelp
//
//  Created by Pedro Daniel Sanchez on 9/24/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchcell: SwitchCell,
        didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        onSwitch.addTarget(self, action: #selector(SwitchCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func switchValueChanged() {
        print("switch values changed")
        //if delegate != nil {
            delegate?.switchCell?(switchcell: self, didChangeValue: onSwitch.isOn)
        //}
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
