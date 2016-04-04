//
//  GelTableViewCell.swift
//  colorPickerTest
//
//  Created by Gordon Pearlman on 2/28/16.
//  Copyright © 2016 Gordon Pearlman. All rights reserved.
//

import UIKit

class GelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mfgLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    var gel: GelRGB!
    var curColor: UIColor?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func confirgerCell(gel: GelRGB) {
        self.gel = gel
        numberLbl.text = gel.number
        nameLbl.text = gel.name
       // mfgLbl.text = gel.mfg
        
        self.colorView.layer.borderColor = UIColor.blackColor().CGColor
        self.colorView.layer.borderWidth = 2.0

        
        curColor = UIColor(colorLiteralRed: gel.red, green: gel.green,
                    blue: gel.blue, alpha: 1.0)
        
        colorView.backgroundColor = curColor
    }
    

}
