//
//  ColorfulArcView.swift
//  ColourfulArcs
//
//  Created by Nafisa Rahman on 3/17/17.
//  Copyright © 2017 Nafisa. All rights reserved.
//

import UIKit

class ColorfulArcView: UIView {
    
    var arcColor : CGColor = UIColor.red.cgColor
    
    var timerValue : CGFloat  = 0.0{
        didSet {
            
            if timerValue == 1 {
                arcColor = getRGBColor()
            }
            
            setNeedsDisplay()
            
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setUp()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    func setUp(){
        let label = UILabel()
        
        label.frame = CGRect(x: self.bounds.origin.x, y: 20.0, width: self.bounds.width , height: 50.0)
        
        label.text = "Tap to start / stop colourful arcs."
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.tag = 100
        
        self.addSubview(label)
        
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        drawCircle()
        
    }
    
    //MARK:- draw circle
    func drawCircle(){
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(3.0)
        
        //compute end angle in radians
        let endAngle = CGFloat(timerValue) * CGFloat.pi / 180
        
        var radius : CGFloat = 0.0
        
        if self.layer.frame.width > self.layer.frame.height {
            radius = CGFloat(self.layer.frame.width/8)
        }else {
            radius = self.layer.frame.height/8
        }
        
        context?.addArc(center: self.center, radius: radius, startAngle: CGFloat(0), endAngle: endAngle , clockwise: false)
        
        context?.setStrokeColor(arcColor)
        context?.strokePath()
        
    }
    
    //MARK:- get color
    func getRGBColor()->CGColor {
        
        let newColor = UIColor(displayP3Red: randomColorNo()/255.0, green: randomColorNo()/255.0, blue: randomColorNo()/255.0, alpha: 1.0)
        
        return newColor.cgColor
        
    }
    
    //MARK:- get random r g b values
    func randomColorNo()-> CGFloat {
        
        let random = CGFloat(arc4random_uniform(256))
        
        return random
    }
    
    
}
