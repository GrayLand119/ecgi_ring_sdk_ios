//
//  ContentView.swift
//  SDKDemoPublic
//
//  Created by GuilinLan on 2024/9/12.
//

import ECGSDK
import SwiftUI

class ECGData: ObservableObject {
    @Published var data: [NSNumber] = Array(repeating: 0, count: 2500)

    func loadData() {
        let path = Bundle.main.path(forResource: "normal100", ofType: "csv")!
        let sdk = SMEcgSdk.shared()
        let ecgData: Array = sdk.readCSV(path)
        data = ecgData
    }
}

struct ContentView: View {
    @State var realtimeResult = "Realtime Result: None"
    @State var diagnoseResult = "Diagnose Result: None"

    @ObservedObject private var ecgData = ECGData()

    let sdk = SMEcgSdk.shared()
    init() {
        print("SDK Version:", SMEcgSdk.version())
        let API_KEY = "Lck01t612usETV8+dllv1ywzetzBt0cy3TXeKPqc7Wfz69T9LERsRcDMyumiviyP"
        sdk.register(withKey: API_KEY)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button("Load Local ECG Data") {
                ecgData.loadData()
            }

            ECGView(ecgData: ecgData).frame(height: 200)
            Button("Realtime Process") {
                let result: [Any] = sdk.realtimeProcess(ecgData.data, fs: 250.0)
                let filtered = result[0] as! [Double]
                let hr = result[1] as? Double ?? 0.0

                let desc = String.init(
                    format: "Realtime Result: %d, HR: %.0f", filtered.count,
                    floor(hr))
                print(desc)

                realtimeResult = desc
            }
            Text(realtimeResult)
            Button("Diagnose Process") {
                let diagnose = sdk.diagnose(ecgData.data, fs: 250.0)
                let filtered2 = diagnose[0] as? [Double] ?? []
                let hrInfo = diagnose[1] as? [Double] ?? []
                let rhythmInfo = diagnose[2] as? [Double] ?? []
                
                let labels = [
                    "正常", "房扑", "房颤", "室颤/室扑", "其他心律不齐", "噪声", "含有室上性早搏",
                    "含有室性早搏",
                ]
                // FIXME: ms 单位错误, 实际输出是秒
                print(
                    String.init(
                        format: "minHR:%.2f, meanHR:%.2f, maxHR: %.2f",
                        hrInfo[0], hrInfo[1], hrInfo[2]))
                print(
                    String.init(
                        format: "minRR:%.2fms, meanRR:%.2fms, maxRR: %.2fms",
                        hrInfo[3] * 1000, hrInfo[4] * 1000, hrInfo[5] * 1000))
                print(String.init(format: "PR间期:%.2fms", hrInfo[6] * 1000))
                print(String.init(format: "QRS波宽:%.2fms", hrInfo[7] * 1000))
                print(
                    String.init(
                        format: "SDNN:%.2f, RMSSD:%.2f", hrInfo[8], hrInfo[9]))
                print(
                    String.init(
                        format: "诊断结果:%@, 置信度:%.2f", labels[Int(rhythmInfo[0])],
                        rhythmInfo[1]))

                let fmt = """
                                    minHR:%.0f,meanHR:%.0f,maxHR:%.0f
                                    minRR:%.0fms,meanRR:%.0fms,maxRR: %.0fms
                                    PR间期:%.2fms
                                    QRS波宽:%.2fms
                                    SDNN:%.2f, RMSSD:%.2f
                                    诊断结果:%@, 置信度:%.2f
                                    室性早搏数:%.0f, 室上性早搏数:%.0f
                    """
                diagnoseResult = String.init(
                    format: fmt,
                    hrInfo[0], hrInfo[1], hrInfo[2],
                    hrInfo[3] * 1000, hrInfo[4] * 1000, hrInfo[5] * 1000,
                    hrInfo[6], hrInfo[7], hrInfo[8], hrInfo[9],
                    labels[Int(rhythmInfo[0])], rhythmInfo[1],
                    hrInfo[11], hrInfo[12])
            }
            Text(diagnoseResult)
        }
        .padding()

    }

    mutating func onLoadLocalECGData() {
        realtimeResult = "HR: 100"
    }
}

#Preview {
    ContentView()
}

struct ECGView: View {
    @ObservedObject var ecgData: ECGData
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let midY = size.height / 2.0
            let gain = size.height / 3.0

            let data = ecgData.data
            Path { path in
                for i in 0..<2500 {
                    let y = midY - data[i].doubleValue * gain
                    let x = size.width / 2500.0 * CGFloat(i)
                    if i == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }

            }
            .stroke(style: StrokeStyle(lineWidth: 1.0, lineCap: .butt))
            .fill(Color.black)
            .background(Color.white)
        }
    }
}
