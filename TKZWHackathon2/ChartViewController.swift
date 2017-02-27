//
//  ChartViewController.swift
//  TKZWHackathon2
//
//  Created by 白田光 on 2017/02/27.
//  Copyright © 2017年 白田光. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    @IBOutlet weak var myChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(y: unitsSold)
        // Do any additional setup after loading the view.
    }
    
    func setChart(y: [Double]) {
        // プロットデータ(y軸)を保持する配列
        var dataEntries = [BarChartDataEntry]()
        
        for (i, val) in y.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(i), y: val) // X軸データは、0,1,2,...
            dataEntries.append(dataEntry)
        }
        // グラフをUIViewにセット
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        myChartView.data = BarChartData(dataSet: chartDataSet)
        
        // X軸のラベルを設定
        let xaxis = XAxis()
        xaxis.valueFormatter = BarChartFormatter()
        myChartView.xAxis.valueFormatter = xaxis.valueFormatter
        
        // x軸のラベルをボトムに表示
        myChartView.xAxis.labelPosition = .bottom
        // グラフの色
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        // グラフの背景色
        myChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        // グラフの棒をニョキッとアニメーションさせる
        myChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // 横に赤いボーダーラインを描く
        let ll = ChartLimitLine(limit: 10.0, label: "Target")
        myChartView.rightAxis.addLimitLine(ll)
        // グラフのタイトル
        myChartView.chartDescription?.text = "Cool Graph!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

public class BarChartFormatter: NSObject, IAxisValueFormatter{
    // x軸のラベル
    var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    // デリゲート。TableViewのcellForRowAtで、indexで渡されたセルをレンダリングするのに似てる。
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        // 0 -> Jan, 1 -> Feb...
        return months[Int(value)]
    }
}
