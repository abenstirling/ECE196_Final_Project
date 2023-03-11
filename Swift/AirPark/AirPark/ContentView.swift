//
//  ContentView.swift
//  AirPark
//
//  Created by User on 2/14/23.
//

import SwiftUI
import AVFoundation

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
            if circValue >= 1{
              Circle()
                .stroke(style: StrokeStyle(lineWidth: 8))
                .frame(width: 75 * max(0, value), height: 75 * max(0, value))
                .animation(.spring(), value: value)
            }else if circValue < 1 && circValue >= 0{
              Circle()
                .stroke(style: StrokeStyle(lineWidth: 8))
                .frame(width: 75 * max(0, value), height: 75 * max(0, value))
                .animation(.spring(), value: value)
                .foregroundColor(Color.green)
                .onChange(of: circValue) { newValue in if circValue < 1 && circValue > 0 {
                  HapticManager.instance.notification(type: .error)
                  AudioServicesPlayAlertSound(1322)
                }}
            }else{
              Circle()
                .stroke(style: StrokeStyle(lineWidth: 8))
                .frame(width: 75 * max(0, value), height: 75 * max(0, value))
                .animation(.spring(), value: value)
                .foregroundColor(Color.red)
                .onChange(of: circValue) { newValue in if circValue < 0 {
                  HapticManager.instance.notification(type: .warning)
                  AudioServicesPlayAlertSound(1304)
                }}
            }
          }else{
            Circle()
              .stroke(style: StrokeStyle(lineWidth: 8))
              .frame(width: 75 * max(0, value), height: 75 * max(0, value))
              .animation(.spring(), value: value)
          }
          Spacer()
//          if isCalibrated {
//            Text("\(distance.calcCircleValue(offset: offset!), specifier: "%.2f") ft.")
//              .font(.headline)
//          }else{
            Text("\(value * 3.281, specifier: "%.2f") ft.")
              .font(.headline)
//          }
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
