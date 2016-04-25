//
//  GelTableViewHeaderCell.swift
//  colorPickerTest
//
//  Created by Gordon Pearlman on 3/2/16.
//  Copyright © 2016 Gordon Pearlman. All rights reserved.
//

import UIKit

class GelTableViewHeaderCell: UITableViewCell {
    
    @IBOutlet weak var mfgHeaderLbl: UILabel!
    @IBOutlet weak var mfgHeaderImage: UIImageView!
    
    var sec: GelSection!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(sec: GelSection) {
        self.sec = sec
        mfgHeaderLbl.text = sec.mfg
       //todo Image
    }

}
