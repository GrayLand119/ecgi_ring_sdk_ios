//
//  SDKDemoPublicApp.swift
//  SDKDemoPublic
//
//  Created by GuilinLan on 2024/9/12.
//

import SwiftUI
import ECGSDK

@main
struct SDKDemoPublicApp: App {
    init() {
//        let version = ECG
//        let sdk = SMEcgSdk.shared()
//        debugPrint(String.init(format: "%.2f", 123.45678))
//        print("SDK Version: ", SMEcgSdk.version())
//        print(sdk.sdkTest(10))
//        
//        let path=Bundle.main.path(forResource: "normal100", ofType: "csv")!
//        let ecgData: Array = sdk.readCSV(path)
//        let result = sdk.realtimeProcess(ecgData, fs: 250.0)
//        let filtered = result[0] as! Array<Any>
//        let hr = result[1] as? Double ?? 0.0
//        
//        print(String.init(format: "filtered: %d, HR: %d", filtered.count, floor(hr)))
//        print("HR: ", result[1])
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
