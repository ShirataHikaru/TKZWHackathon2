//
//  ChartViewController.swift
//  TKZWHackathon2
//
//  Created by 白田光 on 2017/02/27.
//  Copyright © 2017年 白田光. All rights reserved.
//

import UIKit
import Charts
import RealmSwift


class ChartViewController: UIViewController {

    @IBOutlet weak var myChartView: BarChartView!
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dailyReports = realm.objects(Daily.self)
        let unitsSold:Array<Double> = dailyReports.map { (daily) in Double(daily.evening - daily.morning) }
        
//       unitsSold = [10.0,-10.0,20.0,30.0,-15.0,15.0]
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
        let ll = ChartLimitLine(limit: 0.0, label: "Target")
        myChartView.rightAxis.addLimitLine(ll)
        // グラフのタイトル
        myChartView.chartDescription?.text = "あなたの頑張り度"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

public class BarChartFormatter: NSObject, IAxisValueFormatter{
    let realm = try! Realm()
    // x軸のラベル
    var HorizontalValues:[String]! = []
    
    func createHorizon(){
        let dailyReports = realm.objects(Daily.self)
        let formatter = DateFormatter()
        for reports in dailyReports {
            self.HorizontalValues.append(formatter.string(from: reports.createdAt))
        }
    }
    
    
    // デリゲート。TableViewのcellForRowAtで、indexで渡されたセルをレンダリングするのに似てる。
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        // 0 -> Jan, 1 -> Feb...
        createHorizon()
        return HorizontalValues[Int(value)]
    }
}
