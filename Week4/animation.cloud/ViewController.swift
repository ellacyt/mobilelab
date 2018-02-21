//
//  ViewController.swift
//  animation.cloud
//
//  Created by Ella Chung on 2/21/18.
//  Copyright © 2018 Ella Chung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // this time we've added an IBOutlet for the slider
    // this allows us to reference the slider from code
    // for example get the current position of the slider
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // we don't have to do anything here at the moment
    }
    
    @IBAction func animateButtonPressed(sender: AnyObject) {
        
            // set up some constants for the animation
            let duration = 2.0
            let options = UIViewAnimationOptions.curveLinear
            
            // randomly assign a delay of 0.9 to 1s
            let delay = TimeInterval(900 + arc4random_uniform(100)) / 1000
            
            // set up some constants for the fish
            let size : CGFloat = CGFloat( arc4random_uniform(50))+150
            let yPosition : CGFloat = CGFloat( arc4random_uniform(200))+100
            
            // create the cloud
            let cloud = UIImageView()
            cloud.image = UIImage(named: "cloud.png")
            cloud.frame = CGRect(x:0-size, y:yPosition, width:size, height:size)
            self.view.addSubview(cloud)
            
            // define the animation
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                
            // move the cloud
            cloud.frame = CGRect(x:640, y:yPosition, width:size, height:size)
                
            }, completion: { animationFinished in
                
                // remove the cloud
                cloud.removeFromSuperview()
            })
        }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
