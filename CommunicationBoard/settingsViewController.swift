//
//  settingsViewController.swift
//  CommunicationBoard
//
//  Created by Adam Delora on 1/12/22.
//

import UIKit

class settingsViewController: UIViewController {
    var settingsVals: Settings!
    
    @IBOutlet weak var lookLeftRightSliderOutlet: UISlider!
    @IBOutlet weak var lookLeftRightDelaySliderOutlet: UISlider!
    @IBOutlet weak var lookUpSliderOutlet: UISlider!
    @IBOutlet weak var blinkSensitivityOutlet: UISlider!
    @IBOutlet weak var blinkDelayOutlet: UISlider!
    @IBOutlet weak var soundButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lookLeftRightSliderOutlet.setValue(Float(settingsVals.leftRightCutoff), animated: false)
        lookLeftRightSliderLabel.text = String(format: "%.1f", settingsVals.leftRightCutoff)
        
        lookLeftRightDelaySliderOutlet.setValue(Float(settingsVals.leftRightLookDelay), animated: false)
        lookLeftRightDelaySliderLabel.text = String(format: "%.1f", settingsVals.leftRightLookDelay)
        
        lookUpSliderOutlet.setValue(Float(settingsVals.lookupCuttoff), animated: false)
        lookUpSliderLabel.text = String(format: "%.1f", settingsVals.lookupCuttoff)
        
        blinkSensitivityOutlet.setValue(Float(settingsVals.blinkCutoff), animated: false)
        blinkSliderLabel.text = String(format: "%.1f", settingsVals.blinkCutoff)
        
        blinkDelayOutlet.setValue(Float(settingsVals.blinkDelay), animated: false)
        blinkDelaySliderLabel.text = String(format: "%.1f", settingsVals.blinkDelay)
        
        if settingsVals.soundOn{
            soundButtonOutlet.setTitle("Sound On", for: .normal)
        }else{
            soundButtonOutlet.setTitle("Sound Off", for: .normal)
        }
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
    
    @IBAction func soundButton(_ sender: UIButton) {
        if settingsVals.soundOn{
            settingsVals.soundOn = false
            sender.setTitle("Sound Off", for: .normal)
        }else{
            settingsVals.soundOn = true
            sender.setTitle("Sound On", for: .normal)
        }
    }
    
}
