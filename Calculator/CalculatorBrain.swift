//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Andrea Visini on 13/07/18.
//  Copyright © 2018 Andrea Visini. All rights reserved.
//

import Foundation

func multiply (op1: Double, op2: Double) -> Double {
    return op1*op2
}

class CalculatorBrain {
    
    var accumulator = 0.0
    
    func setOperand (operand: Double){
        accumulator = operand
    }
    
    let operations: Dictionary<String,Operations> = [
        "AC": Operations.Constant(0.0),
        "√": Operations.UnaryOperation(sqrt),
        "×": Operations.BinaryOperation(multiply),
        "=": Operations.Equals
    ]
    
    
    //like classes ...
    // pass by values
    // NOTE: type Optional is an enum
    enum Operations {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation (symbol: String ) {
        //        switch symbol {
        //        case "AC":
        //            accumulator = 0.0
        //        case "+":
        //            break
        //        default:
        //            break
        //        }
        if let operation = operations[symbol] {
            //accumulator = operation
            switch operation {
            case .Constant(let value) : accumulator = value
            case .UnaryOperation(let function) : accumulator = function(accumulator)
            case .BinaryOperation : break
            case .Equals : break
            }
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
