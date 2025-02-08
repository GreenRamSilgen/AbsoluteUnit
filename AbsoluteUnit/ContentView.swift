//
//  ContentView.swift
//  AbsoluteUnit
//
//  Created by Kiran Shrestha on 2/1/25.
//

import SwiftUI

enum ConversionTypes : String, CaseIterable {
    case Temperature = "Temperature"
    case Length = "Length"
}

enum TemperatureUnit : String, CaseIterable{
    case Fahrenheit = "Fahrenheit"
    case Celsius = "Celsius"
    case Kelvin = "Kelvin"
}

//meters, kilometers, feet, yards, or miles
enum LengthUnit : String, CaseIterable {
    case Meters = "Meters"
    case Kilometers = "Kilometers"
    case Feet = "Feet"
    case Yards = "Yards"
    case Miles = "Miles"
}

struct ContentView: View {
    @State private var valueToConvert : String = "0.0"
    @State private var conversionUnitType : ConversionTypes = .Temperature
    
    @State private var temperatureUnitToConvertFrom = TemperatureUnit.Fahrenheit
    @State private var temperatureUnitToConvertTo = TemperatureUnit.Celsius
    @State private var lengthUnitToConvertFrom = LengthUnit.Meters
    @State private var lengthUnitToConvertTo = LengthUnit.Kilometers
    
    @FocusState private var isStartingValueFocused: Bool
    
    var convertedVal : Double {
        if let valueToConvert = Double(valueToConvert) {
            switch conversionUnitType {
            case .Temperature:
                return convertTemperature(from: valueToConvert)
            case .Length:
                return convertLength(from: valueToConvert)
            }
        }else {
            return 0.0
        }
    }
    
    func convertTemperature(from valueToConvert : Double) -> Double {
        switch temperatureUnitToConvertFrom {
        case .Fahrenheit:
            switch temperatureUnitToConvertTo {
            case .Fahrenheit:
                return valueToConvert
            case .Celsius:
                return (valueToConvert - 32) * (5/9)
            case .Kelvin:
                return (valueToConvert - 32) * (5/9) + 273.15
            }
            
        case .Celsius:
            switch temperatureUnitToConvertTo {
            case .Fahrenheit:
                return valueToConvert * (9/5) + 32
            case .Celsius:
                return valueToConvert
            case .Kelvin:
                return valueToConvert + 273.15
            }
            
        case .Kelvin:
            switch temperatureUnitToConvertTo {
            case .Fahrenheit:
                return (valueToConvert - 273.15) * (9/5) + 32
            case .Celsius:
                return valueToConvert - 273.15
            case .Kelvin:
                return valueToConvert
            }
        }
    }
    
    func convertLength(from valueToConvert: Double) -> Double {
        switch lengthUnitToConvertFrom {
        case .Meters:
            switch lengthUnitToConvertTo {
            case .Meters:
                return valueToConvert
            case .Kilometers:
                return valueToConvert / 1000
            case .Feet:
                return valueToConvert * 3.28084
            case .Miles:
                return valueToConvert * 0.000621371
            case .Yards:
                return valueToConvert * 1.09361
            }
        case .Kilometers:
            switch lengthUnitToConvertTo {
            case .Meters:
                return valueToConvert * 1000
            case .Kilometers:
                return valueToConvert
            case .Feet:
                return valueToConvert * 3280.84
            case .Miles:
                return valueToConvert * 0.621371
            case .Yards:
                return valueToConvert * 1093.61
            }
        case .Feet:
            switch lengthUnitToConvertTo {
            case .Meters:
                return valueToConvert / 3.28084
            case .Kilometers:
                return valueToConvert / 3280.84
            case .Feet:
                return valueToConvert
            case .Miles:
                return valueToConvert * 0.000189394
            case .Yards:
                return valueToConvert / 3
            }
        case .Yards:
            switch lengthUnitToConvertTo {
            case .Meters:
                return valueToConvert / 1.09361
            case .Kilometers:
                return valueToConvert / 1093.61
            case .Feet:
                return valueToConvert * 3
            case .Miles:
                return valueToConvert * 0.000568182
            case .Yards:
                return valueToConvert
            }
        case .Miles:
            switch lengthUnitToConvertTo {
            case .Meters:
                return valueToConvert * 1609.34
            case .Kilometers:
                return valueToConvert * 1.60934
            case .Feet:
                return valueToConvert * 5280
            case .Miles:
                return valueToConvert
            case .Yards:
                return valueToConvert * 1760
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Conversion Type") {
                    Picker("Units", selection: $conversionUnitType) {
                        ForEach(ConversionTypes.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Converion Units Selection"){
                    HStack {
                        VStack{
                            Section("From") {
                                switch conversionUnitType {
                                case .Temperature:
                                    Picker("Select", selection: $temperatureUnitToConvertFrom){
                                        ForEach(TemperatureUnit.allCases, id: \.self) {
                                            Text($0.rawValue)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                case .Length:
                                    Picker("Select", selection: $lengthUnitToConvertFrom){
                                        ForEach(LengthUnit.allCases, id: \.self) {
                                            Text($0.rawValue)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                }
                                
                                //4454 -- 4455
                            }
                        }
                        VStack{
                            Section("To") {
                                switch conversionUnitType {
                                case .Temperature:
                                    Picker("Select", selection: $temperatureUnitToConvertTo){
                                        ForEach(TemperatureUnit.allCases, id: \.self) {
                                            Text($0.rawValue)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                case .Length:
                                    Picker("Select", selection: $lengthUnitToConvertTo){
                                        ForEach(LengthUnit.allCases, id: \.self) {
                                            Text($0.rawValue)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                }
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
