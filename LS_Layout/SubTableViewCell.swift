//
//  SubTableViewCell.swift
//  LS10_Project
//
//  Created by Home on 3/16/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class SubTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subViewCell: UIView!    
    @IBOutlet weak var subNameLbl: UILabel!
    @IBOutlet weak var subDetailLbl: UILabel!
    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var subSlider: UISlider!

    override func awakeFromNib() {
        super.awakeFromNib()
        subViewCell.layer.cornerRadius = 5
        subButton.layer.borderWidth = 2
        subSlider.setThumbImage(UIImage(named: "sliderTick"), forState: UIControlState.Normal)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(sub: Sub) {
        
        subNameLbl.text = "SubMaster: \(Int(sub.number)) \n\(sub.name)"
        subDetailLbl.text = "Fade Time:  5 seconds"
        subSlider.value = 0.0
        
    }

    @IBAction func subButPressed(sender: AnyObject) {
        
        
    }

}
