//
//  TableFixtureCell.swift
//  LS_2016
//
//  Created by Home on 1/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class TableFixtureCell: UITableViewCell {
    
    var fixture: Fixture!
    weak var tableVC: ViewController?
    
    
    @IBOutlet weak var fixtureCellView: UIView!

    @IBOutlet weak var fixtureNum: UILabel!
    @IBOutlet weak var fixtureSlider: UISlider!
    @IBOutlet weak var fixtureName: UILabel!
    @IBOutlet weak var fixtureLevel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var butLocked: UIButton!
    @IBOutlet weak var colorButtonOverlayed: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //format slider and current color View
        fixtureSlider.setThumbImage(UIImage(named: "thumbNormal"), forState: UIControlState.Normal)
        fixtureSlider.setThumbImage(UIImage(named: "thumbActive"), forState: UIControlState.Highlighted)
        colorView.layer.cornerRadius = 10
        colorView.layer.borderWidth = 2
        fixtureCellView.layer.cornerRadius = 5
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//            }
    
    
    func configureCell(channel: Fixture) {
        self.fixture = channel
        fixtureName.text = channel.name
        butLocked.hidden = !channel.independent
        fixtureSlider.value = fixture.indLevel
        fixtureLevel.text = "\(Int(fixture.indLevel * 100))%"
        
        if channel.style == "Intensity" {
            colorView.hidden = true
            colorButtonOverlayed.enabled = false
        }   else {
            colorView.hidden = false
            colorButtonOverlayed.enabled = true
            colorView.backgroundColor = channel.getDislayColor()
        }
       fixtureNum.text = channel.number
        
        //dynamic level
        // channelSlider.addTarget(self, action: Selector("SliderAction:"), forControlEvents: .ValueChanged)
//        var lev = 0.0
//        lev.addTarget(self, action: Selector("SliderAction:"), forControlEvents: .ValueChanged)
    }
    
    
    @IBAction func colorButOverlayPressed(sender: AnyObject) {
        self.fixture.independent = true
        butLocked.hidden = false
        tableVC?.indOffButton.hidden = false
    }
  
    @IBAction func sliderValueChanged(sender: UISlider) {
        self.fixture.independent = true
        butLocked.hidden = false
        self.fixture.indLevel = sender.value
        tableVC?.indOffButton.hidden = false

        
        //temp
        fixtureLevel.text = "\(Int(sender.value * 100))%"
    }
    
    //IndButton Presses
    @IBAction func lockButPressed(sender: AnyObject) {
        
        self.fixture.independent = false
        butLocked.hidden = true
        tableVC?.checkIndOff()
    }
}
