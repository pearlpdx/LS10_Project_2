//
//  CueTableViewCell.swift
//  LS10_Project
//
//  Created by Home on 3/15/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class CueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cueImage: UIImageView!
    @IBOutlet weak var cueName: UILabel!
        
    @IBOutlet weak var cueDetailTextBox: UILabel!
    
    @IBOutlet weak var cueCellView: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        cueCellView.layer.cornerRadius = 5
        //cueImage.layer.borderColor =
        cueImage.layer.borderWidth = 2
           }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(cue: Cue) {
        
        cueName.text = "Cue: \(Int(cue.number)) \n\(cue.name)"
        cueDetailTextBox.text = "Fade: 5 seconds \nColor: 0 seconds  --  Link: 5 seconds To: Cue 10"
       
    }

}
