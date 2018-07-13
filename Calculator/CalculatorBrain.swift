//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Andrea Visini on 13/07/18.
//  Copyright © 2018 Andrea Visini. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    var accumulator = 0.0
    
    func setOperand (operand: Double){
        accumulator = operand
    }
    
    func performOperation (symbol: String ) {
        switch symbol {
        case "AC":
            accumulator = 0.0
        default:
            break
            
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
