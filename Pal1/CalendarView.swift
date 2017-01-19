//
//  CalendarView.swift
//  Pal1
//
//  Created by Julien Simmer  on 05/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class CalendarView: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var viewCal: UIView!
    
    @IBOutlet weak var dateButonView: UIView!
    
    var bigFrame:CGRect = CGRect()
    
    let buttonYear = UIButton()
    let buttonMonth = UIButton()
    let labelDate = UILabel()
    let line = UIView()
    
    var monthTraits:[UIView] = [UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView()]
    var monthLabel:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]
    
    var months:[String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var dayTraits:[UIView] = [UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView()]
    var dayLabel:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]
    
    var hourTraits:[UIView] = [UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView()]
    var hourLabel:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]
    
    var scale:String = "month"
    var yearSelect:Int = 2017
    var monthSelect:Int = 01
    var daySelect:Int = 01
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bigFrame = dateButonView.frame
        
        self.line.backgroundColor = UIColor.black
        self.line.frame = CGRect(x: 0, y: 75, width: self.viewCal.frame.width, height: 2)
        self.viewCal.addSubview(line)
        
        for i in 0...11{
            monthTraits[i].backgroundColor = UIColor.black
            monthTraits[i].frame = CGRect(x: i*100+25, y: 70, width: 1, height: 17)
            self.viewCal.addSubview(monthTraits[i])
            
            monthLabel[i].text = months[i]
            monthLabel[i].textColor = UIColor.black
            monthLabel[i].font = UIFont (name: "HelveticaNeue-Light", size: 10)
            monthLabel[i].frame = CGRect(x: 0, y: 0, width: 50, height: 20)
            monthLabel[i].center = CGPoint(x: i*100+25, y: 95)
            monthLabel[i].textAlignment = NSTextAlignment.center
            self.viewCal.addSubview(monthLabel[i])
        }
        
        
        
        labelDate.text = "2017"
        labelDate.textColor = UIColor.black
        labelDate.font = UIFont (name: "HelveticaNeue-Regular", size: 15)
        labelDate.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        labelDate.textAlignment = NSTextAlignment.center
        labelDate.center = CGPoint(x: bigFrame.width/2-25.0, y: bigFrame.height/2)
        
        
        
        self.dateButonView.addSubview(labelDate)
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doubleTap(_ sender: Any) {
        let ss = sender as! UIGestureRecognizer
        let xx = ss.location(in: viewCal).x
        
        
        
        if scale == "hour"{
            print(ss.location(in: view).x)
            print(scrollView.convert(hourTraits[5].frame, to: view).minX)
        }
        
        
         if scale == "day"{
            scale = "hour"
            
            var dayNum  = Int(abs(xx-25) / CGFloat(100))
            if dayNum == 31{dayNum = 30}
            daySelect = dayNum + 1
            
            labelDate.text = "\(daySelect)"
            labelDate.frame = CGRect(x: 10, y: 10, width: 50, height: 40)
            buttonYear.frame = CGRect(x: bigFrame.width/2+25.0, y: 10, width: 50, height: 40)
            buttonMonth.frame = CGRect(x: bigFrame.width/2-88.0, y: 10, width: 100, height: 40)
            buttonMonth.cornerRadius = 4
            buttonMonth.backgroundColor = UIColor.darkGray
            buttonMonth.setTitle("\(months[monthSelect])", for: UIControlState.normal)
            buttonMonth.addTarget(self, action: #selector(buttonActionMonth), for: UIControlEvents.touchUpInside)
            self.dateButonView.addSubview(buttonMonth)
            
            let tap = ss.location(in: view).x
            let mid:CGFloat = 1575
            let mid1 = mid - tap
            let positionTrait = scrollView.convert(dayTraits[dayNum].frame, to: view).minX
            let mid2 = 1575-(tap-positionTrait)
            
            self.scrollView.contentOffset = CGPoint(x: mid1, y: 0)
            
            let frameBound = scrollView.bounds
            
            for i in 0...30{
                dayTraits[i].alpha = 0
                dayLabel[i].alpha = 0
            }
            
            if(dayNum > 1){self.dayTraits[dayNum-2].frame = CGRect(x: mid2-200, y: 66, width: 1, height: 20)
                self.dayLabel[dayNum-2].center = CGPoint(x: mid2-200, y: 95)
                self.dayTraits[dayNum-2].alpha = 1
                self.dayLabel[dayNum-2].alpha = 1}
            if(dayNum > 0){self.dayTraits[dayNum-1].frame = CGRect(x: mid2-100, y: 66, width: 1, height: 20)
                self.dayLabel[dayNum-1].center = CGPoint(x: mid2-100, y: 95)
                self.dayTraits[dayNum-1].alpha = 1
                self.dayLabel[dayNum-1].alpha = 1}
            self.dayTraits[dayNum].frame = CGRect(x: mid2, y: 66, width: 1, height: 20)
            self.dayLabel[dayNum].center = CGPoint(x: mid2, y: 95)
            self.dayTraits[dayNum].alpha = 1
            self.dayLabel[dayNum].alpha = 1
            if(dayNum < 23){self.dayTraits[dayNum+1].frame = CGRect(x: mid2+100, y: 66, width: 1, height: 20)
                self.dayLabel[dayNum+1].center = CGPoint(x: mid2+100, y: 95)
                self.dayTraits[dayNum+1].alpha = 1
                self.dayLabel[dayNum+1].alpha = 1}
            if(dayNum < 24){self.dayTraits[dayNum+2].frame = CGRect(x: mid2+200, y: 66, width: 1, height: 20)
                self.dayLabel[dayNum+2].center = CGPoint(x: mid2+200, y: 95)
                self.dayTraits[dayNum+2].alpha = 1
                self.dayLabel[dayNum+2].alpha = 1}
            
            for i in 0...23{
                hourTraits[i].backgroundColor = UIColor.black
                if i < 14 && i > 8{
                    hourTraits[i].frame = CGRect(x: mid, y: 70, width: 1, height: 17)
                }else{
                    hourTraits[i].frame = CGRect(x: i*129+25, y: 70, width: 1, height: 17)
                }
                hourTraits[i].alpha = 0
                self.viewCal.addSubview(hourTraits[i])
                
                hourLabel[i].text = "\(i) H"
                hourLabel[i].textColor = UIColor.black
                hourLabel[i].font = UIFont (name: "HelveticaNeue-Light", size: 15)
                hourLabel[i].frame = CGRect(x: 0, y: 0, width: 50, height: 20)
                if i < 14 && i > 8{
                    hourLabel[i].center = CGPoint(x: mid, y: 95)
                }else{
                    hourLabel[i].center = CGPoint(x: i*129+25, y: 95)
                }
                hourLabel[i].textAlignment = NSTextAlignment.center
                hourLabel[i].alpha = 0
                self.viewCal.addSubview(hourLabel[i])
            }
            
            UIView.animate(withDuration: 0.8, animations: {
                    if(dayNum > 1){self.dayTraits[dayNum-2].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                        self.dayLabel[dayNum-2].center = CGPoint(x: frameBound.minX-20, y: 95)}
                    if(dayNum > 0){self.dayTraits[dayNum-1].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                        self.dayLabel[dayNum-1].center = CGPoint(x: frameBound.minX-20, y: 95)}
                    self.dayTraits[dayNum].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                    self.dayLabel[dayNum].center = CGPoint(x: frameBound.minX-20, y: 95)
                    if(dayNum < 23){self.dayTraits[dayNum+1].frame = CGRect(x: frameBound.maxX-20, y: 66, width: 1, height: 20)
                        self.dayLabel[dayNum+1].center = CGPoint(x: frameBound.maxX-20, y: 95)}
                    if(dayNum < 24){self.dayTraits[dayNum+2].frame = CGRect(x: frameBound.maxX-20, y: 66, width: 1, height: 20)
                        self.dayLabel[dayNum+2].center = CGPoint(x: frameBound.maxX-20, y: 95)}
                    for i in 0...30{
                        self.dayTraits[i].alpha = 0
                        self.dayLabel[i].alpha = 0
                    }
                    for i in 9...13{
                        self.hourTraits[i].frame = CGRect(x: i*129+25, y: 70, width: 1, height: 17)
                        self.hourLabel[i].center = CGPoint(x: i*129+25, y: 95)
                    }
                    for i in 0...23{
                        self.hourTraits[i].alpha = 1
                        self.hourLabel[i].alpha = 1
                    }
            })
        }
        
        
        
        
        
        
        
        
        
        
        
        if scale == "month"{
            scale = "day"
            var monthNum  = Int(abs(xx-25) / CGFloat(100))
            if monthNum == 12{monthNum = 11}
            monthSelect = monthNum
            let month:String = months[monthNum]
            labelDate.text = month
            
            labelDate.center = CGPoint(x: bigFrame.width/2-50.0, y: bigFrame.height/2)
            buttonYear.frame = CGRect(x: bigFrame.width/2, y: 10, width: 50, height: 40)
            buttonYear.cornerRadius = 4
            buttonYear.backgroundColor = UIColor.darkGray
            buttonYear.setTitle("2017", for: UIControlState.normal)
            buttonYear.addTarget(self, action: #selector(buttonActionYear), for: UIControlEvents.touchUpInside)
            self.dateButonView.addSubview(buttonYear)
            //lebel.text = month + " 2017"
            
            
            
            
            let frameBound = scrollView.bounds
            
            for i in 0...30{
                dayTraits[i].backgroundColor = UIColor.black
                if i < 12{
                    dayTraits[i].frame = CGRect(x: xx, y: 70, width: 1, height: 17)
                }else{
                    dayTraits[i].frame = CGRect(x: i*100+25, y: 70, width: 1, height: 17)
                }
                dayTraits[i].alpha = 0
                self.viewCal.addSubview(dayTraits[i])
                
                dayLabel[i].text = String(i+1)+" th"
                dayLabel[i].textColor = UIColor.black
                dayLabel[i].font = UIFont (name: "HelveticaNeue-Light", size: 15)
                dayLabel[i].frame = CGRect(x: 0, y: 0, width: 50, height: 20)
                if i < 12{
                    dayLabel[i].center = CGPoint(x: xx, y: 95)
                }else{
                    dayLabel[i].center = CGPoint(x: i*100+25, y: 95)
                }
                dayLabel[i].textAlignment = NSTextAlignment.center
                dayLabel[i].alpha = 0
                self.viewCal.addSubview(dayLabel[i])
            }
            
            //self.viewCal.frame = CGRect(x: 0, y: 15, width: 3150, height: 150)
            self.line.frame = CGRect(x: 0, y: 75, width: 3150, height: 2)
            //self.viewCal.layoutIfNeeded()
            
            for constraint in self.viewCal.constraints as [NSLayoutConstraint] {
                if constraint.identifier == "viewcalWidth" {
                    constraint.constant = 3150
                    UIView.animate(withDuration: 0.5, animations: {
                        self.view.layoutIfNeeded()
                    })
                }
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                if(monthNum > 1){self.monthTraits[monthNum-2].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                    self.monthLabel[monthNum-2].center = CGPoint(x: frameBound.minX-20, y: 95)}
                if(monthNum > 0){self.monthTraits[monthNum-1].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                    self.monthLabel[monthNum-1].center = CGPoint(x: frameBound.minX-20, y: 95)}
                self.monthTraits[monthNum].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                self.monthLabel[monthNum].center = CGPoint(x: frameBound.minX-20, y: 95)
                if(monthNum < 9){self.monthTraits[monthNum+1].frame = CGRect(x: frameBound.maxX-20, y: 66, width: 1, height: 20)
                    self.monthLabel[monthNum+1].center = CGPoint(x: frameBound.maxX-20, y: 95)}
                if(monthNum < 10){self.monthTraits[monthNum+2].frame = CGRect(x: frameBound.maxX-20, y: 66, width: 1, height: 20)
                    self.monthLabel[monthNum+2].center = CGPoint(x: frameBound.maxX-20, y: 95)}
                for i in 0...11{
                    self.monthTraits[i].alpha = 0
                    self.monthLabel[i].alpha = 0
                    self.dayTraits[i].frame = CGRect(x: i*100+25, y: 70, width: 1, height: 17)
                    self.dayLabel[i].center = CGPoint(x: i*100+25, y: 95)
                }
                for i in 0...30{
                    self.dayTraits[i].alpha = 1
                    self.dayLabel[i].alpha = 1
                }
                
            })
        }
        
        
        
        
        
    }
    
   
    
    func buttonActionMonth(sender: UIButton!) {
        print("retour aux jours")
        
    }
    
    
    func buttonActionYear(sender: UIButton!) {
        print("retour aux mois")
    }
    
}
