//
//  ViewController.swift
//  SheAlbum
//
//  Created by Yida on 2020/8/8.
//  Copyright © 2020 Yida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var switchPlay: UISwitch!
    
    let dateFormatter = DateFormatter()
    
    let pictureArr = ["20010911","20020129","20020805","20030822","20040206","20041112","20051125","20070511","20080923","20100326","20121116"]
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //手離開後原點才移動到正確的位置
        slider.isContinuous = false
        //設定datePicker為中文
        datePicker.locale=Locale(identifier: "zh_TW")
        //圖片一開始為自動
//        switchChanged(switchPlay)
    }

    @IBAction func slideChanged(_ sender: UISlider) {
        
        var day:String = ""
        var month:String = ""
        let flag = sender.value        
        
        //設定sender.value為整數
        sender.value.round()
        
        let year = Int(sender.value).description
                
        if year == "2002" {
            //2002有兩張
            if flag >= 2001.5 && flag < 2002 {
                month = "01"
                day = "29"
            }else if flag >= 2002 && flag <= 2002.5 {
                month = "08"
                day = "05"
            }
            //2004有兩張
        }else if year == "2004" {
            if flag >= 2003.5 && flag < 2004{
                month = "02"
                day = "06"
            }else if flag >= 2004 && flag < 2004.5{
                month = "11"
                day = "12"
            }
        }else if year == "2001" {
            month = "09"
            day = "11"
        }else if year == "2003" {
            month = "08"
            day = "22"
        }else if year == "2005" {
            month = "11"
            day = "25"
        }else if year == "2007" {
            month = "05"
            day = "11"
        }else if year == "2008" {
            month = "09"
            day = "23"
        }else if year == "2010" {
            month = "03"
            day = "26"
        }else if year == "2012" {
            month = "11"
            day = "16"
        }else{
            
        }
        
        let dateComponents = DateComponents(calendar: Calendar.current, timeZone: nil, era: nil, year: Int(year), month: Int(month), day: Int(day))
        datePicker.date = dateComponents.date!
        //換圖
        let fileName = year + month + day
        //不是nil才換圖
        if UIImage(named: fileName) != nil {
            imageView.image = UIImage(named: fileName)
        }
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        
        let calendar = Calendar.current
        //component 回傳Int
        let year = calendar.component(.year, from: datePicker.date)
        let month = calendar.component(.month, from: datePicker.date)
        let day = calendar.component(.day, from: datePicker.date)
        
        let strYear = String(year)
        let strMonth = addZero(intValue: month)!
        let strDay = addZero(intValue: day)!
                
        slider.value = Float(year)
        let fileName = strYear + strMonth + strDay

        if UIImage(named: fileName) != nil {
            imageView.image = UIImage(named: fileName)
        }
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        var i = 0
                
        if sender.isOn {
            datePicker.isEnabled = false
            slider.isEnabled = false
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
                (timer) in
                
                if i == 10 {
                    i = 0
                }
                
                self.imageView.image = UIImage(named: self.pictureArr[i])
                
                //取得年
                let year = self.pictureArr[i].prefix(4)
                
                //取得月
                let monthStart = self.pictureArr[i].index(self.pictureArr[i].startIndex, offsetBy: 4)
                let monthEnd = self.pictureArr[i].index(monthStart, offsetBy: 2)
                let month = self.pictureArr[i][monthStart..<monthEnd]

                //取得日
                let dayStart = self.pictureArr[i].index(self.pictureArr[i].startIndex, offsetBy: 6)
                let dayEnd = self.pictureArr[i].index(dayStart, offsetBy: 2)
                let day = self.pictureArr[i][dayStart..<dayEnd]
                                                                
                let dateComponents = DateComponents(calendar: Calendar.current, timeZone: nil, era: nil, year: Int(year), month: Int(month), day: Int(day))
                self.datePicker.date = dateComponents.date!
                self.slider.value = Float(year)!
                
                i += 1
            })
        }else{
            timer?.invalidate()
            datePicker.isEnabled = true
            slider.isEnabled = true
        }
    }
}
//日期加0
func addZero(intValue:Int) -> String? {
    let num = NSNumber(value: intValue)
    let numberFormatter = NumberFormatter()
    numberFormatter.formatWidth = 2
    numberFormatter.paddingCharacter = "0"
    numberFormatter.paddingPosition = .beforePrefix
    return numberFormatter.string(from: num)
}
