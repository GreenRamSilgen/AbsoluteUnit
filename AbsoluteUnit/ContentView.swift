//
//  ContentView.swift
//  AbsoluteUnit
//
//  Created by Kiran Shrestha on 2/1/25.
//

import SwiftUI

enum TemperatureUnit : String, CaseIterable{
    case Fahrenheit = "Fahrenheit"
    case Celsius = "Celsius"
    case Kelvin = "Kelvin"
}

struct ContentView: View {
    @State private var valueToConvert : String = "0.0"
    @State private var unitToConvertFrom : TemperatureUnit = .Fahrenheit
    @State private var unitToConvertTo : TemperatureUnit = .Celsius
    @State private var conversionUnitType = "Temperature"
    @FocusState private var isStartingValueFocused: Bool
    
    var convertedVal : Double {
        if let valueToConvert = Double(valueToConvert) {
            switch unitToConvertFrom {
            case .Fahrenheit:
                switch unitToConvertTo {
                case .Fahrenheit:
                    return valueToConvert
                case .Celsius:
                    return (valueToConvert - 32) * (5/9)
                case .Kelvin:
                    return (valueToConvert - 32) * (5/9) + 273.15
                }
                
            case .Celsius:
                switch unitToConvertTo {
                case .Fahrenheit:
                    return valueToConvert * (9/5) + 32
                case .Celsius:
                    return valueToConvert
                case .Kelvin:
                    return valueToConvert + 273.15
                }
                
            case .Kelvin:
                switch unitToConvertTo {
                case .Fahrenheit:
                    return (valueToConvert - 273.15) * (9/5) + 32
                case .Celsius:
                    return valueToConvert - 273.15
                case .Kelvin:
                    return valueToConvert
                }
            }
        }else {
            return 0.0
        }
    }
    var body: some View {
        NavigationView {
            Form {
                Section("Conversion Type") {
                    Picker("Units", selection: $conversionUnitType) {
                        ForEach(["Temperature", "Length", "Time", "Volume"], id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Converion Units Selection"){
                    HStack {
                        VStack{
                            Section("From") {
                                Picker("Select", selection: $unitToConvertFrom){
                                    ForEach(TemperatureUnit.allCases, id: \.self) {
                                        Text($0.rawValue)
                                    }
                                }
                                .pickerStyle(.wheel)
                                //4454 -- 4455
                            }
                        }
                        VStack{
                            Section("To") {
                                Picker("Select", selection: $unitToConvertTo){
                                    ForEach(TemperatureUnit.allCases, id: \.self) {
                                        Text($0.rawValue)
                                    }
                                }
                                .pickerStyle(.wheel)
                                //4454 -- 4455
                            }
                        }                }
                }
                Section("Starting Value") {
                    TextField("Value to convert", text: $valueToConvert)
                        .keyboardType(.numberPad)
                        .focused($isStartingValueFocused, equals: true)
                        .onChange(of: valueToConvert, initial: false) { oldValue , newValue in
                            let hasNonNumber = /[^0-9.]/
                            let decimalCount = newValue.reduce(into: 0) { result, char in
                                return result += char == "." ? 1 : 0
                            }
                            
                            if newValue.contains(hasNonNumber) || decimalCount > 1{
                                valueToConvert = oldValue
                            }
                            else {
                                valueToConvert = newValue
                            }
                        }
                }
                Section("Converted Value") {
                    Text("\(convertedVal)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
