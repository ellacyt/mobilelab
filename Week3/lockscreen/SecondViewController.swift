//
//  SecondViewController.swift
//  lockscreen
//
//  Created by Ella Chung on 2/13/18.
//  Copyright © 2018 Ella Chung. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {

    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // EDIT START ////////////////////////////////////////////////////////////////////////////////////////
    
    // Set to 'true' or 'false' to control content sequence.
    // Either flip through content in sequence or randomize.
    let randomize = true
    
    // Set to array size.
    // Make sure all arrays are the same length and matches array size.
    let arraySize = 6
    
    // Background array.
    let bgColorArray = [UIColor(hex: 0x61BB46),
                        UIColor(hex: 0xFDB827),
                        UIColor(hex: 0xF5821F),
                        UIColor(hex: 0xE03A3E),
                        UIColor(hex: 0x963D97),
                        UIColor(hex: 0x009DDC)]
    
    // Image name array.
    let imageNameArray = ["tap1.jpg",
                          "tap2.jpg",
                          "bomb.jpg",
                          "skip.jpg",
                          "tap1.jpg",
                          "tap2.jpg"]
    
    // String array for label.
    let stringArray = ["Tap Once",
                       "Tap Twice",
                       "Bomb!",
                       "Skip",
                       "Tap Once",
                       "Tap Twice"]
    
    // MP3 sound file array.
    let soundArray = ["",
                      "",
                      "explode",
                      "",
                      "",
                      ""]
    
    // EDIT END //////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    // Connected to storyboard UI elements.
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func Back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var player: AVAudioPlayer?
    
    var currentIndex = -1
    
    
    // Initial setup function.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateContent()
    }
    
    // Called when screen is tapped.
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        generateImpactFeedback()
        
        updateContent()
    }
    
    
    // Update content based on array content and current array index.
    func updateContent() {
        // Update content index.,
        nextIndex()
        
        // Update background color.
        view.backgroundColor = bgColorArray[currentIndex]
        
        // Update label.
        label.text = stringArray[currentIndex]
        
        // Update image if string is not empty
        if imageNameArray[currentIndex].isEmpty {
            imageView.image = nil
        } else {
            imageView.image = UIImage(named: imageNameArray[currentIndex])
        }
        
        // Play sound.
        if !soundArray[currentIndex].isEmpty {
            playSoundMP3(filename: soundArray[currentIndex])
        }
    }
    
    
    // Either increment index or randomize.
    func nextIndex() {
        if randomize {
            currentIndex = Int(arc4random_uniform(UInt32(arraySize)))
        } else {
            currentIndex = (currentIndex + 1 == arraySize) ? 0 : currentIndex + 1
        }
    }
    
    // Make the device vibrate.
    func generateImpactFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    // Play a mp3 sound file.
    @IBOutlet weak var Play: UIButton!
    func playSoundMP3(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
