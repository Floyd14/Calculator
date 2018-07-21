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
    private var internalProgram = [AnyObject] ()
    
    func setOperand (operand: Double){
        accumulator = operand
        internalProgram.append(operand as AnyObject) //storing
    }
    
    // permetto all view di creare unaryOperations
    func addUnaryOperation(symbol: String, operation: @escaping (Double) -> Double) {
        operations[symbol] = Operations.UnaryOperation(operation)
    }
    
    private var operations: Dictionary<String,Operations> = [
        "AC": Operations.Constant(0.0),
        "√": Operations.UnaryOperation(sqrt), //i set the associated value
        "±": Operations.UnaryOperation({-$0}),
        "×": Operations.BinaryOperation(multiply),
        "÷": Operations.BinaryOperation({(op1: Double, op2: Double) -> Double in //implemento clousure (inline function)
            return op1/op2
        }),
        "+": Operations.BinaryOperation({ $0 + $1 }), //sfrutto type inference + defoult arguments $0 , ...
        "-": Operations.BinaryOperation({ $0 - $1 }),
        "=": Operations.Equals
    ]
    
    
    // Descipt types
    // can have metods, computed vars
    // can't inherits
    // pass by values
    // NOTE: type Optional is an enum
    private enum Operations {
        // No Inizialization needed
        case Constant(Double)
        case UnaryOperation((Double) -> Double) //function with an associated value..
        case BinaryOperation((Double, Double) -> Double)
        //        case Reset
        case Equals
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    // Descipt types
    // can have metods, all kind of vars
    // can't inherits
    // pass by values
    // NOTE: type Optional is an enum
    private struct PendingBinaryOperationInfo {
        // No Inizialization needed
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    
    func performOperation (symbol: String ) {
        
        //                switch symbol {
        //                case "AC":
        //                    accumulator = 0.0
        //                case "+":
        //                    break
        //                default:
        //                    break
        //                }
        internalProgram.append(symbol as AnyObject) //storing
        if let operation = operations[symbol] {
            //accumulator = operation
            switch operation {
            // get the associated value ( let associatedValue)
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                // quando premo * creo una struct ...
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
                //            case .Reset:
                //                pending = nil
                //                accumulator = pending
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    
    /*---------------------------------------------
     Storing
     --------------------------------------------*/

    
    typealias PropertyList = AnyObject
    var program: PropertyList {
        get {
            return internalProgram as AnyObject
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand: operand)
                    } else if let operation = op as? String {
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    
    private func clear() {
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    /*---------------------------------------------*/
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
