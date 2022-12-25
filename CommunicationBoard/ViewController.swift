//
//  ViewController.swift
//  CommunicationBoard
//
//  Created by Adam Delora on 1/8/22.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation
import CoreBluetooth
import CoreData

extension Array {
    func split() -> (left: [Element], right: [Element]) {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return (left: Array(leftSplit), right: Array(rightSplit))
    }
}


class ViewController: UIViewController, ARSCNViewDelegate, CBCentralManagerDelegate, CBPeripheralDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let DEVICE_NAME = "ESP32_Bluetooth";
    let SEND_SERVICE = CBUUID(string:"6e400001-b5a3-f393-e0a9-e50e24dcca9e");
    let SEND_SERVICE_CHARACTERISTIC = CBUUID(string:"6e400002-b5a3-f393-e0a9-e50e24dcca9e");
    var centralManager: CBCentralManager!
    var esp32Peripheral: CBPeripheral!
    var esp32Characteristic: CBCharacteristic!
    var bluetoothConencted = false;
    var bluetoothFirstInitialized = true;
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
          case .unknown:
            print("central.state is .unknown")
          case .resetting:
            print("central.state is .resetting")
          case .unsupported:
            print("central.state is .unsupported")
          case .unauthorized:
            print("central.state is .unauthorized")
          case .poweredOff:
            print("central.state is .poweredOff")
          case .poweredOn:
            print("central.state is .poweredOn")
            centralManager.scanForPeripherals(withServices: nil)
        @unknown default:
            print("bluetooth unknown case")
        }
        
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral.services ?? "")
        print(peripheral.name ?? "")
        if peripheral.name ?? "" == "ESP32_Bluetooth" {
            esp32Peripheral = peripheral;
            esp32Peripheral.delegate = self
            centralManager.stopScan()
            centralManager.connect(esp32Peripheral)
            
        }

    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        bluetoothConencted = true
        bluetoothButtonOutlet.tintColor = UIColor.systemBlue
        esp32Peripheral.discoverServices([SEND_SERVICE])
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        bluetoothConencted = false
        bluetoothButtonOutlet.tintColor = UIColor.black
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        bluetoothConencted = false
        bluetoothButtonOutlet.tintColor = UIColor.black
        let alert = UIAlertController(title: "Alert", message: "Failed to connect to bluetooth device", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
          print(service)
          peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
      guard let characteristics = service.characteristics else { return }

      for characteristic in characteristics {

          if characteristic.uuid == SEND_SERVICE_CHARACTERISTIC{
              print(characteristic)
              esp32Characteristic = characteristic
              let alert = UIAlertController(title: "Success", message: "You have successfully connected to bluetooth", preferredStyle: UIAlertController.Style.alert)
              alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
              //peripheral.writeValue(Data([UInt8(12)]), for: characteristic, type: .withResponse)
          }

      }
    }
    
    
    @IBOutlet weak var bluetoothButtonOutlet: UIButton!
    @IBAction func bluetoothButton(_ sender: Any) {
        if !bluetoothConencted{
            if bluetoothFirstInitialized{
                bluetoothFirstInitialized = false
                centralManager = CBCentralManager(delegate: self, queue: nil)
            }else{
                centralManagerDidUpdateState(centralManager)
            }
            
        }else{
            centralManager.cancelPeripheralConnection(esp32Peripheral)

        }
    }
    
    @IBOutlet weak var RightIconsView: UIView!
    @IBOutlet weak var LeftIconsView: UIView!
    @IBOutlet weak var TopStack: UIStackView!
    @IBOutlet weak var LeftArrowBackground: UIView!
    @IBOutlet weak var RightArrowBackground: UIView!
    
    @IBOutlet weak var backgroundModal: UIView!
    @IBOutlet weak var modalImage: UIImageView!
    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var Icon1: UIImageView!
    @IBOutlet weak var Icon2: UIImageView!
    @IBOutlet weak var Icon3: UIImageView!
    @IBOutlet weak var Icon4: UIImageView!
    @IBOutlet weak var Icon5: UIImageView!
    @IBOutlet weak var Icon6: UIImageView!
    @IBOutlet weak var Icon7: UIImageView!
    @IBOutlet weak var Icon8: UIImageView!
    @IBOutlet weak var Icon9: UIImageView!
    @IBOutlet weak var Icon10: UIImageView!
    @IBOutlet weak var Icon11: UIImageView!
    @IBOutlet weak var Icon12: UIImageView!
    @IBOutlet weak var Icon13: UIImageView!
    @IBOutlet weak var Icon14: UIImageView!
    @IBOutlet weak var Icon15: UIImageView!
    @IBOutlet weak var Icon16: UIImageView!
    @IBOutlet weak var Icon17: UIImageView!
    @IBOutlet weak var Icon18: UIImageView!
    @IBOutlet weak var Icon19: UIImageView!
    @IBOutlet weak var Icon20: UIImageView!
    @IBOutlet weak var Icon21: UIImageView!
    @IBOutlet weak var Icon22: UIImageView!
    @IBOutlet weak var Icon23: UIImageView!
    @IBOutlet weak var Icon24: UIImageView!
    @IBOutlet weak var Icon25: UIImageView!
    @IBOutlet weak var Icon26: UIImageView!
    @IBOutlet weak var Icon27: UIImageView!
    @IBOutlet weak var Icon28: UIImageView!
    @IBOutlet weak var Icon29: UIImageView!
    @IBOutlet weak var Icon30: UIImageView!
    @IBOutlet weak var Icon31: UIImageView!
    @IBOutlet weak var Icon32: UIImageView!
  
    @IBOutlet weak var circularProgress: CircularProgressView!
    @IBOutlet weak var circularProgressImageView: UIImageView!
    
    
    var settingsOpen = false;
    @IBAction func unwindToHowTo(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        settingsOpen = false
    }

    @IBAction func unwindToSettings(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        settingsOpen = false
        guard let settingsVC = unwindSegue.source as? settingsViewController else {return}
        self.settingsVals = settingsVC.settingsVals
        
        for i in 0 ..< leftImages.count {
            if settingsVals.soundOn && leftImages[i].name == "32-SoundOff"{
                leftImages[i].imageView.image = UIImage(named: "32-SoundOn")
                leftImages[i].name = "32-SoundOn"
            } else if !settingsVals.soundOn && leftImages[i].name == "32-SoundOn"{
                leftImages[i].imageView.image = UIImage(named: "32-SoundOff")
                leftImages[i].name = "32-SoundOff"
            }
        }
        
        for i in 0 ..< rightImages.count {
            if settingsVals.soundOn && rightImages[i].name == "32-SoundOff"{
                rightImages[i].imageView.image = UIImage(named: "32-SoundOn")
                rightImages[i].name = "32-SoundOn"
            } else if !settingsVals.soundOn && rightImages[i].name == "32-SoundOn"{
                rightImages[i].imageView.image = UIImage(named: "32-SoundOff")
                rightImages[i].name = "32-SoundOff"
            }
        }
        
        if settingsVals.soundOn && iconImages[31].name == "32-SoundOff"{
            iconImages[31].image = UIImage(named: "32-SoundOn")
            iconImages[31].name = "32-SoundOn"
        } else if !settingsVals.soundOn && iconImages[31].name == "32-SoundOn"{
            iconImages[31].image = UIImage(named: "32-SoundOff")
            iconImages[31].name = "32-SoundOff"
        }
        
        
        if settingsVals.resetImages == true{
            for i in 0 ..< iconImages.count{
                iconImages[i].image = UIImage(named: iconImages[i].name)
            }
            settingsVals.resetImages = false;
            resetImages()
            isInitialScreen = true
            
            let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "ImageEntity"))
            do {
                try context?.execute(DelAllReqVar)
            }
            catch {
                print(error)
            }
        }
    }
    
    @IBAction func unwindToAbout(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        settingsOpen = false
    }
    
    var iconImageViews = [(String,UIImageView)]()
    var imageToSoundString = ["1-Afraid":"I am afraid","2-Pain":"I am in pain", "3-Yes":"Yes", "4-No":"No","5-Sad":"I am sad","6-Tired":"I am tired","7-Nurse":"I would like a nurse","8-Doctor":"I would like a doctor", "9-Sick":"I am sick","10-Frustrated":"I am frustrated","11-ShortofBreath":"I am short of breath","12-Choking":"I am choking","13-Angry":"I am angry","14-Dizzy":"I am dizzy","15-Hot":"I am hot","16-Cold":"I am cold","17-HowamI":"How am I doing","18-WhatsHappening":"What is happening","19-WhatTime":"What time is it","20-ComeBack":"Come back later","21-BedUp":"I would like to situp","22-BedDown":"I would like to lie down","23-Home":"I would like to go home","24-TV_Video":"Turn tv on or off","25-Light":"Turn light on or off","26-Alarm":"Activate call light","27-Water":"I want water","28-Glasses":"I need glasses","29-Suction":"I would like to be suctioned", "30-LipsMoistened":"I would like my lips moistenend","31-Sleep":"I want to sleep","32-SoundOn":"Turn sound on"]

    var iconImages = [(name: "1-Afraid", image:UIImage(named: "1-Afraid")),(name: "2-Pain", image:UIImage(named: "2-Pain")),(name: "3-Yes", image:UIImage(named: "3-Yes")),(name: "4-No", image:UIImage(named: "4-No")),(name: "5-Sad", image:UIImage(named: "5-Sad")),(name: "6-Tired", image:UIImage(named: "6-Tired")),(name: "7-Nurse", image:UIImage(named: "7-Nurse")),(name: "8-Doctor", image:UIImage(named: "8-Doctor")),(name: "9-Sick", image:UIImage(named: "9-Sick")),(name: "10-Frustrated", image:UIImage(named: "10-Frustrated")),(name: "11-ShortofBreath", image:UIImage(named: "11-ShortofBreath")),(name: "12-Choking", image:UIImage(named: "12-Choking")),(name: "13-Angry", image:UIImage(named: "13-Angry")),(name: "14-Dizzy", image:UIImage(named: "14-Dizzy")),(name: "15-Hot", image:UIImage(named: "15-Hot")),(name: "16-Cold", image:UIImage(named: "16-Cold")),(name: "17-HowamI", image:UIImage(named: "17-HowamI")),(name: "18-WhatsHappening", image:UIImage(named: "18-WhatsHappening")),(name: "19-WhatTime", image:UIImage(named: "19-WhatTime")),(name: "20-ComeBack", image:UIImage(named: "20-ComeBack")),(name: "21-BedUp", image:UIImage(named: "21-BedUp")),(name: "22-BedDown", image:UIImage(named: "22-BedDown")),(name: "23-Home", image:UIImage(named: "23-Home")),(name: "24-TV_Video", image:UIImage(named: "24-TV_Video")),(name: "25-Light", image:UIImage(named: "25-Light")),(name: "26-Alarm", image:UIImage(named: "26-Alarm")),(name: "27-Water", image:UIImage(named: "27-Water")),(name: "28-Glasses", image:UIImage(named: "28-Glasses")),(name: "29-Suction", image:UIImage(named: "29-Suction")),(name: "30-LipsMoistened", image:UIImage(named: "30-LipsMoistened")),(name: "31-Sleep", image:UIImage(named: "31-Sleep")),(name: "32-SoundOff", image:UIImage(named: "32-SoundOff"))]
    
    var leftImagesGlobal = [(name:String,imageView:UIImageView)]();
    var rightImagesGlobal = [(name:String,imageView:UIImageView)]();
    var leftImages = [(name:String,imageView:UIImageView)]();
    var rightImages = [(name:String,imageView:UIImageView)]();
    var topText = "Running: Look up to pause or blink one eye to reset."

    var settingsVals = Settings();

    var lookupRun = true;
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        settingsOpen = true
        if segue.identifier == "settingsSegue"{
            let settingsVC = segue.destination as! settingsViewController
            settingsVC.settingsVals = self.settingsVals

        }

    }

    func resetImages(){
        self.isInitialScreen = true;
        for i in 0 ..< leftImagesGlobal.count {
            leftImagesGlobal[i].imageView.image = iconImages[i].image;
            leftImagesGlobal[i].name = iconImages[i].name;
        }
        for i in 0 ..< rightImagesGlobal.count {
            rightImagesGlobal[i].imageView.image = iconImages[i+leftImagesGlobal.count].image;
            rightImagesGlobal[i].name = iconImages[i+leftImagesGlobal.count].name;
        }
        leftImages = leftImagesGlobal;
        rightImages = rightImagesGlobal;

    }
    static func getConvertedPoint(_ targetView: UIView, baseView: UIView)->CGPoint{
        var pnt = targetView.frame.origin
        if nil == targetView.superview{
            return pnt
        }
        var superView = targetView.superview
        while superView != baseView{
            pnt = superView!.convert(pnt, to: superView!.superview)
            if nil == superView!.superview{
                break
            }else{
                superView = superView!.superview
            }
        }
        return superView!.convert(pnt, to: baseView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    

        if (!ARConfiguration.isSupported) {

            let alert = UIAlertController(title: "Alert", message: "ARKit not supported on this device", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext?
    override func viewDidLoad() {
        super.viewDidLoad()
        

        sceneView.delegate = self

        iconImageViews =
        [(name: "1-Afraid", imageView: Icon1),(name: "2-Pain", imageView:Icon2),(name: "3-Yes", imageView:Icon3),(name: "4-No", imageView:Icon4),(name: "5-Sad", imageView:Icon5),(name: "6-Tired", imageView:Icon6),(name: "7-Nurse", imageView:Icon7),(name: "8-Doctor", imageView:Icon8),(name: "9-Sick", imageView:Icon9),(name: "10-Frustrated", imageView:Icon10),(name: "11-ShortofBreath", imageView:Icon11),(name: "12-Choking", imageView:Icon12),(name: "13-Angry", imageView:Icon13),(name: "14-Dizzy", imageView:Icon14),(name: "15-Hot", imageView:Icon15),(name: "16-Cold", imageView:Icon16),(name: "17-HowamI", imageView:Icon17),(name: "18-WhatsHappening", imageView:Icon18),(name: "19-WhatTime", imageView:Icon19),(name: "20-ComeBack", imageView:Icon20),(name: "21-BedUp", imageView:Icon21),(name: "22-BedDown", imageView:Icon22),(name: "23-Home", imageView:Icon23),(name: "24-TV_Video", imageView:Icon24),(name: "25-Light", imageView:Icon25),(name: "26-Alarm", imageView:Icon26),(name: "27-Water", imageView:Icon27),(name: "28-Glasses", imageView:Icon28),(name: "29-Suction", imageView:Icon29),(name: "30-LipsMoistened", imageView:Icon30),(name: "31-Sleep", imageView:Icon31),(name: "32-SoundOff", imageView:Icon32)]

        
        let tempIconImagesGlobal = iconImageViews.split();
        leftImagesGlobal = tempIconImagesGlobal.left;
        rightImagesGlobal = tempIconImagesGlobal.right;
        leftImages = leftImagesGlobal;
        rightImages = rightImagesGlobal;
        
        for i in 0 ..< iconImageViews.count{
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapView(_:)))
            iconImageViews[i].1.addGestureRecognizer(tap)
            iconImageViews[i].1.accessibilityIdentifier = iconImageViews[i].0
        }
        
        context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageEntity")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let results = try context?.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                print(result)
                let imageName = result.value(forKey:"imageName") as? String
                for i in 0..<iconImages.count{
                    if iconImages[i].name == imageName ?? ""{
                        if let imageData = result.value(forKey:"imageData") as? Data {
                            iconImages[i].image = UIImage(data: imageData)

                        }else{
                            print("err image was not updated")
                        }
                    }
                }
          }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        resetImages()
    }
    var imagetochange:UIImageView = UIImageView();
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
       
        if(isInitialScreen == true){
            imagetochange = sender.view as! UIImageView
            //imageviewTapped.image = UIImage(named: "2-Pain")
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let checkstring = imagetochange.accessibilityIdentifier
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagetochange.image = pickedImage
            for i in 0..<iconImages.count{
                if iconImages[i].name == checkstring ?? ""{
                    iconImages[i].image = pickedImage
                    let data = NSEntityDescription.insertNewObject(forEntityName: "ImageEntity", into: context!)
                    data.setValue(pickedImage.pngData(), forKey: "imageData")
                    data.setValue(iconImages[i].name, forKey: "imageName")
                    do {
                    try context?.save()
                        print("Data Saved")
                    } catch {
                        print("No error")
                    }
                }
            }
        }

        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARFaceTrackingConfiguration()
        // Create a session configuration
        
        sceneView.session.run(configuration)
        // Run the view's session
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func readSound(readme:String){
        //try to use arthur and martha they sound best
        print(settingsVals.voicelanguage)
        print(settingsVals.voiceperson)
        var voiceToUse = AVSpeechSynthesisVoice(language:settingsVals.voicelanguage)
        for voice in AVSpeechSynthesisVoice.speechVoices() {
                if voice.name == settingsVals.voiceperson {
                    voiceToUse = voice
                }
        }
        let utterance = AVSpeechUtterance(string: readme)
        utterance.voice = voiceToUse

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        /*
         You can implement this method to provide a new SCNNode object (or instance of an SCNNode subclass)
         containing any attachments you plan to use as a visual representation of the anchor. Note that ARKit
         controls the node's visibility and its transform property, so you may find it useful to add child nodes or adjust
         the node's pivot property to maintain any changes to position or orientation that you make.
         */
        
        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!)
        /*
         ARSCNFaceGeometry is a subclass of SCNGeometry that wraps the mesh data provided by the
         ARFaceGeometry class. You can use ARSCNFaceGeometry to quickly and easily visualize face topology and
         facial expressions provided by ARKit in a SceneKit view.
         */
        
        let node = SCNNode(geometry: faceMesh)
        // SCNNode is a structural element of a scene graph, representing a position and transform in a 3D coordinate space.
        
        node.geometry?.firstMaterial?.fillMode = .lines
        // make it lines
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        /*
         Tells the delegate that a SceneKit node's properties have been updated to match the current state of its corresponding anchor.
         renderer : The ARSCNView object rendering the scene
         node : The updated SceneKit node
         anchor : The AR anchor corresponding to the node
         */
        
        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
            faceGeometry.update(from: faceAnchor.geometry)
            // everytime the mesh detects an update
            
            
            // run readMyFace function
            
            DispatchQueue.main.async {
                self.readMyFace(anchor: faceAnchor)
                self.topLabel.text = self.topText }
            // Update the text on the main thread
        }
    }
    var lookDirection = "";
    var startLookTime = Double.greatestFiniteMagnitude;
    var blinklookupStartTime = Double.greatestFiniteMagnitude;
    var blinklookupVal="";
    var isInitialScreen=true;
    func readMyFace(anchor: ARFaceAnchor) {
        if settingsOpen{
            return;
        }

        let currentTime = Date().timeIntervalSince1970;
        // function that takes an ARFaceAnchor in as a parameter
        //left look values
        let eyeLookInLeft = Double(truncating: anchor.blendShapes[.eyeLookInLeft] ?? 0.0 as NSNumber)
        let eyeLookOutRight = Double(truncating: anchor.blendShapes[.eyeLookOutRight] ?? 0.0 as NSNumber)
        
        //right look values
        let eyeLookOutLeft = Double(truncating: anchor.blendShapes[.eyeLookOutLeft] ?? 0.0 as NSNumber)
        let eyeLookInRight = Double(truncating: anchor.blendShapes[.eyeLookInRight] ?? 0.0 as NSNumber)
        
        let eyeBlinkRight = Double(truncating: anchor.blendShapes[.eyeBlinkRight] ?? 0.0 as NSNumber)
        let eyeBlinkLeft = Double(truncating: anchor.blendShapes[.eyeBlinkLeft] ?? 0.0 as NSNumber)
        
        
        let eyeLookUpLeft = Double(truncating: anchor.blendShapes[.eyeLookUpLeft] ?? 0.0 as NSNumber)
        let eyeLookUpRight = Double(truncating: anchor.blendShapes[.eyeLookUpRight] ?? 0.0 as NSNumber)
        // Define different anchors utilizing classes in the imported kit
        // was actually right eye blink
        //print("\(eyeBlinkLeft?.decimalValue ?? 0.0)")
        // when this function is running I want to signal to the user that the function is reacting
        if lookupRun{
            topText = "Running: Look up to pause or blink one eye to reset."
        }else{
            topText = "Paused: Look up to resume or blink one eye to reset."
        }
        if (((eyeBlinkLeft > settingsVals.blinkCutoff && eyeBlinkRight < settingsVals.blinkCutoff) || (eyeBlinkLeft < settingsVals.blinkCutoff && eyeBlinkRight > settingsVals.blinkCutoff)) && blinklookupVal != "RESET" && blinklookupVal != "BLINK") {
            blinklookupVal = "BLINK";
            blinklookupStartTime = currentTime;
        } else if eyeLookUpLeft > settingsVals.lookupCuttoff && eyeLookUpRight > settingsVals.lookupCuttoff && blinklookupVal != "LOOKUP" && blinklookupVal != "RESET"{
            blinklookupVal = "LOOKUP";
            blinklookupStartTime = currentTime;
        }else if (eyeBlinkLeft < settingsVals.blinkCutoff && eyeBlinkRight < settingsVals.blinkCutoff && eyeLookUpLeft < settingsVals.lookupCuttoff && eyeLookUpRight < settingsVals.lookupCuttoff) {
            blinklookupVal = "";
            blinklookupStartTime = Double.greatestFiniteMagnitude;
             //setProgressBarValue(0, 0, `pause`);
            circularProgress.isHidden = true
            if (!lookupRun) {
                 circularProgress.isHidden = false
                 circularProgress.setValue(value: 0.0)
                 circularProgressImageView.image = UIImage(systemName: "pause.fill")

             } else {
                 circularProgress.isHidden = true
                 circularProgress.setValue(value: 0.0)
                 circularProgressImageView.image = UIImage(systemName: "pause.fill")
 
             }
         }

        if (blinklookupStartTime + settingsVals.blinkDelay < currentTime) {
             if (blinklookupVal == "BLINK") {
                 circularProgress.isHidden = false
                 circularProgress.setValue(value: 1)
                 circularProgressImageView.image = UIImage(systemName: "arrow.uturn.backward")
                 //setProgressBarValue(1, 1, `loop`);
                 resetImages();
                 startLookTime = Double.greatestFiniteMagnitude;
                 lookDirection = "";
                 blinklookupStartTime = Double.greatestFiniteMagnitude;
                 blinklookupVal = "STOP";
                 
             }else if(blinklookupVal == "LOOKUP"){
                 if (lookupRun) {
                     //setProgressBarValue(1, 1, `pause`);
                     circularProgress.isHidden = false
                     circularProgress.setValue(value: 1)
                     circularProgressImageView.image = UIImage(systemName: "pause.fill")
                     lookupRun = false;
                 } else {
                     //setProgressBarValue(1, 1, `play_arrow`);
                     circularProgress.isHidden = false
                     circularProgress.setValue(value: 1)
                     circularProgressImageView.image = UIImage(systemName: "play.fill")
                     lookupRun = true;
                 }
                 blinklookupStartTime = Double.greatestFiniteMagnitude;
                 blinklookupVal = "STOP";
             }
             blinklookupVal = "RESET";
          }else {
              if (settingsVals.timeactivateblink < currentTime - blinklookupStartTime) {
                  let timestampdiff = (currentTime - blinklookupStartTime - settingsVals.timeactivateblink) / (settingsVals.blinkDelay - settingsVals.timeactivateblink);
                  if blinklookupVal == "BLINK"{
                      circularProgress.isHidden = false
                      circularProgress.setValue(value: timestampdiff)
                      circularProgressImageView.image = UIImage(systemName: "arrow.uturn.backward")
                  }else if blinklookupVal == "LOOKUP" {
                      if (lookupRun) {
                          circularProgress.isHidden = false
                          circularProgress.setValue(value: timestampdiff)
                          circularProgressImageView.image = UIImage(systemName: "pause.fill")
                      } else {
                          circularProgress.isHidden = false
                          circularProgress.setValue(value: timestampdiff)
                          circularProgressImageView.image = UIImage(systemName: "play.fill")
                      }
                  }
              }

         }

        if !lookupRun {return}
        
        if eyeLookOutRight > settingsVals.leftRightCutoff && eyeLookInLeft > settingsVals.leftRightCutoff && lookDirection != "LEFT" && lookDirection != "RESET"
        {
            startLookTime = currentTime;
            lookDirection = "LEFT";
            RightArrowBackground.alpha = 0
            //rightarrowelement.style.backgroundColor = backgroundColorChange(0);
            
        } else if eyeLookOutLeft > settingsVals.leftRightCutoff && eyeLookInRight > settingsVals.leftRightCutoff && lookDirection != "RIGHT" && lookDirection != "RESET"
        {
            startLookTime = currentTime;
            lookDirection = "RIGHT";
            LeftArrowBackground.alpha = 0
        } else if eyeLookOutRight <= settingsVals.leftRightCutoff && eyeLookInLeft <= settingsVals.leftRightCutoff && eyeLookOutLeft <= settingsVals.leftRightCutoff && eyeLookInRight <= settingsVals.leftRightCutoff{
            startLookTime = Double.greatestFiniteMagnitude;
            lookDirection = "";
            LeftArrowBackground.alpha = 0
            RightArrowBackground.alpha = 0
        }
        
        if startLookTime + settingsVals.leftRightLookDelay < currentTime {
            
            if lookDirection == "LEFT" {

                if self.leftImages.count == 1{
                    self.backgroundModal.alpha = 0.5
                    self.backgroundModal.layoutIfNeeded()
                    self.modalImage.isHidden = false
                    if (bluetoothConencted) {
                        if self.leftImages[0].name == "21-Situp" {
                            esp32Peripheral.writeValue(Data([UInt8(12)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.leftImages[0].name == "22-LieDown" {
                            esp32Peripheral.writeValue(Data([UInt8(13)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.leftImages[0].name == "24-TVVideo" {
                            esp32Peripheral.writeValue(Data([UInt8(14)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.leftImages[0].name == "25-Light" {
                            esp32Peripheral.writeValue(Data([UInt8(25)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.leftImages[0].name == "26-CallLight" {
                            esp32Peripheral.writeValue(Data([UInt8(26)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.leftImages[0].name == "7-Nurse" {
                            esp32Peripheral.writeValue(Data([UInt8(26)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.leftImages[0].name == "27-Water" {
                            esp32Peripheral.writeValue(Data([UInt8(27)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.leftImages[0].name == "29-Suction" {
                            esp32Peripheral.writeValue(Data([UInt8(32)]), for: esp32Characteristic, type: .withResponse)
                        }
                    }
                    
                    if self.leftImages[0].name == "32-SoundOff"{
                        self.settingsVals.soundOn = true
                        self.leftImages[0].imageView.image = UIImage(named: "32-SoundOn")
                        self.leftImages[0].name = "32-SoundOn"
                        self.iconImages[31].image = UIImage(named: "32-SoundOn")
                        self.iconImages[31].name = "32-SoundOn"
                    }else if self.leftImages[0].name == "32-SoundOn"{
                        self.settingsVals.soundOn = false
                        self.leftImages[0].imageView.image = UIImage(named: "32-SoundOff")
                        self.leftImages[0].name = "32-SoundOff"
                        self.iconImages[31].image = UIImage(named: "32-SoundOff")
                        self.iconImages[31].name = "32-SoundOff"
                    }
                    self.modalImage.image = self.leftImages[0].imageView.image
                    self.modalImage.layoutIfNeeded()
                    if settingsVals.soundOn{
                        readSound(readme:self.imageToSoundString[self.leftImages[0].name] ?? "")
                    }
                    resetImages()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.backgroundModal.alpha = 0
                        self.backgroundModal.layoutIfNeeded()
                        self.modalImage.isHidden = true
                        self.modalImage.image = UIImage();
                        self.modalImage.layoutIfNeeded()

                    }

                }else{
                    let imageSplitSize = self.leftImages.count/2;
                    let animationDuration = settingsVals.leftRightLookDelay/2
                    self.TopStack.bringSubviewToFront(self.LeftIconsView)
                    UIView.animate(withDuration: animationDuration, animations: {() -> Void in
                        for i in 0 ..< self.rightImages.count {
                            self.rightImages[i].imageView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                            
                        }
                        
                    }, completion: {(_ finished: Bool) -> Void in
                        
                        for i in 0 ..< self.rightImages.count {
                            self.rightImages[i].imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                            self.rightImages[i].imageView.image = UIImage();
                            
                        }
                        
                        UIView.animate(withDuration: animationDuration, animations: {() -> Void in
                            for i in 0 ..< imageSplitSize {
                                let rightImagePoint =  self.rightImages[i].imageView.convert(self.rightImages[i].imageView.bounds, to: self.TopStack)
                                let leftImagePoint = self.leftImages[i+imageSplitSize].imageView.convert(self.leftImages[i+imageSplitSize].imageView.bounds, to: self.TopStack)
                                self.leftImages[i+imageSplitSize].imageView.transform = CGAffineTransform(translationX: rightImagePoint.origin.x-leftImagePoint.origin.x, y: rightImagePoint.origin.y-leftImagePoint.origin.y)
                            }
                            
                            
                        }, completion: {(_ finished: Bool) -> Void in
                            for i in 0 ..< imageSplitSize {
                                self.rightImages[i].imageView.image = self.leftImages[i+imageSplitSize].imageView.image
                                self.rightImagesGlobal[i].name = self.leftImages[i+imageSplitSize].name;
                                self.leftImages[i+imageSplitSize].imageView.image = UIImage()
                                self.leftImages[i+imageSplitSize].imageView.transform = CGAffineTransform(translationX:0,y:0)
                            }
                            let initsize = self.leftImages.count/2;
                            self.rightImages = Array(self.rightImagesGlobal[0 ..< initsize])
                            self.leftImages = Array(self.leftImagesGlobal[0 ..< initsize])
                            self.isInitialScreen = false;
                        })
                    })
                    
                    startLookTime = Double.greatestFiniteMagnitude;
                }
            }else if lookDirection == "RIGHT" {
                
                if self.rightImages.count == 1{
                    self.backgroundModal.alpha = 0.5
                    self.backgroundModal.layoutIfNeeded()
                    self.modalImage.isHidden = false
                    if (bluetoothConencted) {
                        if self.rightImages[0].name == "21-Situp" {
                            esp32Peripheral.writeValue(Data([UInt8(12)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.rightImages[0].name == "22-LieDown" {
                            esp32Peripheral.writeValue(Data([UInt8(13)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.rightImages[0].name == "24-TVVideo" {
                            esp32Peripheral.writeValue(Data([UInt8(14)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.rightImages[0].name == "25-Light" {
                            esp32Peripheral.writeValue(Data([UInt8(25)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.rightImages[0].name == "26-CallLight" {
                            esp32Peripheral.writeValue(Data([UInt8(26)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.rightImages[0].name == "7-Nurse" {
                            esp32Peripheral.writeValue(Data([UInt8(26)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.rightImages[0].name == "27-Water" {
                            esp32Peripheral.writeValue(Data([UInt8(27)]), for: esp32Characteristic, type: .withResponse)
                        } else if self.rightImages[0].name == "29-Suction" {
                            esp32Peripheral.writeValue(Data([UInt8(32)]), for: esp32Characteristic, type: .withResponse)
                        }
                    }
                    if self.rightImages[0].name == "32-SoundOff"{
                        self.settingsVals.soundOn = true
                        self.rightImages[0].imageView.image = UIImage(named: "32-SoundOn")
                        self.rightImages[0].name = "32-SoundOn"
                        self.iconImages[31].image = UIImage(named: "32-SoundOn")
                        self.iconImages[31].name = "32-SoundOn"
                    }else if self.rightImages[0].name == "32-SoundOn"{
                        self.settingsVals.soundOn = false
                        self.rightImages[0].imageView.image = UIImage(named: "32-SoundOff")
                        self.rightImages[0].name = "32-SoundOff"
                        self.iconImages[31].image = UIImage(named: "32-SoundOff")
                        self.iconImages[31].name = "32-SoundOff"
                    }
                    self.modalImage.image = self.rightImages[0].imageView.image
                    self.modalImage.layoutIfNeeded()
                    //if self.rightImages[0].name
                    if settingsVals.soundOn{
                        readSound(readme:self.imageToSoundString[self.rightImages[0].name] ?? "")
                    }
                    resetImages()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.backgroundModal.alpha = 0
                        self.backgroundModal.layoutIfNeeded()
                        self.modalImage.isHidden = true
                        self.modalImage.image = UIImage();
                        self.modalImage.layoutIfNeeded()
                        
                    }
                }else{
                    let imageSplitSize = self.rightImages.count/2;
                    let animationDuration = settingsVals.leftRightLookDelay/2
                    self.TopStack.bringSubviewToFront(self.RightIconsView)
                    UIView.animate(withDuration: animationDuration, animations: {() -> Void in
                        for i in 0 ..< self.leftImages.count {
                            self.leftImages[i].imageView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                            
                        }
                        
                    }, completion: {(_ finished: Bool) -> Void in
                        
                        for i in 0 ..< self.leftImages.count {
                            self.leftImages[i].imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                            self.leftImages[i].imageView.image = UIImage();
                            
                        }
                        
                        UIView.animate(withDuration: animationDuration, animations: {() -> Void in
                            for i in 0 ..< imageSplitSize {
                                let leftImagePoint =  self.leftImages[i].imageView.convert(self.leftImages[i].imageView.bounds, to: self.TopStack)
                                let rightImagePoint = self.rightImages[i+imageSplitSize].imageView.convert(self.rightImages[i+imageSplitSize].imageView.bounds, to: self.TopStack)
                                self.rightImages[i+imageSplitSize].imageView.transform = CGAffineTransform(translationX: leftImagePoint.origin.x-rightImagePoint.origin.x, y: leftImagePoint.origin.y-rightImagePoint.origin.y)
                            }
                            
                            
                        }, completion: {(_ finished: Bool) -> Void in
                            for i in 0 ..< imageSplitSize {
                                self.leftImages[i].imageView.image = self.rightImages[i+imageSplitSize].imageView.image
                                self.leftImagesGlobal[i].name = self.rightImages[i+imageSplitSize].name;
                                self.rightImages[i+imageSplitSize].imageView.image = UIImage()
                                self.rightImages[i+imageSplitSize].imageView.transform = CGAffineTransform(translationX:0,y:0)
                            }
                            
                            let initsize = self.rightImages.count/2;
                            self.leftImages = Array(self.leftImagesGlobal[0 ..< initsize])
                            self.rightImages = Array(self.rightImagesGlobal[0 ..< initsize])
                            self.isInitialScreen = false;
                        })
                    })
                    
                    
                    
                    startLookTime = Double.greatestFiniteMagnitude;
                }
            }
            lookDirection = "RESET";
        }else{
            if lookDirection == "LEFT" && settingsVals.timeactivateleftright < currentTime - startLookTime {
                let timestampdiff = (currentTime - startLookTime - settingsVals.timeactivateleftright) / (settingsVals.leftRightLookDelay - settingsVals.timeactivateleftright);
                LeftArrowBackground.alpha = timestampdiff
                //leftarrowelement.style.backgroundColor = backgroundColorChange(timestampdiff);
            } else if lookDirection == "RIGHT" && settingsVals.timeactivateleftright < currentTime - startLookTime {
                let timestampdiff = (currentTime - startLookTime - settingsVals.timeactivateleftright) / (settingsVals.leftRightLookDelay - settingsVals.timeactivateleftright);
                RightArrowBackground.alpha = timestampdiff
                //rightarrowelement.style.backgroundColor = backgroundColorChange(timestampdiff);
            }
        }
    }
    
}

