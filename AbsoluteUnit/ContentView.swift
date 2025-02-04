//
//  ContentView.swift
//  AbsoluteUnit
//
//  Created by Kiran Shrestha on 2/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var valueToConvert : String = "0.0"
    @State private var unitToConvertFrom = "Fahrenheit"
    @State private var unitToConvertTo = "ZZZ"
    @State private var conversionUnitType = "Temperature"
    @FocusState private var isStartingValueFocused: Bool
    
    var convertedVal : Double {
        return 0.0
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
                                    ForEach(["Fahrenheit", "Celsius", "Kelvin"], id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.wheel)
                                //4454 -- 4455
                            }
                        }
                        VStack{
                            Section("To") {
                                Picker("Select", selection: $unitToConvertFrom){
                                    ForEach(["Fahrenheit", "Celsius", "Kelvin"], id: \.self) {
                                        Text($0)
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
