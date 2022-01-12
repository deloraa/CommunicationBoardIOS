//
//  howToViewController.swift
//  CommunicationBoard
//
//  Created by Adam Delora on 1/11/22.
//

import UIKit
import AVKit
import AVFoundation

class howToViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "CommBoard", ofType: "mp4")!))
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.view.frame = self.view.bounds
        playerController.videoGravity = .resizeAspect
        self.addChild(playerController)
        self.view.addSubview(playerController.view)
        playerController.didMove(toParent: self)
        
    }
        

 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
