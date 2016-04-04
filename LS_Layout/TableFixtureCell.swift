//
//  TableFixtureCell.swift
//  LS_2016
//
//  Created by Home on 1/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class TableFixtureCell: UITableViewCell {
    
    var fixture: Channel!
    weak var tableVC: ViewController?
    
    
    @IBOutlet weak var fixtureCellView: UIView!

    @IBOutlet weak var channelNum: UILabel!
    @IBOutlet weak var channelSlider: UISlider!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var channelLevel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var butLocked: UIButton!
    @IBOutlet weak var colorButtonOverlayed: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //format slider and current color View
        channelSlider.setThumbImage(UIImage(named: "thumbNormal"), forState: UIControlState.Normal)
        channelSlider.setThumbImage(UIImage(named: "thumbActive"), forState: UIControlState.Highlighted)
        colorView.layer.cornerRadius = 10
        colorView.layer.borderWidth = 2
        fixtureCellView.layer.cornerRadius = 5
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//            }
    
    
    func configureCell(channel: Channel) {
        self.fixture = channel
        channelName.text = channel.name
        butLocked.hidden = !channel.independent
        channelSlider.value = fixture.indLevel
        channelLevel.text = "\(Int(fixture.indLevel * 100))%"
        
        if channel.style == "Intensity" {
            colorView.hidden = true
            colorButtonOverlayed.enabled = false
        }   else {
            colorView.hidden = false
            colorButtonOverlayed.enabled = true
            colorView.backgroundColor = channel.getDislayColor()
        }
       channelNum.text = channel.number
        
        //dynamic level
         channelSlider.addTarget(self, action: Selector("SliderAction:"), forControlEvents: .ValueChanged)
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
        channelLevel.text = "\(Int(sender.value * 100))%"
    }
    
    //IndButton Presses
    @IBAction func lockButPressed(sender: AnyObject) {
        
        self.fixture.independent = false
        butLocked.hidden = true
        tableVC?.checkIndOff()
    }
}
