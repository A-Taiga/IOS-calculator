//
//  ContentView.swift
//  Calculator
//
//  Created by Anthony Polka on 10/18/21.
//

import SwiftUI


enum Buttons: String {
    
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case zero = "0"
    case clear = "C"
    case negative = "+/-"
    case percent = "%"
    case divide = "÷"
    case multiply = "×"
    case subtract = "-"
    case add = "+"
    case decimal = "."
    case equal = "="
    case empty
    
}

struct ContentView: View {
    
    let buttons: [[Buttons]] = [[.clear, .negative, .percent, .divide],
                                [.seven, .eight, .nine, .multiply],
                                [.four, .five, .six, .subtract],
                                [.one, .two, .three, .add],
                                [.zero, .decimal, .equal]]
    @State private var textField = ""
    @State private var textField2 = ""
    @State private var firstNum: Double = 0
    @State private var operation : Buttons = .empty
    var body: some View {
        VStack {
            if operation != .empty {
                Text(textField2)
                    .font(.title)
                    .frame(height: 150)
                    .border(.black, width: 1)
            }
           
            Text(textField)
                .font(.title)
                .frame(height: 150)
                .border(.black, width: 1)
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            display(button: button)
                        }) {
                            Rectangle()
                                .frame(width: 90, height: 90)
                                .foregroundColor(buttonColor(button: button))
                                .overlay(
                                    Text(button.rawValue)
                                        .font(.title)
                                        .foregroundColor(.black)
                                )
                                
                        }
                    }
                }
            }
        }
    }
}

extension ContentView {
    
    enum Operation {
        case divide
        case multiply
        case subtract
        case add
    }
    
    
    func display(button: Buttons) {
        switch button {
        case .divide, .multiply, .subtract, .add: math(operation: button)
        case .equal: math(operation: button)
        case .clear: textField = ""
        case .negative:
            if textField.contains("-") {
               textField = textField.replacingOccurrences(of: "-", with: "")
            } else {
                textField = "-" + textField
            }
        default: textField += button.rawValue
        }
    }
    
    func math(operation: Buttons) {
        if operation == .divide {
            firstNum = (textField as NSString).doubleValue
            self.operation = operation
            textField = ""
            textField2 = String(firstNum)
        }
        else if operation == .multiply {
            firstNum = (textField as NSString).doubleValue
            self.operation = operation
            textField = ""
            textField2 = String(firstNum)
            
        }
        else if operation == .subtract {
            firstNum = (textField as NSString).doubleValue
            self.operation = operation
            textField = ""
            textField2 = String(firstNum)
        }
        else if operation == .add {
            firstNum = (textField as NSString).doubleValue
            self.operation = operation
            textField = ""
            textField2 = String(firstNum)
        }
        else if operation == .equal {
            let num: Double = (textField as NSString).doubleValue
            switch self.operation {
            case .divide:   textField = String(firstNum / num)
            case .multiply: textField = String(firstNum * num)
            case .subtract: textField = String(firstNum - num)
            case .add:      textField = String(firstNum + num)
            default: break
            }
        }
    }
    
    
    func buttonColor(button: Buttons) -> Color {
        switch button {
        case .divide:   return .red
        case .multiply: return .red
        case .subtract: return .red
        case .add:      return .red
        case .equal:    return .green
        default:        return .gray
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
