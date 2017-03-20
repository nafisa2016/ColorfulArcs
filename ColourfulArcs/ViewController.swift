//
//  ViewController.swift
//  ColourfulArcs
//
//  Created by Nafisa Rahman on 3/17/17.
//  Copyright © 2017 Nafisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var colorfulArcView: ColorfulArcView!
    var start: Bool = false
    var arctimer  = Timer()
    var arcTimerValue = 0
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK:- create a custom view
        colorfulArcView = ColorfulArcView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        colorfulArcView.backgroundColor = UIColor.white
        
        //add gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.delegate = self
        colorfulArcView.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(colorfulArcView)
        
        
        //timer
        arctimer = Timer.scheduledTimer(timeInterval: 0.002, target: self, selector: #selector(refreshArc), userInfo: nil, repeats: true)
        
    }
    
    
    
    func refreshArc(){
        if start {
            
            if arcTimerValue < 360 {
                arcTimerValue += 1
                
            }else {
                arcTimerValue = 0
            }
            
            colorfulArcView.timerValue = CGFloat(arcTimerValue)
            
        }
        
    }
    
    func handleTap(_ sender: UITapGestureRecognizer){
        
        if start {
            
            start = false
            
            arctimer.invalidate()
            arcTimerValue = 0
            
        }else {
            
            start = true
            
            arctimer = Timer.scheduledTimer(timeInterval: 0.002, target: self, selector: #selector(refreshArc), userInfo: nil, repeats: true)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- device rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        colorfulArcView.layer.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.height, height: self.view.frame.width)
        
        colorfulArcView.viewWithTag(100)?.center.x = colorfulArcView.frame.width/2
        
        colorfulArcView.setNeedsDisplay()
        
    }
    
}

