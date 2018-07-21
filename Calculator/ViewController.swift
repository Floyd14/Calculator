//
//  ViewController.swift
//  Calculator
//
//  Created by Andrea Visini on 13/07/18.
//  Copyright © 2018 Andrea Visini. All rights reserved.
//

import UIKit

var calculatorCount = 0

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorCount += 1
        print("Loaded a new view (count = \(calculatorCount))")
        brain.addUnaryOperation(symbol: "Z") { [weak wself = self] in
            wself?.display.textColor = UIColor.red
            return sqrt($0)
        }
    }
    
    deinit {
        calculatorCount -= 1
        print("Deleted the view (count = \(calculatorCount))")
    }
    
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
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            if let operation = sender.currentTitle {
                brain.setOperand(operand: currentValueInDisplay)
                brain.performOperation(symbol: operation)
                userIsInTheMiddleOfTyping = false
                currentValueInDisplay = brain.result
            }
        }
    }
    
    /*------------------------- SAVING RESTORE ---------------------------------*/
    var savedProgram: CalculatorBrain.PropertyList?
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            currentValueInDisplay = brain.result
        }
    }
    /*--------------------------------------------------------------------------*/
    
}

