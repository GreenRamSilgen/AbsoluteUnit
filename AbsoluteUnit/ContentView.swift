//
//  ContentView.swift
//  AbsoluteUnit
//
//  Created by Kiran Shrestha on 2/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var valueToConvert = "User Input Value"
    @State private var unitToConvertFrom = "Fahrenheit"
    @State private var unitToConvertTo = "ZZZ"
    @State private var conversionUnitType = "Temperature"
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
                }
                Section("Converted Value") {
                    Text("Converted Val HERE")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
