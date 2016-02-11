//
// CollectionFixtureCell.swift
//  LS_Layout
//
//  Created by Home on 2/2/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class CollectionFixtureCell: UICollectionViewCell {
    
    @IBOutlet weak var chanName: UILabel!
    
    @IBOutlet weak var imgColor: UIImageView!
  
    
    
    
    var channel: Channel!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(channel: Channel) {
        
        self.channel = channel
        
        chanName.text = self.channel.name
       
        imgColor.backgroundColor = channel.getDislayColor()
 
    }

    
}
