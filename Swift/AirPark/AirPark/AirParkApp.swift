import SwiftUI

//struct ContentView: View {
//  @State private var isConnected = false
//  //@State private var homeLocation
//  @State private var homed = false
//  var body: some View {
//    ZStack {
//      BackgroundView(isConnected: $isConnected)
//      VStack {
//        ConnectedView(isConnected: $isConnected, homed: $homed)
//        Spacer()
//        MainView()
//      }
//    }
//  }
//}

struct ConnectedView: View{
  @Binding var isConnected: Bool
  @Binding var homed: Bool
  var body: some View{
    VStack{
      if(!isConnected && !homed){
        Circle()
          .fill(.gray)
          .frame(width: 200, height: 200)
          .overlay(){
            Image(systemName: "wifi")
              .scaleEffect(8)
          }
          .padding(.top)
        Spacer()
      }
      else if(isConnected && !homed){
        Circle()
          .strokeBorder(Color.pink, lineWidth: 8)
          .background(Circle().foregroundColor(Color.gray))
          .frame(width: 200, height: 200)
          .overlay(){
            Image(systemName: "arrow.up.right")
              .scaleEffect(8)
          }
          .padding(.top)
        Spacer()
      }else{
        Circle()
          .strokeBorder(Color.green, lineWidth: 8)
          .background(Circle().foregroundColor(Color.gray))
          .frame(width: 200, height: 200)
          .overlay(){
            Image(systemName: "checkmark")
              .scaleEffect(8)
          }
          .padding(.top)
        Spacer()
      }
    }
  }
}

struct MainView: View{
  var body: some View{
    ZStack {
      VStack{
        RoundedRectangle(cornerRadius: 20)
          .frame(width: 360, height: 530)
          .padding(.top)
          .foregroundColor(.gray)
      }
      RoundedRectangle(cornerRadius: 10)
        .frame(width: 100, height: 175)
        .foregroundColor(.green)
    }
  }
}

struct BackgroundView: View {
  @Binding var isConnected: Bool
  var body: some View {
    VStack{
      Button(action: {
        isConnected.toggle()
        print(isConnected)
      }){
        HStack{
          if(isConnected){
            Image(systemName: "house.circle")
              .scaleEffect(2)
              .foregroundColor(.gray)
          }else{
            Image(systemName: "house.circle")
              .scaleEffect(2)
              .foregroundColor(.black)
          }
          Spacer()
        }
      }
      .padding()
      Spacer()
    }
  }
}

