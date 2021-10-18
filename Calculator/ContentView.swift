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
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack{
                    Spacer()
                    if operation != .empty {
                        Text(textField2)
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .frame(height: 150)
                            .border(.black, width: 1)
                    } else {
                        Text("")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .frame(height: 150)
                            .border(.black, width: 1)
                    }
                }
                HStack {
                    Spacer()
                    Text(textField)
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                        .frame(height: 150)
                        .border(.black, width: 1)
                }
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 5) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                display(button: button)
                            }) {
                                Rectangle()
                                 
                                    .frame(width: buttonWidth(button: button), height: 90)
                                    .foregroundColor(buttonColor(button: button))
                                    .cornerRadius(10)
                                    .overlay(
                                        Text(button.rawValue)
                                            .font(.title)
                                            .foregroundColor(.black)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                                .stroke(.black)
                                    )
                                    .shadow(radius: 5)
                                    
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ContentView {
    
    func buttonWidth(button: Buttons) -> CGFloat {
        switch button {
        case .zero: return ((UIScreen.main.bounds.width - 12) / 4) * 2
        default: return (UIScreen.main.bounds.width - (5*5)) / 4
        }
    }
    
    
    func display(button: Buttons) {
        switch button {
        case .divide, .multiply, .subtract, .add: math(operation: button)
        case .equal: math(operation: button)
        case .clear: textField = ""; textField2 = ""
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
            textField2 = String(firstNum) + operation.rawValue
        }
        else if operation == .multiply {
            firstNum = (textField as NSString).doubleValue
            self.operation = operation
            textField = ""
            textField2 = String(firstNum) + operation.rawValue
            
        }
        else if operation == .subtract {
            firstNum = (textField as NSString).doubleValue
            self.operation = operation
            textField = ""
            textField2 = String(firstNum) + operation.rawValue
        }
        else if operation == .add {
            firstNum = (textField as NSString).doubleValue
            self.operation = operation
            textField = ""
            textField2 = String(firstNum) + operation.rawValue
        }
        else if operation == .equal {
            let num: Double = (textField as NSString).doubleValue
            switch self.operation {
            case .divide:   textField2 = String(firstNum / num);
                            textField = ""
            case .multiply: textField2 = String(firstNum * num);
                            textField = ""
            case .subtract: textField2 = String(firstNum - num);
                            textField = ""
            case .add:      textField2 = String(firstNum + num);
                            textField = ""
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
