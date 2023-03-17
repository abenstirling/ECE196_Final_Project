//
//  ContentView.swift
//  AirPark
//
//  Created by User on 2/14/23.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
  @StateObject var distance: DistanceModel = DistanceModel()
  @AppStorage("offset") var offset: Double?
  @State private var isCalibrated = false
  
  var body: some View {
    VStack {
      if !distance.loaded {
        ProgressView()
        
        Text(distance.connected ? "Loading..." : "Searching...")
      } else {
        HStack {
          Button(){
            isCalibrated.toggle()
          }label: {
            Image(systemName: "car.circle.fill")
          }
          .font(.system(size: 60))
          .fullScreenCover(isPresented: $isCalibrated) {
            CalibrationHelperView(offset: $offset)
          }
          .padding(.top)
        }
        if let double = distance.distance {
          let value: Double = Double(double)!
          Spacer()
          if let offset{
            let circValue: Double = distance.calcCircleValue(offset: offset)
            
            Circle()
              .stroke(style: StrokeStyle(lineWidth: 8))
              .frame(width: 75 * max(0, value), height: 75 * max(0, value))
              .foregroundColor(circValue >= 1 ? .white : circValue < 1 && circValue >= 0 ? .green : .red )
              .animation(.spring(), value: value)
              .onChange(of: circValue) { newValue in if circValue < 1 && circValue > 0 {
                HapticManager.instance.notification(type: .error)
                AudioServicesPlayAlertSound(1322)
              } else if circValue < 0{
                HapticManager.instance.notification(type: .warning)
                AudioServicesPlayAlertSound(1304)
              }}
            Spacer()
                        
            Group {
              if circValue < 0 {
                Text("REVERSE!")
                  .font(.largeTitle)
                  .bold()
              }
            }
            .animation(.spring(), value: circValue)
            
            Text("\(distance.calcCircleValue(offset: offset), specifier: "%.2f") ft.")
              .font(.system(size: circValue >= 0 ? 24 : 72))
              .animation(.spring(), value: circValue)
          }else{
            Circle()
              .stroke(style: StrokeStyle(lineWidth: 8))
              .frame(width: 75 * max(0, value), height: 75 * max(0, value))
              .animation(.spring(), value: value)
            Spacer()
            Text("\(value * 3.281, specifier: "%.2f") ft.")
              .font(.headline)
          }
        } else {
          Text("Waiting for data...")
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
