//
//  SettingsViewController.swift
//  tipster
//
//  Created by Michael Lewis on 1/17/15.
//  Copyright (c) 2015 Machel. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let tipPercentageArray = [0.18, 0.20, 0.22]

    @IBOutlet weak var tipControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Load the current user default and set the index of the control
        tipControl.selectedSegmentIndex = getTipIndex(loadDefaultTipValue())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // When the control changes, save the default
    @IBAction func onDefaultTipChange(sender: AnyObject) {
        let tipPercentage = tipPercentageArray[tipControl.selectedSegmentIndex]
        saveDefaultTipValue(tipPercentage)
    }


    private

    // Load the user's saved default tip value
    func loadDefaultTipValue() -> Double {
        var defaults = NSUserDefaults.standardUserDefaults()
        return defaults.doubleForKey("tip_percentage")
    }

    // Get the control index for a given tip value
    // If the tip value is not found, default to 1, the default tip value
    func getTipIndex(tipValue: Double) -> Int {
        var tipIndex = find(tipPercentageArray, tipValue)
        // In case we have a non-standard tip, use the default value's index
        if (tipIndex == nil) {
            tipIndex = 1
        }
        return tipIndex!
    }

    // Save a given tip value to the user's defaults
    func saveDefaultTipValue(tipValue: Double) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(tipValue, forKey: "tip_percentage")
        defaults.synchronize()
    }

}

