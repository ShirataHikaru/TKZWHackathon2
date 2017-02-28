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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let dailies = realm.objects(Daily.self).filter("done == 1")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
            let day:Array<String> = dailies.map({ (daily) in formatter.string(from: daily.createdAt) })
            let dailyReports:Array<Double> = dailies.map { (daily) in Double(daily.evening - daily.morning)
        }
        
        setChart(x: day, y: dailyReports)
      
        // X軸のラベルを設定
        let xaxis = XAxis()
        xaxis.valueFormatter = BarChartFormatter()
        myChartView.xAxis.valueFormatter = xaxis.valueFormatter
        myChartView.xAxis.granularity = 1
        
        myChartView.chartDescription?.text = "あなたの相対頑張り度"
        myChartView.animate(yAxisDuration: 2.0)
        myChartView.pinchZoomEnabled = false
        myChartView.doubleTapToZoomEnabled = false
        myChartView.drawBarShadowEnabled = false
        // x軸のラベルをボトムに表示
        myChartView.xAxis.labelPosition = .bottom
        // グラフの背景色
        // myChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
    }
    
    func setChart(x: [String],y: [Double]) {
        
        myChartView.noDataText = "データがありません"
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<x.count {
           let dataEntry = BarChartDataEntry(x: Double(i), y: y[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(values: dataEntries, label: "モチベの推移")
        // グラフの色
        //chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]

        let chartData = BarChartData(dataSet: chartDataSet)
        myChartView.data = chartData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

public class BarChartFormatter: NSObject, IAxisValueFormatter{
    let realm = try! Realm()
    // x軸のラベル
    var HorizontalValues:[String]!
    
    func createHorizon(){
        let dailyReports = realm.objects(Daily.self).filter("done == 1")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        
        HorizontalValues = dailyReports.map({ (daily) in formatter.string(from: daily.createdAt) })
    }
    
    
    // デリゲート。TableViewのcellForRowAtで、indexで渡されたセルをレンダリングするのに似てる。
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        createHorizon()
        return HorizontalValues[Int(value)]
    }
}
