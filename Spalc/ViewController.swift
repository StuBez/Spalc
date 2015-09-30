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
    enum Operation: String {
        case Clear = "Clear"
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Equals = "="
        case None = ""
    }
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftCalculationPart = ""
    var rightCalculationPart = ""
    var result = ""
    var currentOperation = Operation.None
    
    @IBOutlet weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(sender: UIButton!) {
        playSound()
        
        addNumberToRunningTotal("\(sender.tag)")
        updateDisplay(runningNumber)
    }
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        playSound()
        clear()
    }
    
    @IBAction func divideButtonPressed(sender: UIButton) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func multiplyButtonPressed(sender: UIButton) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func subtractButtonPressed(sender: UIButton) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func addButtonPressed(sender: UIButton) {
        processOperation(Operation.Add)
    }
    
    @IBAction func equalsButtonPressed(sender: UIButton) {
        processOperation(currentOperation)
    }
    
    internal func processOperation(operation: Operation) {
        playSound()
        
        if !isReadyToPerformAnOperation() {
            currentOperation = operation
            return
        }
        
        if isThereACurrentOperation() {
            rightCalculationPart = runningNumber
            runningNumber = ""
            
            if operation == Operation.Divide {
                result = "\(Double(leftCalculationPart)! / Double(rightCalculationPart)!)"
            } else if operation == Operation.Multiply {
                result = "\(Double(leftCalculationPart)! * Double(rightCalculationPart)!)"
            } else if operation == Operation.Subtract {
                result = "\(Double(leftCalculationPart)! - Double(rightCalculationPart)!)"
            } else if operation == Operation.Add {
                result = "\(Double(leftCalculationPart)! + Double(rightCalculationPart)!)"
            }
            
            leftCalculationPart = result
            updateDisplay(result)
        } else {
            leftCalculationPart = runningNumber
            runningNumber = ""
        }
        
        currentOperation = operation
    }
    
    internal func loadSound() {
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let url = NSURL.fileURLWithPath(path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: url)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    internal func playSound() {
        if (buttonSound.playing) {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    internal func updateDisplay(value: String) {
        display.text = value
    }
    
    internal func addNumberToRunningTotal(number: String) {
        runningNumber += number
    }
    
    internal func isThereACurrentOperation() -> Bool {
        return currentOperation != Operation.None
    }
    
    internal func isReadyToPerformAnOperation() -> Bool {
        return runningNumber != ""
    }
    
    internal func clear() {
        display.text = "0"
        runningNumber = ""
        leftCalculationPart = ""
        rightCalculationPart = ""
        result = ""
        currentOperation = Operation.None
    }
}

