//
//  ViewController.swift
//  MyStopWatch
//
//  Created by user22 on 2017/9/25.
//  Copyright © 2017年 Brad Big Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var labelHH: UILabel!

    @IBOutlet weak var labelMM: UILabel!
    
    @IBOutlet weak var labelSS: UILabel!
    
    @IBOutlet weak var labelHS: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnRight: UIButton!
    
    @IBOutlet weak var btnLeft: UIButton!
    
    private var isRunning = false
    private var timer:Timer?
    
    private var hs = 0, ss = 0, mm = 0, hh = 0
    
    private var laps:[String] = []
    
    
    @IBAction func doRight(_ sender: Any) {
        isRunning = !isRunning
        changeMode()
    }
    
    @IBAction func doLeft(_ sender: Any) {
        if isRunning {
            // Lap
            doLap()
        }else{
            // Reset
            doReset()
        }
    }
    
    private func changeMode(){
        if isRunning {
            btnRight.setTitle("Stop", for: .normal)
            btnLeft.setTitle("Lap", for: .normal)
            doStart()
        }else{
            btnRight.setTitle("Start", for: .normal)
            btnLeft.setTitle("Reset", for: .normal)
            doStop()
        }
    }
    
    private func doStart(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){
            _ in
            // 累加時間來做計時工作
            self.countJob()
        }
    }
    
    private func doStop(){
        if let _ = timer {
            timer?.invalidate()
        }
    }
    
    private func countJob() {
        hs += 1
        if hs == 100 {
            hs = 0
            ss += 1
            if ss == 60 {
                ss = 0
                mm += 1
                if mm == 60 {
                    mm = 0
                    hh += 1
                }
            }
        }
        showLabel()
    }
    
    private func showLabel(){
        labelHS.text = String(hs)
        labelSS.text = String(ss)
        labelMM.text = String(mm)
        labelHH.text = String(hh)
    }
    
    private func doLap(){
//        laps += ["\(hh):\(mm):\(ss).\(hs)"]
        laps.append("\(hh):\(mm):\(ss).\(hs)")
        
        //laps.insert("\(hh):\(mm):\(ss).\(hs)", at: 0)
        tableView.reloadData()
        
        // 跳過去
        let ii = IndexPath(item: laps.count-1, section: 0)
        tableView.scrollToRow(at: ii, at: .top, animated: true)
        
        
    }
    
    private func doReset() {
        hs = 0; ss = 0; mm = 0; hh = 0
        showLabel()
        
        // 清除陣列, 清除 tableview
        laps = []
        tableView.reloadData()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = laps[indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeMode()
        doReset()
    }
}

