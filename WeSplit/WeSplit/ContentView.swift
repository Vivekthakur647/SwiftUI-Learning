//
//  ContentView.swift
//  WeSplit
//
//  Created by VIVEK THAKUR on 11/04/23.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var ammountIsFoucus : Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let ammountPerPerson = grandTotal / peopleCount
        return ammountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Ammount", value: $checkAmount , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($ammountIsFoucus)
                    
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages , id: \.self) {
                            Text($0 , format : .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave ?")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total per person ?")
                }
            }
            .navigationTitle("We Split")
            .toolbar {
                ToolbarItemGroup (placement: .keyboard) {
                    Spacer()
                    Button("DONE") {
                        ammountIsFoucus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
