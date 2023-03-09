//
//  ContentView.swift
//  AirPark
//
//  Created by User on 2/14/23.
//

import SwiftUI

struct ContentView: View {
  //@StateObject var led: BlinkyModel = BlinkyModel()
 @StateObject var distance: DistanceModel = DistanceModel()
  var body: some View {
    VStack {
      if !distance.loaded {
        ProgressView()
        
        Text(distance.connected ? "Loading..." : "Searching...")
      } else {
        if let double = distance.distance {
          let value: Double = Double(double)!
          
          Circle()
            .stroke(style: StrokeStyle(lineWidth: 8))
            .frame(width: 75 * value, height: 75 * value)
            .animation(.spring(), value: value)
          
        } else {
          Text("Waiting for data...")
        }
      }
    }
  }
}
//
//struct ContentView: View {
//  @State private var isConnected = false
//  //@State private var homeLocation
//  @State private var isHomed = false
//  var body: some View {
//    ZStack {
//      BackgroundView(isConnected: $isConnected)
//      VStack {
//        ConnectedView(isConnected: $isConnected, isHomed: $isHomed)
//        Spacer()
//        MainView()
//      }
//    }
//  }
//}
//
//struct ConnectedView: View{
//  @Binding var isConnected: Bool
//  @Binding var isHomed: Bool
//  var body: some View{
//    VStack{
//      if(!isConnected && !isHomed){
//        Circle()
//          .strokeBorder(Color.black, lineWidth: 8)
//          .background(Circle().foregroundColor(Color.gray))
//          .frame(width: 200, height: 200)
//          .overlay(){
//            Image(systemName: "wifi")
//              .font(.system(size: 120, design: .rounded))
//
//          }
//          .padding(.top)
//        Spacer()
//      }
//      else if(isConnected && !isHomed){
//        Circle()
//          .strokeBorder(Color.pink, lineWidth: 8)
//          .background(Circle().foregroundColor(Color.gray))
//          .frame(width: 200, height: 200)
//          .overlay(){
//            Image(systemName: "arrow.up.right")
//              .font(.system(size: 120, weight: .semibold))
//          }
//          .padding(.top)
//        Spacer()
//      }else{
//        Circle()
//          .strokeBorder(Color.green, lineWidth: 8)
//          .background(Circle().foregroundColor(Color.gray))
//          .frame(width: 200, height: 200)
//          .overlay(){
//            Image(systemName: "checkmark")
//              .font(.system(size: 120, weight: .semibold))
//              .foregroundColor(Color.green)
//          }
//          .padding(.top)
//        Spacer()
//      }
//    }
//  }
//}
//
//struct MainView: View{
//  var body: some View{
//    ZStack {
//      VStack{
//        RoundedRectangle(cornerRadius: 20)
//          .frame(width: 360, height: 530)
//          .padding(.top)
//          .foregroundColor(.gray)
//      }
//      RoundedRectangle(cornerRadius: 10)
//        .frame(width: 100, height: 175)
//        .foregroundColor(.green)
//    }
//  }
//}
//
//struct BackgroundView: View {
//  @Binding var isConnected: Bool
//  var body: some View {
//    VStack{
//      Button(action: {
//        isConnected.toggle()
//        print(isConnected)
//      }){
//        HStack{
//          if(isConnected){
//            Image(systemName: "house.circle")
//              .font(.system(size: 35, weight: .semibold))              .foregroundColor(.gray)
//          }else{
//            Image(systemName: "house.circle")
//              .font(.system(size: 35, weight: .semibold))
//              .foregroundColor(.black)
//          }
//          Spacer()
//        }
//      }
//      .padding()
//      Spacer()
//    }
//  }
//}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
