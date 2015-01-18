//
//  MainViewController.swift
//  tipster
//
//  Created by Michael Lewis on 1/17/15.
//  Copyright (c) 2015 Machel. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let tipPercentageArray = [0.18, 0.20, 0.22]

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Appropriate default values
        tipLabel.text = formattedAmount(0.0)
        totalLabel.text = formattedAmount(0.0)

    }

    // Make sure that we reload the defaults when the modal closes
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        reloadTipControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentage = tipPercentageArray[tipControl.selectedSegmentIndex]

        // Extract the user-entered bill amount
        var billAmount = (billField.text as NSString).doubleValue

        // Calculate the tip and total amounts
        var tipAmount = billAmount * tipPercentage
        var totalAmount = billAmount + tipAmount

        // Update the UI elements for tip and total amounts
        tipLabel.text = formattedAmount(tipAmount)
        totalLabel.text = formattedAmount(totalAmount)
    }

    // Tapping outside of the keyboard will hide it.
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    
    private

    // Build a properly formatted string for a given amount,
    // in local currency and formatting.
    func formattedAmount(amount: Double) -> String? {
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle

        return formatter.stringFromNumber(amount)
    }

    // Load the current user default and set the index of the control
    func reloadTipControl() {
        tipControl.selectedSegmentIndex = getTipIndex(loadDefaultTipValue())
    }

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
}
