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
    case Time = "Time"
    case Volume = "Volume"
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

// TODO: Time conversion: users choose seconds, minutes, hours, or days.
enum TimeUnit : String, CaseIterable {
    case Seconds = "Seconds"
    case Minutes = "Minutes"
    case Hours = "Hours"
    case Days = "Days"
}

// TODO: Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
enum VolumeUnit : String, CaseIterable {
    case MilliLiters = "MilliLiters"
    case Liters = "Liters"
    case Cups = "Cups"
    case Pints = "Pints"
    case Gallons = "Gallons"
}
struct ContentView: View {
    @State private var valueToConvert : String = "0.0"
    @State private var conversionUnitType : ConversionTypes = .Temperature
    
    @State private var temperatureUnitToConvertFrom = TemperatureUnit.Fahrenheit
    @State private var temperatureUnitToConvertTo = TemperatureUnit.Celsius
    @State private var lengthUnitToConvertFrom = LengthUnit.Meters
    @State private var lengthUnitToConvertTo = LengthUnit.Kilometers
    @State private var timeUnitToConvertFrom = TimeUnit.Seconds
    @State private var timeUnitToConvertTo = TimeUnit.Minutes
    @State private var volumeUnitToConvertFrom = VolumeUnit.MilliLiters
    @State private var volumeUnitToConvertTo = VolumeUnit.Liters
    
    @FocusState private var isStartingValueFocused: Bool
    
    var convertedVal : Double {
        if let valueToConvert = Double(valueToConvert) {
            switch conversionUnitType {
            case .Temperature:
                return convertTemperature(from: valueToConvert)
            case .Length:
                return convertLength(from: valueToConvert)
            case .Time:
                return convertTime(from: valueToConvert)
            case .Volume:
                return convertVolume(from: valueToConvert)
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
    
    func convertTime(from valueToConvert: Double) -> Double {
        switch timeUnitToConvertFrom {
        case .Seconds:
            switch timeUnitToConvertTo {
            case .Seconds:
                return valueToConvert
            case .Minutes:
                return valueToConvert / 60
            case .Hours:
                return valueToConvert / 3600
            case .Days:
                return valueToConvert / 86400
            }
        case .Minutes:
            switch timeUnitToConvertTo {
            case .Seconds:
                return valueToConvert * 60
            case .Minutes:
                return valueToConvert
            case .Hours:
                return valueToConvert / 60
            case .Days:
                return valueToConvert / 1440
            }
        case .Hours:
            switch timeUnitToConvertTo {
            case .Seconds:
                return valueToConvert * 3600
            case .Minutes:
                return valueToConvert * 60
            case .Hours:
                return valueToConvert
            case .Days:
                return valueToConvert / 24
            }
        case .Days:
            switch timeUnitToConvertTo {
            case .Seconds:
                return valueToConvert * 86400
            case .Minutes:
                return valueToConvert * 1440
            case .Hours:
                return valueToConvert * 24
            case .Days:
                return valueToConvert
            }
        }
    }
    
    func convertVolume(from valueToConvert : Double) -> Double {
        switch volumeUnitToConvertFrom {
        case .MilliLiters:
            switch volumeUnitToConvertTo {
            case .MilliLiters:
                return valueToConvert * 1
            case .Liters:
                return valueToConvert * 0.001
            case .Cups:
                return valueToConvert * 0.00236588
            case .Pints:
                return valueToConvert * 0.00473176
            case .Gallons:
                return valueToConvert * 0.00133681
            }
        case .Liters:
            switch volumeUnitToConvertTo {
            case .MilliLiters:
                return valueToConvert * 1000
            case .Liters:
                return valueToConvert * 1
            case .Cups:
                return valueToConvert * 23.6588
            case .Pints:
                return valueToConvert * 47.3176
            case .Gallons:
                return valueToConvert * 13.3681
            }
        case .Cups:
            switch volumeUnitToConvertTo {
            case .MilliLiters:
                return valueToConvert * 240
            case .Liters:
                return valueToConvert * 0.236588
            case .Cups:
                return valueToConvert * 1
            case .Pints:
                return valueToConvert * 2
            case .Gallons:
                return valueToConvert * 0.125
            }
        case .Pints:
            switch volumeUnitToConvertTo {
            case .MilliLiters:
                return valueToConvert * 480
            case .Liters:
                return valueToConvert * 0.473176
            case .Cups:
                return valueToConvert * 1.5
            case .Pints:
                return valueToConvert * 1
            case .Gallons:
                return valueToConvert * 0.0625
            }
        case .Gallons:
            switch volumeUnitToConvertTo {
            case .MilliLiters:
                return valueToConvert * 3785.41
            case .Liters:
                return valueToConvert * 13.3681
            case .Cups:
                return valueToConvert * 16
            case .Pints:
                return valueToConvert * 8
            case .Gallons:
                return valueToConvert * 1
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
                    .onChange(of: conversionUnitType, {
                        valueToConvert = "0.0"
                    })
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
                                    
                                case .Time:
                                    Picker("Select", selection: $timeUnitToConvertFrom) {
                                        ForEach(TimeUnit.allCases, id: \.self) {
                                            Text($0.rawValue)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                case .Volume:
                                    Picker("Select", selection: $volumeUnitToConvertFrom) {
                                        ForEach(VolumeUnit.allCases, id: \.self) {
                                            Text($0.rawValue)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                }
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
                                    
                                case .Time:
                                    Picker("Select", selection: $timeUnitToConvertTo){
                                        ForEach(TimeUnit.allCases, id: \.self) {
                                            Text($0.rawValue)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                case .Volume:
                                    Picker("Select", selection: $volumeUnitToConvertTo){
                                        ForEach(VolumeUnit.allCases, id: \.self) {
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
