//
//  ViewController.swift
//  Spalc
//
//  Created by Stuart Chapman on 30/09/2015.
//  Copyright © 2015 little robot Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var buttonSound: AVAudioPlayer!
    
    @IBOutlet weak var counter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(button: UIButton!) {
        playSound()
    }
    
    func loadSound() {
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let url = NSURL.fileURLWithPath(path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: url)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func playSound()
    {
        if (buttonSound.playing) {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
}

