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
    

    @IBOutlet weak var channelNum: UILabel!
    @IBOutlet weak var channelSlider: UISlider!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var imgButton: UIButton!
    @IBOutlet weak var channelLevel: UILabel!
    
    @IBOutlet weak var butLocked: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //format slider
//        channelSlider.setMaximumTrackImage(UIImage(named: "sliderBackMax"), forState: UIControlState.Normal)
//       channelSlider.setMinimumTrackImage(UIImage(named: "sliderBackMin"), forState: UIControlState.Normal)
        channelSlider.setThumbImage(UIImage(named: "thumb_normal"), forState: UIControlState.Normal)
        channelSlider.setThumbImage(UIImage(named: "thumb_active"), forState: UIControlState.Highlighted)
 
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            }
    
    
    func configureCell(channel: Channel) {
        self.fixture = channel
        channelName.text = channel.name
        butLocked.hidden = !channel.independent
        imgButton.backgroundColor = channel.getDislayColor()
       //channelNum.text = "\(channel.number)"
 
    }
    
    
    
    
    @IBAction func imgButtonPressed(sender: AnyObject) {
        //open color dialog
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        self.fixture.independent = true
        butLocked.hidden = false
        
        //temp
        channelLevel.text = "\(Int(sender.value * 100))%"
    }
    
    @IBAction func lockButPressed(sender: AnyObject) {
        
        self.fixture.independent = false
        butLocked.hidden = true
    }
    
    
    
}
