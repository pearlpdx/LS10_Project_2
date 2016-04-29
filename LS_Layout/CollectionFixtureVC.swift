//
//  CollectionFixtureVC.swift
//  LS_Layout
//
//  Created by Home on 2/2/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import CoreData

class CollectionFixtureVC:      UIViewController,
                                UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout,
                                UIPickerViewDataSource,
                                UIPickerViewDelegate,
                                UISearchBarDelegate {
    
    @IBOutlet weak var fixtureCollection: UICollectionView!
    
    @IBOutlet weak var pickWheel: UIPickerView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var filteredFixtures = [Fixture]()
    
    var steps = [String]()
    var inSearchMode = false

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        fixtureCollection.delegate = self
        fixtureCollection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Search
        
        //Temp
        pickWheel.delegate = self
        pickWheel.dataSource = self
        
        for x in 0...100 {
            steps.append("\(x)")
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
     //   fetchAndSetResults()
        fixtureCollection.reloadData()
    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChanCell", forIndexPath: indexPath) as? CollectionFixtureCell   {
            
            let fixture: Fixture!
            
            if inSearchMode {
                fixture = filteredFixtures[indexPath.row]
            } else {
            fixture = fixtures[indexPath.row]
             }
            
            cell.configureCell(fixture)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredFixtures.count
        } else {
        return fixtures.count
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(75, 80)
    }
    
    //Segue to Color Picker
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let colorPickerVC = segue.destinationViewController as? ColorPickerVC {
            
            if let channelCollectionCell = sender as? CollectionFixtureCell{
                curFixture = channelCollectionCell.fixture
            }
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
            fixtureCollection.reloadData()
            
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredFixtures = fixtures.filter({$0.name?.rangeOfString(lower) != nil})
            fixtureCollection.reloadData()
        }
    }

    
    
    
    
    //Picker View (TemP)
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return steps.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return steps[row]
    }
    
 

}
