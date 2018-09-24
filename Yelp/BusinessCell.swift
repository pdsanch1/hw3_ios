//
//  BusinessCell.swift
//  Yelp
//
//  Created by Pedro Daniel Sanchez on 9/23/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    // @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business! {
        didSet {    // Observable, whenever business is set do the block
            nameLabel.text = business.name
            distanceLabel.text = business.distance
            addressLabel.text = business.address
            reviewCount.text = "\(business.reviewCount!) Reviews"
            categoriesLabel.text = business.categories
            thumbImageView.setImageWith(business.imageURL!)
            ratingImageView.image = business.ratingImage
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
