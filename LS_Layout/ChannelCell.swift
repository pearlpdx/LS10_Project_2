//
//  ChannelCell.swift
//  LS_2016
//
//  Created by Home on 1/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    var channel: Channel!
    

    @IBOutlet weak var channelNum: UILabel!
    @IBOutlet weak var channelSlider: UISlider!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var imgButton: UIButton!
    @IBOutlet weak var channelLevel: UILabel!
    
    @IBOutlet weak var butLocked: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // format color button
        imgButton.layer.cornerRadius = 9.0
        imgButton.clipsToBounds = true
        
        //format slider
        channelSlider.setThumbImage(UIImage(named: "thumb_normal"), forState: UIControlState.Normal)
        channelSlider.setThumbImage(UIImage(named: "thumb_active"), forState: UIControlState.Highlighted)
 
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            }
    
    
    func configureCell(channel: Channel) {
        self.channel = channel
        channelName.text = channel.name
        butLocked.hidden = !channel.independent
 
    }
    
    
    
    
    @IBAction func imgButtonPressed(sender: AnyObject) {
        //open color dialog
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        self.channel.independent = true
        butLocked.hidden = false
        
        //temp
        channelLevel.text = "\(Int(sender.value * 100))%"
    }
    
    @IBAction func lockButPressed(sender: AnyObject) {
        
        self.channel.independent = false
        butLocked.hidden = true
    }
    
    
    
}
