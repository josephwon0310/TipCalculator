//
//  ContentView.swift
//  TipCalculator
//
//  Created by Joseph Won on 1/20/20.
//  Copyright © 2020 Joseph Won. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalInput: Double? = 10.0
    @State private var selectedTip = 0
    
    private let tipPer = [0.15, 0.2, 0.25]
    
    private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.isLenient = true
        f.numberStyle = .currency
        return f
    }()
    
    private var percentageFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .percent
        return f
    }()
    
    private var tipAmount: Double {
        let total = totalInput ?? 0
        let tipPercent = tipPer[selectedTip]
        return total * tipPercent
    }
    
    private var totalAmount: Double {
        let total = totalInput ?? 0
        let tip = tipAmount
        return total + tip
    }
    
    private var formattedTipAmount: String {
        currencyFormatter.string(from: NSNumber(value: tipAmount)) ?? "Error"
    }
    
    private var formattedTotalAmount: String {
        currencyFormatter.string(from: NSNumber(value: totalAmount)) ?? "Error"
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("Total", value: $totalInput, formatter: currencyFormatter)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                
                tipPicker
                Divider()
                HStack {
                    Spacer()
                    Text("Tip amount: ")
                    Text(formattedTipAmount)
                    Spacer()
                }
                HStack{
                    Spacer()
                    Text("Total amount: ")
                    Text(formattedTotalAmount)
                    Spacer()
                }
                Spacer()
            }
            .background(Color(white: 0.99, opacity:0.6))
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle(Text("Tip Calculator"))
        }
    }
    
    private var tipPicker: some View {
        
        Picker(selection: $selectedTip, label: Text("Select Tip amount")) {
            ForEach(0..<tipPer.count) { index in
                Text(self.formatPercent(self.tipPer[index])).tag(index)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
    
    
    private func formatPercent(_ p: Double) -> String {
           percentageFormatter.string(from: NSNumber(value: p)) ?? "Error"
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
