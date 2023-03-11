//
//  ContentView.swift
//  AirPark
//
//  Created by User on 2/14/23.
//

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
          Button(){
            HapticManager.instance.notification(type: .error)
          }label:{
            Image(systemName: "exclamationmark.octagon")
          }
        }
        if let double = distance.distance {
          let value: Double = Double(double)!
          Spacer()
          if let offset{
            let circValue: Double = distance.calcCircleValue(offset: offset)
            if circValue > 0.0{
              Circle()
                .stroke(style: StrokeStyle(lineWidth: 8))
                .frame(width: 75 * max(0, value), height: 75 * max(0, value))
                .animation(.spring(), value: value)
            }else if circValue == 0.0{//circValue/12 < 6.0{
              Circle()
                .stroke(style: StrokeStyle(lineWidth: 8))
                .frame(width: 75 * max(0, value), height: 75 * max(0, value))
                .animation(.spring(), value: value)
                .foregroundColor(Color.green)
            }else{
              Circle()
                .stroke(style: StrokeStyle(lineWidth: 8))
                .frame(width: 75 * max(0, value), height: 75 * max(0, value))
                .animation(.spring(), value: value)
                .foregroundColor(Color.red)
                .onChange(of: offset) { newValue in if circValue < 0 {
                  HapticManager.instance.notification(type: .error)}}
            }
          }else{
            Circle()
              .stroke(style: StrokeStyle(lineWidth: 8))
              .frame(width: 75 * max(0, value), height: 75 * max(0, value))
              .animation(.spring(), value: value)
          }
          Spacer()
          Text("\(value * 3.281, specifier: "%.2f") ft.")
            .font(.headline)
          
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
