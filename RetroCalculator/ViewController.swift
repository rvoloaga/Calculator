//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Voloaga Radu Stefan on 19/01/16.
//  Copyright © 2016 voloaga. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
        
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftVarStr = ""
    var rightVarStr = ""
    var currentOperation : Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            
        }catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
        
        
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        
        playSound()
        
        runningNumber += "\(btn.tag)"
        
        outputLbl.text = runningNumber
        
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
   
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubstractPressed(sender: AnyObject) {
        processOperation(Operation.Substract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(Operation.Clear)
    }
    
    func processOperation(op: Operation) {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                
                rightVarStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    
                    result = "\(Double(leftVarStr)! * Double(rightVarStr)!)"
                    
                } else   if currentOperation == Operation.Divide {
                    
                    result = "\(Double(leftVarStr)! / Double(rightVarStr)!)"
                    
                } else   if currentOperation == Operation.Substract {
                    
                    result = "\(Double(leftVarStr)! - Double(rightVarStr)!)"
                    
                } else   if currentOperation == Operation.Add {
                    
                    result = "\(Double(leftVarStr)! + Double(rightVarStr)!)"
                    
                }else if currentOperation == Operation.Clear {
               
                    
                
                }
                
                leftVarStr = result
                outputLbl.text = result
                
            }
            
            currentOperation = op
        
        } else {
            
            leftVarStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    
    }
    
    func playSound () {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}

