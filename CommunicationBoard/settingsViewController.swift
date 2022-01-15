//
//  settingsViewController.swift
//  CommunicationBoard
//
//  Created by Adam Delora on 1/12/22.
//

import UIKit

class settingsViewController: UIViewController {
    var settingsVals: Settings!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var lookLeftRightSliderLabel: UILabel!
    @IBAction func lookLeftRightSlider(_ sender: UISlider) {
        let currentValue: String = String(format: "%.1f", sender.value)
        
        lookLeftRightSliderLabel.text = currentValue
        settingsVals.leftRightCutoff = Double(sender.value)
    }
    
    
    @IBOutlet weak var lookLeftRightDelaySliderLabel: UILabel!
    @IBAction func lookLeftRightDelaySlider(_ sender: UISlider) {
        let currentValue: String = String(format: "%.1f", sender.value)
        
        lookLeftRightDelaySliderLabel.text = currentValue
        settingsVals.leftRightLookDelay = Double(sender.value)
        settingsVals.timeactivateleftright = Double(sender.value)*3/10
    }
    
    @IBOutlet weak var lookUpSliderLabel: UILabel!
    @IBAction func lookUpSlider(_ sender: UISlider) {
        let currentValue: String = String(format: "%.1f", sender.value)
        
        lookUpSliderLabel.text = currentValue
        settingsVals.lookupCuttoff = Double(sender.value)
    }
    
    
    @IBOutlet weak var blinkSliderLabel: UILabel!
    @IBAction func blinkSlider(_ sender: UISlider) {
        let currentValue: String = String(format: "%.1f", sender.value)
        
        blinkSliderLabel.text = currentValue
        settingsVals.blinkCutoff = Double(sender.value)
    }
    
    @IBOutlet weak var blinkDelaySliderLabel: UILabel!
    @IBAction func blinkDelaySlider(_ sender: UISlider) {
        let currentValue: String = String(format: "%.1f", sender.value)
        
        blinkDelaySliderLabel.text = currentValue
        settingsVals.blinkDelay = Double(sender.value)
        settingsVals.timeactivateblink = Double(sender.value)*3/10
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.performSegue(withIdentifier: "unwindToSettings", sender: self)
    }
    
}
