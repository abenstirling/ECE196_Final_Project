//
//  ContentView.swift
//  AirPark
//
//  Created by User on 2/14/23.
//

import SwiftUI

struct CalibrationHelperView: View{
  @Environment(\.dismiss) var dismiss
  @Binding var offset: Double?
  @Binding var isOffset: Bool
  
  var body: some View{
    VStack{
      TextField("Distance From Wall (ft.): ", value: $offset, format: .number)
        .padding()
        .background(Color.gray.opacity(0.3).cornerRadius(10))
        .font(.headline)
      Button(action: {
          dismiss()
          isOffset = true
      }, label: {
          Text("Enter")
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue.cornerRadius(10))
          .foregroundColor(.white)
          .font(.headline)
      })
    }
  }
}

struct ContentView: View {
  @StateObject var distance: DistanceModel = DistanceModel()
  @AppStorage("offset") var offset: Double?
  @State private var isCalibrated = false
  @State private var isOffset = false
  
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
            CalibrationHelperView(offset: $offset, isOffset: $isOffset)
          }
          .padding(.top)
          Spacer()
        }
        if let double = distance.distance {
          let value: Double = Double(double)!
          Spacer()
          if isOffset{
            let circValue: Double = distance.calcCircleValue(offset: offset!)
            if circValue > 0.0{
              Circle()
                .stroke(style: StrokeStyle(lineWidth: 8))
                .frame(width: 75 * value, height: 75 * value)
                .animation(.spring(), value: value)
            }else if circValue == 0.0{
              Circle()
                .stroke(style: StrokeStyle(lineWidth: 8))
                .frame(width: 75 * value, height: 75 * value)
                .animation(.spring(), value: value)
                .foregroundColor(Color.green)
            }else{
              Circle()
                .stroke(style: StrokeStyle(lineWidth: 8))
                .frame(width: 75 * value, height: 75 * value)
                .animation(.spring(), value: value)
                .foregroundColor(Color.red)
            }
          }else{
            Circle()
              .stroke(style: StrokeStyle(lineWidth: 8))
              .frame(width: 75 * value, height: 75 * value)
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
