//
// CollectionFixtureCell.swift
//  LS_Layout
//
//  Created by Home on 2/2/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class CollectionFixtureCell: UICollectionViewCell {
    
    @IBOutlet weak var fixtureName: UILabel!
    
    @IBOutlet weak var imgColor: UIImageView!
  
    
    
    
    var fixture: Fixture!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(fixture: Fixture) {
        
        self.fixture = fixture
        
        fixtureName.text = self.fixture.name
       
        imgColor.backgroundColor = fixture.getRGBColor()
 
    }
}