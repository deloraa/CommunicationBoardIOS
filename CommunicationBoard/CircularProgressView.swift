//
//  CircularProgressView.swift
//  CommunicationBoard
//
//  Created by Adam Delora on 1/14/22.
//

import UIKit

class CircularProgressView: UIView {

    var progressLyr = CAShapeLayer()
     var trackLyr = CAShapeLayer()
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeCircularPath()
     }
     var progressClr = UIColor.systemBlue {
        didSet {
           progressLyr.strokeColor = progressClr.cgColor
        }
     }
     var trackClr = UIColor.gray {
        didSet {
           trackLyr.strokeColor = trackClr.cgColor
        }
     }
     func makeCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width-1)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLyr.path = circlePath.cgPath
        trackLyr.fillColor = UIColor.clear.cgColor
        trackLyr.strokeColor = trackClr.cgColor
        trackLyr.lineWidth = 10.0
        trackLyr.strokeEnd = 1.0
        layer.addSublayer(trackLyr)
        progressLyr.path = circlePath.cgPath
        progressLyr.fillColor = UIColor.clear.cgColor
        progressLyr.strokeColor = progressClr.cgColor
        progressLyr.lineWidth = 10.0
        progressLyr.strokeEnd = 0.0
        layer.addSublayer(progressLyr)
     }
    func setValue(value:Double){
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width-1)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLyr.path = circlePath.cgPath
        progressLyr.path = circlePath.cgPath
        progressLyr.strokeEnd = CGFloat(value)
    }
    


}
