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

extension Array {
    func split() -> (left: [Element], right: [Element]) {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return (left: Array(leftSplit), right: Array(rightSplit))
    }
}


class ViewController: UIViewController, ARSCNViewDelegate {
    
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
    
    var iconImageViews = [(String,UIImageView)]()
    var imageToSoundString = ["1-Afraid":"I am afraid","2-Pain":"I am in pain", "3-Yes":"Yes", "4-No":"No","5-Sad":"I am sad","6-Frustrated":"I am frustrated","7-Nurse":"I would like a nurse","8-Doctor":"I would like a doctor", "9-Tired":"I am tired","10-FeelSick":"I feel sick","11-Cold_hot":"I am cold or hot","12-ShortofBreath":"I am short of breath","13-Angry":"I am angry","14-Dizzy":"I am dizzy","15-Choking":"I am choking","16-Hungry":"I am hungry or thirsty","17-HowamI":"How am I doing","18-WhatTime":"What time is it","19-WhatsHappening":"What is happening","20-Comeback":"Come back later","21-Situp":"I would like to situp","22-LieDown":"I would like to lie down","23-Home":"I would like to go home","24-TVVideo":"Turn tv on or off","25-Light":"Turn light on or off","26-CallLight":"Activate call light","27-Water":"I want water","28-Glasses":"I need glasses or socks","29-Suction":"I would like to be suctioned", "30-LipsMoistened":"I would like my lips moistenend","31-Sleep":"I want to sleep","32-SoundOff":"Turn sound on or off"]

    var iconImages = [(name: "1-Afraid", image:UIImage(named: "1-Afraid")),(name: "2-Pain", image:UIImage(named: "2-Pain")),(name: "3-Yes", image:UIImage(named: "3-Yes")),(name: "4-No", image:UIImage(named: "4-No")),(name: "5-Sad", image:UIImage(named: "5-Sad")),(name: "6-Frustrated", image:UIImage(named: "6-Frustrated")),(name: "7-Nurse", image:UIImage(named: "7-Nurse")),(name: "8-Doctor", image:UIImage(named: "8-Doctor")),(name: "9-Tired", image:UIImage(named: "9-Tired")),(name: "10-FeelSick", image:UIImage(named: "10-FeelSick")),(name: "11-Cold_hot", image:UIImage(named: "11-Cold_hot")),(name: "12-ShortofBreath", image:UIImage(named: "12-ShortofBreath")),(name: "13-Angry", image:UIImage(named: "13-Angry")),(name: "14-Dizzy", image:UIImage(named: "14-Dizzy")),(name: "15-Choking", image:UIImage(named: "15-Choking")),(name: "16-Hungry", image:UIImage(named: "16-Hungry")),(name: "17-HowamI", image:UIImage(named: "17-HowamI")),(name: "18-WhatTime", image:UIImage(named: "18-WhatTime")),(name: "19-WhatsHappening", image:UIImage(named: "19-WhatsHappening")),(name: "20-Comeback", image:UIImage(named: "20-Comeback")),(name: "21-Situp", image:UIImage(named: "21-Situp")),(name: "22-LieDown", image:UIImage(named: "22-LieDown")),(name: "23-Home", image:UIImage(named: "23-Home")),(name: "24-TVVideo", image:UIImage(named: "24-TVVideo")),(name: "25-Light", image:UIImage(named: "25-Light")),(name: "26-CallLight", image:UIImage(named: "26-CallLight")),(name: "27-Water", image:UIImage(named: "27-Water")),(name: "28-Glasses", image:UIImage(named: "28-Glasses")),(name: "29-Suction", image:UIImage(named: "29-Suction")),(name: "30-LipsMoistened", image:UIImage(named: "30-LipsMoistened")),(name: "31-Sleep", image:UIImage(named: "31-Sleep")),(name: "32-SoundOff", image:UIImage(named: "32-SoundOff"))]
    
    var leftImagesGlobal = [(name:String,imageView:UIImageView)]();
    var rightImagesGlobal = [(name:String,imageView:UIImageView)]();
    var leftImages = [(name:String,imageView:UIImageView)]();
    var rightImages = [(name:String,imageView:UIImageView)]();
    var topText = "Running: Blink either eye to pause"
    
