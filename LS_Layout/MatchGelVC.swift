//
//  MatchGelVC.swift
//  colorPickerTest
//
//  Created by Gordon Pearlman on 2/28/16.
//  Copyright © 2016 Gordon Pearlman. All rights reserved.
//

import UIKit


class MatchGelVC: UIViewController,
            UITableViewDelegate,
            UITableViewDataSource,
            UISearchBarDelegate
{
    
    @IBOutlet weak var gelTableView: UITableView!
    
    @IBOutlet weak var gelSearchBar: UISearchBar!
    
    var filteredSections = [GelSection]()
    var gelSectons = [GelSection]()
    var arrayForBool : NSMutableArray = NSMutableArray()
    
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayForBool = ["0","0","0"]
        gelTableView.delegate = self
        gelTableView.dataSource = self
        gelSearchBar.delegate = self
        gelSearchBar.returnKeyType = UIReturnKeyType.Search
        
        self.hideKeyboardWhenTappedAround()
        
         parseGelsCSV()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        gelTableView.reloadData()
    }
    
    
    func parseGelsCSV() {
   
        var gelRGBs = [GelRGB]()
        
        let path = NSBundle.mainBundle().pathForResource("gels2rgb", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            var curMfg  = ""
            
            for row in rows {
                
                let mfg = row["mfg"]!
                if mfg != "" {
                    if curMfg == "" {
                        curMfg = mfg
                    } else {
                        
                        let gelSection = GelSection(mfg: curMfg, gels: gelRGBs)
                        gelSectons.append(gelSection)
                        gelRGBs = [GelRGB]()
                        curMfg = mfg
                    }
                }
                
                let number =  "\(curMfg.substringToIndex(curMfg.startIndex.advancedBy(1)))\(row["number"]!)"
                let name = row["name"]!
                let red = Float(row["red"]!)! / 255.0
                let green = Float(row["green"]!)! / 255.0
                let blue = Float(row["blue"]!)! / 255.0
                
                
                let gelRbg = GelRGB(number: number, name: name, red: red, green: green, blue: blue)
                gelRGBs.append(gelRbg)
            }
            let gelSection = GelSection(mfg: curMfg, gels: gelRGBs)
            gelSectons.append(gelSection)
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    
    //Table View
    //Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("gelCell", forIndexPath: indexPath) as? GelTableViewCell {
            
            let gel: GelRGB!
            
            let manyCells : Bool = arrayForBool .objectAtIndex(indexPath.section).boolValue
            
            if (!manyCells) {
                //  cell.textLabel.text = @"click to enlarge";
            }
            else{
            
            if inSearchMode {
                gel = filteredSections[indexPath.section].gelRGBs[indexPath.row]
            } else{
                gel = gelSectons[indexPath.section].gelRGBs[indexPath.row]
            }
        
            cell.confirgerCell(gel)
            }
            return cell
        }else {
            return GelTableViewCell()
        }
        
    }
    
    //Number of Sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return gelSectons.count
    }
    
    //Number of Rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(arrayForBool .objectAtIndex(section).boolValue == true)
        {
            if inSearchMode {
                return filteredSections[section].gelRGBs.count
            } else {
                return gelSectons[section].gelRGBs.count
            }
        }
        return 0
    }
    
    //Header
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 60))
        
        if section == 1 {
            headerView.backgroundColor = UIColor.redColor()
        } else {
            headerView.backgroundColor = UIColor.blueColor()
        }
        headerView.tag = section
        
        let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 40)) as UILabel
        headerString.textColor = UIColor.whiteColor()
        headerString.textAlignment = .Center
        headerString.text = "\(gelSectons[section].mfg) >"
        headerView .addSubview(headerString)
        
        
//                let  headerView = tableView.dequeueReusableCellWithIdentifier("gelHeaderCell") as! GelTableViewHeaderCell
//           headerView.configureCell(gelSectons[section])
        
        let headerTapped = UITapGestureRecognizer (target: self, action:#selector(MatchGelVC.sectionHeaderTapped(_:)))
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
    }

    //Header Tapped Action
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
//        print("Tapping working")
//        print(recognizer.view?.tag)
        
        let indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        if (indexPath.row == 0) {
            
            var collapsed = arrayForBool .objectAtIndex(indexPath.section).boolValue
            collapsed = !collapsed;
            
            arrayForBool .replaceObjectAtIndex(indexPath.section, withObject: collapsed)
            //reload specific section animated
            let range = NSMakeRange(indexPath.section, 1)
            let sectionToReload = NSIndexSet(indexesInRange: range)
            self.gelTableView .reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.Fade)
        }
    }
 
    
    //Search Bar
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            gelTableView.reloadData()
            
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredSections = []
            var filteredGels = [GelRGB]()
            
            for sec in gelSectons {
                
                filteredGels = []
                filteredGels = sec.gelRGBs.filter({$0.name?.lowercaseString.rangeOfString(lower) != nil || $0.number?.lowercaseString.rangeOfString(lower) != nil} )
                
                let filteredSection = GelSection(mfg: sec.mfg, gels: filteredGels)
                filteredSections.append(filteredSection)
            }
            gelTableView.reloadData()
        }
    }

    
    //Seque
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let tableViewC = segue.destinationViewController as? ColorPickerVC {
            
            if  let gelCell = sender as? GelTableViewCell {
                
                      tableViewC.curColor = gelCell.curColor

            }
        }
    }
  
}
