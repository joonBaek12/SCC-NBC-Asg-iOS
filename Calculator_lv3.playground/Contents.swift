import Foundation

class Calculator {
    var firstNumber: Double?
    var secondNumber: Double?
    
    func calculate(operation: AbstractOperation, firstNumber: Double, secondNumber: Double) -> Double {
        return operation.operate(firstNumber: firstNumber, secondNumber: secondNumber)
    }
}

class AbstractOperation {
    func operate(firstNumber: Double, secondNumber: Double) -> Double {
        return 0
    }
}

class AddOperation: AbstractOperation {
    override func operate(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber + secondNumber
    }
}

class SubtractOperation: AbstractOperation {
    override func operate(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber - secondNumber
    }
}

class MultiplyOperation: AbstractOperation {
    override func operate(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber * secondNumber
    }
}

class DivideOperation: AbstractOperation {
    override func operate(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber / secondNumber
    }
}

let calculator = Calculator()

let addOperation = AddOperation()
let subtractOperation = SubtractOperation()
let multiplyOperation = MultiplyOperation()
let divideOperation = DivideOperation()

let addResult = calculator.calculate(operation: addOperation, firstNumber: 2, secondNumber: 2)
let subtractResult = calculator.calculate(operation: subtractOperation, firstNumber: 2, secondNumber: 2)
let multiplyResult = calculator.calculate(operation: multiplyOperation, firstNumber: 2, secondNumber: 2)
let divideResult = calculator.calculate(operation: divideOperation, firstNumber: 2, secondNumber: 2)

print("addResult : \(addResult)")
print("subtractResult : \(subtractResult)")
print("multiplyResult : \(multiplyResult)")
print("divideResult : \(divideResult)")
