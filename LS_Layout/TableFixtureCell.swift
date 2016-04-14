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
    
    
    func configureCell(fixture: Fixture) {
        self.fixture = fixture
        
        //setup notification  (move to tableview -- reload data
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshTable(_:)), name: "refresh", object: nil)
        
        fixtureName.text = fixture.name
        fixtureNum.text = fixture.number
        butLocked.hidden = !fixture.independent
        
        if fixture.independent != true {
            fixtureSlider.setValue((fixture.getChanByName("I")?.finalLevel)!, animated: true)
            fixtureLevel.text = "\(Int((fixture.getChanByName("I")?.finalLevel)! * 100))%"
        }
        
        if fixture.style == "Intensity" {
            colorView.hidden = true
            colorButtonOverlayed.enabled = false
        }   else {
            colorView.hidden = false
            colorButtonOverlayed.enabled = true
            colorView.backgroundColor = fixture.getDislayColor()
        }
        
        // Todo: disable cell when editting
//        if tableVC?.editing == true {
//            fixtureSlider.enabled = false
//            colorButtonOverlayed.enabled = false
//        } else {
//            fixtureSlider.enabled = true
//            colorButtonOverlayed.enabled = true
//        }
        
        
    }
    
//    //called by notification from update timer
//    func refreshTable(notification: NSNotification) {
//        if self.fixture.independent != true {
//            fixtureSlider.setValue(fixture.finalLevel, animated: true)
//            fixtureLevel.text = "\(Int(fixture.finalLevel * 100))%"
//            if colorView.hidden == false {
//                colorView.backgroundColor = self.fixture.getDislayColor()
//            }
//        }
//    }
   
    
    @IBAction func colorButOverlayPressed(sender: AnyObject) {
        self.fixture.independent = true
        butLocked.hidden = false
        tableVC?.indOffButton.hidden = false
    }
  
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        self.fixture.independent = true
        butLocked.hidden = false

        fixture.getChanByName("I")?.indLevel = sender.value
        tableVC?.indOffButton.hidden = false
        
        //temp
        //fixtureLevel.text = "\(Int(sender.value * 100))%"
    }
    
    //IndButton Presses
    @IBAction func lockButPressed(sender: AnyObject) {
        
        self.fixture.independent = false
        butLocked.hidden = true
        tableVC?.checkIndOff()
    }
}
