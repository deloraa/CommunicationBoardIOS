//
//  settingsViewController.swift
//  CommunicationBoard
//
//  Created by Adam Delora on 1/12/22.
//

import UIKit
import AVFoundation

class settingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    var pickerData:[String] = [String]()
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        settingsVals.voiceperson = languageToTuple[pickerData[row]]?.Name ?? "Martha"
        settingsVals.voicelanguage = languageToTuple[pickerData[row]]?.Language ?? "en-GB"

    }
    
    var settingsVals: Settings!
    
    @IBOutlet weak var pickerViewOutlet: UIPickerView!
    @IBOutlet weak var lookLeftRightSliderOutlet: UISlider!
    @IBOutlet weak var lookLeftRightDelaySliderOutlet: UISlider!
    @IBOutlet weak var lookUpSliderOutlet: UISlider!
    @IBOutlet weak var blinkSensitivityOutlet: UISlider!
    @IBOutlet weak var blinkDelayOutlet: UISlider!
    @IBOutlet weak var soundButtonOutlet: UIButton!

    
    var languageToTuple : [String:(Language:String,Name:String)] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerViewOutlet.delegate = self
        self.pickerViewOutlet.dataSource = self
        var indexOfCurrentLanguage = 0
        var currentIndex = 0

        for voice in AVSpeechSynthesisVoice.speechVoices() {
            let index = voice.language.index(voice.language.startIndex, offsetBy: 2)
            if voice.language[..<index] == "en"{
                let languageNameStr = voice.language + ":" + voice.name
                pickerData.append(languageNameStr)
                languageToTuple[languageNameStr] = (Language:voice.language,Name:voice.name)
                
                if voice.language == settingsVals.voicelanguage && voice.name == settingsVals.voiceperson{
                    currentIndex = indexOfCurrentLanguage
                }else{
                    indexOfCurrentLanguage = indexOfCurrentLanguage + 1
                }
            }
        }
        self.pickerViewOutlet.selectRow(currentIndex, inComponent: 0, animated: true)
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
    
    @IBAction func resetImagesButton(_ sender: UIButton) {
        
        if settingsVals.resetImages{
            settingsVals.resetImages = false
            sender.setTitle("Do Not Reset Images", for: .normal)
            sender.setTitleColor(.systemBlue, for: .normal)
        }else{
            settingsVals.resetImages = true
            sender.setTitle("Reset Images", for: .normal)
            //sender.titleLabel?.textColor=UIColor.red
            sender.setTitleColor(.systemRed, for: .normal)
        }
    }
}
