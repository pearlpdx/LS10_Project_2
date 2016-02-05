//
//  ChannelCollectionCellVC.swift
//  LS_Layout
//
//  Created by Home on 2/2/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class ChannelCollectionCellVC: UICollectionViewCell {
    
    @IBOutlet weak var chanName: UILabel!
    
    @IBOutlet weak var chanColor: UIView!
    
    
    
    var channel: Channel!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(channel: Channel) {
        
        self.channel = channel
        
        chanName.text = self.channel.name
        chanColor.layer.cornerRadius = 15.0
        
        
        
//        nameLbl.text = self.pokemon.name.capitalizedString
//        thumbImg.image =    UIImage(named: "\(self.pokemon.pokedexID)")
        
        
    }

    
}
