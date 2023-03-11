//
//  DistanceModel.swift
//  DistanceModel
//
//  Created by Jad Ariss on 3/7/23.
//

import Foundation
import CoreBluetooth
import SwiftUI

class DistanceModel: NSObject, ObservableObject, CBPeripheralDelegate, CBCentralManagerDelegate {
  
  //
  var centralManager: CBCentralManager!
  var peripheral: CBPeripheral?
  
  // UUID for the service and characteristic, repsectively
  let SERVICE_UUID = CBUUID(string: "4fafc201-1fb5-459e-8fcc-c5c9c331914b")
  let CHARACTERISTIC_UUID = CBUUID(string: "beb5483e-36e1-4688-b7f5-ea07361b26a8")
  
  var characteristic: CBCharacteristic?
  
  // These inform the UI what state the bluetooth is in
  @Published var connected: Bool = false
  @Published var loaded: Bool = false
  
  @Published var distance: String = "0"
  
  override init() {
    super.init()
    centralManager = CBCentralManager(delegate: self, queue: nil)
  }
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .poweredOff:
      print("Is Powered Off.")
    case .poweredOn:
      print("Is Powered On.")
      startScanning()
    case .unsupported:
      print("Is Unsupported.")
    case .unauthorized:
      print("Is Unauthorized.")
    case .unknown:
      print("Unknown")
    case .resetting:
      print("Resetting")
    @unknown default:
      print("Error")
    }
  }
  
  func startScanning() {
    centralManager.scanForPeripherals(withServices: [SERVICE_UUID])
  }
  
  func stopScanning() {
    centralManager.stopScan()
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    
    self.peripheral = peripheral
    centralManager.connect(self.peripheral!)
  }
  
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    
    self.peripheral!.delegate = self
    self.peripheral!.discoverServices([SERVICE_UUID])
    
    stopScanning()
    
    withAnimation {
      connected = true
    }
  }
  
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    guard let services = peripheral.services else { return }
    
    for service in services {
      peripheral.discoverCharacteristics(nil, for: service)
    }
  }
  
  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    
    guard let characteristics = service.characteristics else {return}
    
    for characteristic in characteristics {
      if characteristic.uuid == CHARACTERISTIC_UUID {
        self.characteristic = characteristic
        self.loaded = true
        DispatchQueue.global().async {
          self.updatePeriodic()
        }
      }
      
    }
  }
  
  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    let distance = characteristic.value!
    let distanceString = String(decoding: distance, as: UTF8.self)
    DispatchQueue.main.async {
      self.distance = distanceString
    }
    print("updated distance")
  }
  
  private func updatePeriodic() {
    while connected {
      Thread.sleep(forTimeInterval: 0.75)
      
      self.peripheral?.readValue(for: characteristic!)
    }
  }
  
  func calcCircleValue(offset: Double) -> Double{
    return (Double(distance)! * 3.281) - offset
  }
  
}
