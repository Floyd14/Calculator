//
//  ViewController.swift
//  Calculator
//
//  Created by Andrea Visini on 13/07/18.
//  Copyright © 2018 Andrea Visini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    private var currentValueInDisplay : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            if userIsInTheMiddleOfTyping {
                display.text = display.text! + digit
            } else {
                display.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction private func operation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let operand = sender.currentTitle {
            switch operand {
            case "AC":
                currentValueInDisplay = 0.0
            default:
                break
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

