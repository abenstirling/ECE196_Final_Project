//
//  ContentView.swift
//  Blinkytooth
//
//  Created by Ben Stirling on 2/14/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var led: BlinkyModel = BlinkyModel()
    
    var body: some View {
        VStack {
            if !led.loaded {
                ProgressView()
                
                Text(led.connected ? "Loading..." : "Searching...")
            } else {
                List {
                    Toggle("LED", isOn: $led.ledState)
                        .onChange(of: led.ledState) { newValue in
                            led.write(value: newValue)
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
