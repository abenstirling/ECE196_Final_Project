//
//  CalibrationHelperView.swift
//  AirPark
//
//  Created by Jad on 3/11/23.
//

import SwiftUI

struct CalibrationHelperView: View{
  @Environment(\.dismiss) var dismiss
  @Binding var offset: Double?

  var body: some View{
    VStack{
      TextField("Distance From Wall (ft.): ", value: $offset, format: .number)
        .padding()
        .background(Color.gray.opacity(0.3).cornerRadius(10))
        .font(.headline)
      Button(action: {
          dismiss()
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

struct CalibrationHelper_Preiews: PreviewProvider {
  @State static var defOffset: Double? = 0

  static var previews: some View {
      CalibrationHelperView(offset: $defOffset)
    }
}
