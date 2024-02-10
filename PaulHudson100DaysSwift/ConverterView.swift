//
//  ConverterView.swift
//  PaulHudson100DaysSwift
//
//  Created by Константин on 10.02.2024.
//

import SwiftUI

struct ConverterView: View {
    @State private var inputValue: Double = 0
    
    @State private var inputUnit: Dimension = UnitDuration.seconds
    @State private var outputUnit: Dimension = UnitDuration.hours

    @State private var selectedUnits = 2
    
    @FocusState private var inputIsFocused: Bool
    
    let conversionTypes = ["Температура", "Длина", "Время", "Объем"]
    var units: [[Dimension]] {
        let tempUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
        let lengthUnits: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
        let timeUnits: [UnitDuration] = [.seconds, .minutes, .hours]
        let volumeUnits: [UnitVolume] = [.milliliters, .liters, .cups, .pints, .gallons]
        
        return [
            tempUnits,
            lengthUnits,
            timeUnits,
            volumeUnits,
        ]
    }
    
    let formatter: MeasurementFormatter
    init() {
        formatter = MeasurementFormatter()
        formatter.locale = .current
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
    
    var result: String {
        let outputMeasurement = Measurement(value: inputValue, unit: inputUnit).converted(to: outputUnit)
        
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                        TextField("Введите число", value: $inputValue, format: .number)
                            .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Я хочу перевести:")
                        .heavyRoundedFont()
                }
                
                Section {
                    unitPicker(title: "Convert from Unit", selection: $inputUnit)
                    unitPicker(title: "Convert to Unit", selection: $outputUnit)
                } header: {
                    Text("\(formatter.string(from: inputUnit)) в \(formatter.string(from: outputUnit))")
                        .fixedSize(horizontal: true, vertical: false)
                        .heavyRoundedFont()
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Результат:")
                        .heavyRoundedFont()
                }
                
                Picker("Conversion", selection: $selectedUnits) {
                    ForEach(0..<conversionTypes.count, id: \.self) {
                        Text(conversionTypes[$0])
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 170)
            }
            .navigationTitle("Конвертер")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }            .onChange(of: selectedUnits) { _, newValue in
                inputUnit = units[newValue][0]
                outputUnit = units[newValue][1]
            }
        }
    }
    
    private func unitPicker(title: String, selection: Binding<Dimension>) -> some View {
        Picker(title, selection: selection) {
            ForEach(units[selectedUnits], id: \.self) {
                Text(formatter.string(from: $0).capitalized)
            }
        }
        .pickerStyle(.segmented)
    }
}



struct HeavyRoundedFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .heavy, design: .rounded))
    }
}

extension View {
    func heavyRoundedFont() -> some View {
        self.modifier(HeavyRoundedFont())
    }
}



#Preview {
    ConverterView()
}
