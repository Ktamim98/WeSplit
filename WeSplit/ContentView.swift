//
//  ContentView.swift
//  WeSplit
//
//  Created by Tamim Khan on 10/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFoused: Bool
    
   let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var total: Double{
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    
    var totalPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerperson = grandTotal / peopleCount
        
        return amountPerperson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFoused)
                    
                    Picker("number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("how much tip do you want to give?")
                }
                
                Section{
                    Text(total, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .black) 
                } header: {
                    Text("Total ammount")
                }
                
                
                
                Section{
                    Text(totalPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        amountIsFoused = false
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
