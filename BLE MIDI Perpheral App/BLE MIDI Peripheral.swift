//
//  BLE MIDI Peripheral.swift
//  BLE MIDI Perpheral App
//
//  Created by Thomas Büchi on 09-08-20.
//  Copyright © 2020 Thomas Büchi Sagredo. All rights reserved.
//

import Foundation
import SwiftUI
import CoreBluetooth

class BLEMIDIPeripheral: NSObject, ObservableObject, CBPeripheralManagerDelegate {
    
    private var peripheralManager : CBPeripheralManager!
    
    private var currentCentral: CBCentral?
    private var currentService: CBMutableService?
    
    private let serviceCBUUID:CBUUID = CBUUID(string: "03B80E5A-EDE8-4B33-A751-6CE34EC4C700")
    private let characteristicCBUUID:CBUUID = CBUUID(string: "7772E5DB-3868-4112-A1A9-F2669D106BF3")
    
    //We assign a name for the peripheral
    private let name:String = "BLEMIDIPeripheral"
    @Published var BLStatus: String = "Initializing"
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        //We review the current state of bluetooth and proceed accordinlgly
        switch peripheral.state {
            case .unknown:
                BLStatus = "Bluetooth Device is unknown"
            case .unsupported:
                BLStatus = "Bluetooth is unsopported"
            case .unauthorized:
                BLStatus = "Bluetooth is unauthorized"
            case .resetting:
                BLStatus = "Bluetooth is resetting"
            case .poweredOff:
                BLStatus = "Bluetooth is powered off"
            case .poweredOn:
                BLStatus = "Bluetooth is powered on"
                startService()
            @unknown default:
                print("Unknown State")
                BLStatus = "Unkown error"
        }
    }
    
}
