//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Glenn Gijsberts on 15/01/2023.
//

import SwiftUI

struct ContentView: View {    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Select your cupcakes").foregroundColor(.white)) {
                    Picker("Select your cake type", selection: $order.details.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes \(order.details.quantity)", value: $order.details.quantity, in: 3...20)
                        .accentColor(.orange)
                }
                
                Section(header: Text("Select extra's").foregroundColor(.white)) {
                    Toggle("Any special requests?", isOn: $order.details.specialRequestEnabled)
                    
                    if order.details.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.details.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.details.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AdressView(order: order)
                    } label: {
                        Text("Fill in your delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
            .scrollContentBackground(.hidden)
            .background(Color.black)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