    var widthThreshold = 0.5;
    var leftRightLookDelay = 0.500;
    var upperBlinkCutoff = 0.5;
    var lowerBlinkCutoff = 0.5;
    var blinkDelay = 1.200;
    var timeactivateleftright = 0.09;
    var timeactivateblink = 0.36;
    
    func resetImages(){
        
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
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self

        iconImageViews =
        [(name: "1-Afraid", imageView:Icon1),(name: "2-Pain", imageView:Icon2),(name: "3-Yes", imageView:Icon3),(name: "4-No", imageView:Icon4),(name: "5-Sad", imageView:Icon5),(name: "6-Frustrated", imageView:Icon6),(name: "7-Nurse", imageView:Icon7),(name: "8-Doctor", imageView:Icon8),(name: "9-Tired", imageView:Icon9),(name: "10-FeelSick", imageView:Icon10),(name: "11-Cold_hot", imageView:Icon11),(name: "12-ShortofBreath", imageView:Icon12),(name: "13-Angry", imageView:Icon13),(name: "14-Dizzy", imageView:Icon14),(name: "15-Choking", imageView:Icon15),(name: "16-Hungry", imageView:Icon16),(name: "17-HowamI", imageView:Icon17),(name: "18-WhatTime", imageView:Icon18),(name: "19-WhatsHappening", imageView:Icon19),(name: "20-Comeback", imageView:Icon20),(name: "21-Situp", imageView:Icon21),(name: "22-LieDown", imageView:Icon22),(name: "23-Home", imageView:Icon23),(name: "24-TVVideo", imageView:Icon24),(name: "25-Light", imageView:Icon25),(name: "26-CallLight", imageView:Icon26),(name: "27-Water", imageView:Icon27),(name: "28-Glasses", imageView:Icon28),(name: "29-Suction", imageView:Icon29),(name: "30-LipsMoistened", imageView:Icon30),(name: "31-Sleep", imageView:Icon31),(name: "32-SoundOff", imageView:Icon32)]
        timeactivateleftright = 3/10*leftRightLookDelay;
        timeactivateblink = 3/10*blinkDelay;
        
        let tempIconImagesGlobal = iconImageViews.split();
        leftImagesGlobal = tempIconImagesGlobal.left;
        rightImagesGlobal = tempIconImagesGlobal.right;
        leftImages = leftImagesGlobal;
        rightImages = rightImagesGlobal;

/*
        print(self.Icon10.frame.midX)
        print(self.Icon12.frame.midX)
        print(self.Icon12.frame.origin)
        let globalPoint =  self.Icon10.convert(self.Icon10.bounds, to: TopStack)
        let globalPoint2 = self.Icon12.convert(self.Icon12.bounds, to: TopStack)
        print(globalPoint)
        print(globalPoint2)
        
        let icon12xvalue = self.Icon12.superview!.superview!.superview!.frame.origin.x - self.Icon27.superview!.superview!.superview!.frame.origin.x
        let icon27xvalue = self.Icon12.frame.origin.x-self.Icon27.frame.origin.x
*/
 /*
        UIView.animate(withDuration: 2.0, animations: {() -> Void in
            self.Icon2?.transform = CGAffineTransform(translationX: 179, y: 88 )
        }, completion: {(_ finished: Bool) -> Void in
            /*UIView.animate(withDuration: 2.0, animations: {() -> Void in
                self.Icon12?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            })*/
        })*/


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
    
    func readSound(readme:String, person:String){
        //try to use arthur and martha they sound best
        var voiceToUse = AVSpeechSynthesisVoice(language:"en-US")
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            if #available(iOS 9.0, *) {
                if voice.name == person {
                    voiceToUse = voice
                }
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
    func readMyFace(anchor: ARFaceAnchor) {
  

        let currentTime = Date().timeIntervalSince1970;
        // function that takes an ARFaceAnchor in as a parameter
        //left look values
        let eyeLookInLeft = anchor.blendShapes[.eyeLookInLeft]
        let eyeLookOutRight = anchor.blendShapes[.eyeLookOutRight]
        
        //right look values
        let eyeLookOutLeft = anchor.blendShapes[.eyeLookOutLeft]
        let eyeLookInRight = anchor.blendShapes[.eyeLookInRight]
        
        //let eyeBlinkRight = anchor.blendShapes[.eyeBlinkRight]
        //let eyeBlinkLeft = anchor.blendShapes[.eyeBlinkLeft]
        
        // Define different anchors utilizing classes in the imported kit
        // was actually right eye blink
        //print("\(eyeBlinkLeft?.decimalValue ?? 0.0)")
        // when this function is running I want to signal to the user that the function is reacting
        

        
        if eyeLookOutRight?.decimalValue ?? 0.0 > 0.5 && eyeLookInLeft?.decimalValue ?? 0.0 > 0.5 && lookDirection != "LEFT" && lookDirection != "RESET"
        {
            startLookTime = currentTime;
            lookDirection = "LEFT";
            RightArrowBackground.alpha = 0
            //rightarrowelement.style.backgroundColor = backgroundColorChange(0);
            
        } else if eyeLookOutLeft?.decimalValue ?? 0.0 > 0.5 && eyeLookInRight?.decimalValue ?? 0.0 > 0.5 && lookDirection != "RIGHT" && lookDirection != "RESET"
        {
            startLookTime = currentTime;
            lookDirection = "RIGHT";
            LeftArrowBackground.alpha = 0
        } else if eyeLookOutRight?.decimalValue ?? 0.0 <= 0.5 && eyeLookInLeft?.decimalValue ?? 0.0 <= 0.5 && eyeLookOutLeft?.decimalValue ?? 0.0 <= 0.5 && eyeLookInRight?.decimalValue ?? 0.0 <= 0.5{
            startLookTime = Double.greatestFiniteMagnitude;
            lookDirection = "";
            LeftArrowBackground.alpha = 0
            RightArrowBackground.alpha = 0
        }
        
        if startLookTime + leftRightLookDelay < currentTime {
            
            if lookDirection == "LEFT" {

                if self.leftImages.count == 1{
                    self.backgroundModal.alpha = 0.5
                    self.backgroundModal.layoutIfNeeded()
                    self.modalImage.isHidden = false
                    self.modalImage.image = self.leftImages[0].imageView.image
                    self.modalImage.layoutIfNeeded()
                    readSound(readme:self.imageToSoundString[self.leftImages[0].name] ?? "" , person:"Martha")
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
                    let animationDuration = leftRightLookDelay/2
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
                        })
                    })
                    
                    startLookTime = Double.greatestFiniteMagnitude;
                }
            }else if lookDirection == "RIGHT" {
                
                if self.rightImages.count == 1{
                    self.backgroundModal.alpha = 0.5
                    self.backgroundModal.layoutIfNeeded()
                    self.modalImage.isHidden = false
                    self.modalImage.image = self.rightImages[0].imageView.image
                    self.modalImage.layoutIfNeeded()
                    readSound(readme:self.imageToSoundString[self.rightImages[0].name] ?? "", person:"Martha")
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
                    let animationDuration = leftRightLookDelay/2
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
                        })
                    })
                    
                    
                    
                    startLookTime = Double.greatestFiniteMagnitude;
                }
            }
            lookDirection = "RESET";
        }else{
            if lookDirection == "LEFT" && timeactivateleftright < currentTime - startLookTime {
                let timestampdiff = (currentTime - startLookTime - timeactivateleftright) / (leftRightLookDelay - timeactivateleftright);
                LeftArrowBackground.alpha = timestampdiff
                //leftarrowelement.style.backgroundColor = backgroundColorChange(timestampdiff);
            } else if lookDirection == "RIGHT" && timeactivateleftright < currentTime - startLookTime {
                let timestampdiff = (currentTime - startLookTime - timeactivateleftright) / (leftRightLookDelay - timeactivateleftright);
                RightArrowBackground.alpha = timestampdiff
                //rightarrowelement.style.backgroundColor = backgroundColorChange(timestampdiff);
            }
        }
    }
    
}
