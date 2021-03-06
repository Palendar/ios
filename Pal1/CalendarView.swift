//
//  CalendarView.swift
//  Pal1
//
//  Created by Julien Simmer  on 05/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class CalendarView: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var viewCal: UIView!
    
    @IBOutlet weak var dateButonView: UIView!
    
    @IBOutlet weak var infoNextView: UIView!
    
    @IBOutlet weak var infoPrevView: UIView!
    
    @IBOutlet weak var nextYearLabel: UILabel!
    
    @IBOutlet weak var prevYearLabel: UILabel!
    
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var eventStartLabel: UILabel!
    
    @IBOutlet weak var eventEndLabel: UILabel!
    
    let Constante:UserDefaults = UserDefaults.standard

    
    var greyLine:UIView = UIView()
    var blackLine:UIView = UIView()
    
    var bigFrame:CGRect = CGRect()
    
    let buttonYear = UIButton()
    let buttonMonth = UIButton()
    let labelDate = UILabel()
    let line = UIView()
    // let dispoLine = UIView()
    
    var monthTraits:[UIView] = [UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView()]
    var monthLabel:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]
    
    var months:[String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var dayWeek:[String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var dayTraits:[UIView] = [UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView()]
    var dayLabel:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]
    
    var hourTraits:[UIView] = [UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView()]
    var hourLabel:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]
    
    var scale:String = "day"
    var yearSelect:Int = 2017
    var monthSelect:Int = 01
    var daySelect:Int = 01
    
    var condNext:Int = 0
    var condNext2:Bool = false
    var condPrev:Int = 0
    var condPrev2:Bool = false
    
    var eventsStart:[String] = []
    var eventsEnd:[String] = []
    var eventText:[String] = []
    
    var premierEventX:CGFloat = -1
    
    var eventsViewsDay:[EventViewDay] = []
    var eventsViewsMonth:[EventViewMonth] = []
    var eventsViewsYear:[EventViewYear] = []
    
    var cicleDraw:[UIView] = []
    
    
    var tap = UITapGestureRecognizer()
    
    var newEventCircle = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        for i in self.cicleDraw{
            i.removeFromSuperview()
        }
        self.cicleDraw.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsStart = Constante.array(forKey: "dateStart") as! [String]
        eventsEnd = Constante.array(forKey: "dateEnd") as! [String]
        eventText = Constante.array(forKey: "descriptionEvent") as! [String]
        eventsStart.append("24-01-2017 13:30")
        eventsStart.append("25-01-2017 16:00")
        eventsEnd.append("24-01-2017 14:30")
        eventsEnd.append("25-01-2017 18:00")
        eventText.append("Sieste")
        eventText.append("Devoir maison")
        if Constante.bool(forKey: "comeFromAdd"){
            eventsStart.append(Constante.string(forKey: "dateStartAdd")!)
            eventsEnd.append(Constante.string(forKey: "dateEndAdd")!)
            eventText.append(Constante.string(forKey: "dateDescriptionAdd")!)
            Constante.set(false, forKey: "comeFromAdd")
        }
        
        
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let yearToday =  components.year!
        let monthToday = components.month!
        let dayToday = components.day!
        
        yearSelect = yearToday
        monthSelect = monthToday
        daySelect = dayToday
        
        infoNextView.alpha = 0
        infoPrevView.alpha = 0
        scrollView.delegate = self
        bigFrame = dateButonView.frame
        
        greyLine.backgroundColor = UIColor.lightGray
        blackLine.backgroundColor = UIColor.black
        greyLine.alpha = 0
        blackLine.alpha = 0
        
        
        self.line.backgroundColor = UIColor.black
        self.line.frame = CGRect(x: 0, y: 75, width: self.viewCal.frame.width, height: 2)
        self.viewCal.addSubview(line)
        
        /* Affiche sur la calendrier de groupe
        self.dispoLine.backgroundColor = UIColor.green
        self.dispoLine.frame = CGRect(x: 0, y: 70, width: self.viewCal.frame.width, height: 5)
        self.viewCal.addSubview(dispoLine)
        */
        
        
        for i in 0...30{
            dayTraits[i].backgroundColor = UIColor.black
            dayTraits[i].frame = CGRect(x: i*100+25, y: 70, width: 1, height: 19)
            self.viewCal.addSubview(dayTraits[i])
            dayLabel[i].text = textDayLabel(i: i)
            dayLabel[i].textColor = UIColor.black
            dayLabel[i].font = UIFont (name: "HelveticaNeue-Light", size: 15)
            dayLabel[i].frame = CGRect(x: 0, y: 0, width: 55, height: 20)
            dayLabel[i].center = CGPoint(x: i*100+25, y: 95)
            dayLabel[i].textAlignment = NSTextAlignment.center
            self.viewCal.addSubview(dayLabel[i])
        }
        
        
        for i in 0...11{
            monthTraits[i].backgroundColor = UIColor.black
            monthTraits[i].frame = CGRect(x: i*100+25, y: 70, width: 1, height: 17)
            monthTraits[i].alpha = 0
            self.viewCal.addSubview(monthTraits[i])
            
            monthLabel[i].text = months[i]
            monthLabel[i].textColor = UIColor.black
            monthLabel[i].font = UIFont(name: "HelveticaNeue-Light", size: 10)
            monthLabel[i].frame = CGRect(x: i*100+25, y: 85, width: 50, height: 20)
            monthLabel[i].textAlignment = NSTextAlignment.center
            monthLabel[i].alpha = 0
            self.viewCal.addSubview(monthLabel[i])
        }
        
        labelDate.textColor = UIColor.black
        labelDate.font = UIFont (name: "HelveticaNeue-Regular", size: 15)
        labelDate.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        labelDate.textAlignment = NSTextAlignment.center
        labelDate.text = months[monthSelect-1]
        labelDate.center = CGPoint(x: bigFrame.width/2-50.0, y: bigFrame.height/2+5)
        buttonYear.frame = CGRect(x: bigFrame.width/2, y: 10, width: 50, height: 40)
        buttonYear.cornerRadius = 4
        buttonYear.isEnabled = true
        buttonYear.alpha = 1
        buttonYear.backgroundColor = UIColor.darkGray
        buttonYear.setTitle("\(yearSelect)", for: UIControlState.normal)
        buttonYear.addTarget(self, action: #selector(buttonActionYear), for: UIControlEvents.touchUpInside)
        
        self.dateButonView.addSubview(buttonYear)
        self.dateButonView.addSubview(labelDate)
        self.view.addSubview(greyLine)
        self.view.addSubview(blackLine)
        
        self.scrollView.contentOffset = CGPoint(x: CGFloat(25 + (100 * (dayToday-1))) - view.frame.width/2, y: 0)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.eventViewTappedDay(recognizer:)))
        
        hideEventDescription()
        
        loadEvent()
        
        newEventCircle.backgroundColor = UIColor(red: 68, green: 68, blue: 68)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPress.minimumPressDuration = 0.3
        viewCal.addGestureRecognizer(longPress)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func eventViewTappedDay(recognizer: UIPanGestureRecognizer) {
        
        let vv = recognizer.view!.superview as! EventViewDay
        let dd = vv.labelEvent.text
        
        self.eventTitle.text = dd
        self.eventEndLabel.text = vv.endLabel
        self.eventStartLabel.text = vv.startLabel
        
        print(dd!)
    }
    
    func loadEvent(){
        for e in eventsViewsDay{
            e.removeFromSuperview()
        }
        for e in eventsViewsMonth{
            e.removeFromSuperview()
        }
        for e in eventsViewsYear{
            e.removeFromSuperview()
        }
        eventsViewsMonth.removeAll()
        eventsViewsDay.removeAll()
        eventsViewsYear.removeAll()
        if eventsStart.count != 0{
            for i in 0...eventsStart.count-1{
                afficherEvent(sD: eventsStart[i], eD: eventsEnd[i], dE: eventText[i])
            }
        }
    }
    
    func afficherEvent(sD : String, eD : String , dE : String){
        let sdArray = sD.characters.map { String($0) }
        let eDArray = eD.characters.map { String($0) }
        let jourStart = Int(sdArray[0]+sdArray[1])
        let jourEnd = Int(eDArray[0]+eDArray[1])
        let moisStart = Int(sdArray[3]+sdArray[4])
        let moisEnd = Int(eDArray[3]+eDArray[4])
        let yearStart = Int(sdArray[6]+sdArray[7]+sdArray[8]+sdArray[9])
        let minuteInDayStart = Int(sdArray[11]+sdArray[12])!*60 + Int(sdArray[14]+sdArray[15])!
        let minuteInDayEnd = Int(eDArray[11]+eDArray[12])!*60 + Int(eDArray[14]+eDArray[15])!
        let minuteInMonthStart = (Int(sdArray[0]+sdArray[1])!-1)*60*24 + Int(sdArray[11]+sdArray[12])!*60 + Int(sdArray[14]+sdArray[15])!
        let minuteInMonthEnd = (Int(eDArray[0]+eDArray[1])!-1)*60*24 + Int(eDArray[11]+eDArray[12])!*60 + Int(eDArray[14]+eDArray[15])!
        let dayInYear = (Int(eDArray[0]+eDArray[1]))!+(Int(sdArray[3]+sdArray[4])!-1)*30
        //attention aux chevauchements, bien comprendre
        if scale == "hour" && daySelect == jourStart && daySelect == jourEnd && monthSelect == moisStart && monthSelect == moisEnd && yearSelect == yearStart{
            let exemple = EventViewDay()
            let xxx:CGFloat = CGFloat(minuteInDayStart*129/60) + CGFloat(25.0)
            premierEventX = xxx
            let www:CGFloat = CGFloat((minuteInDayEnd-minuteInDayStart)*129)/CGFloat(60.0)
            exemple.frame = CGRect(x: xxx, y: 10, width: www, height: 65)
            exemple.labelEvent.text = dE
            exemple.startLabel = sD
            exemple.endLabel = eD
            exemple.isUserInteractionEnabled = true
            exemple.rectangle.addGestureRecognizer(tap)
            viewCal.addSubview(exemple)
            eventsViewsDay.append(exemple)
        }
        if scale == "hour" && daySelect == jourStart && daySelect != jourEnd && monthSelect == moisStart && monthSelect == moisEnd && yearSelect == yearStart{
            let exemple = EventViewDay()
            let xxx:CGFloat = CGFloat(minuteInDayStart*129/60) + CGFloat(25.0)
            premierEventX = xxx
            let www:CGFloat = CGFloat((60*24-minuteInDayStart)*129)/CGFloat(60.0) + CGFloat(25.0)
            exemple.frame = CGRect(x: xxx, y: 10, width: www, height: 65)
            exemple.labelEvent.text = dE
            exemple.endTrait.alpha = 0
            exemple.startLabel = sD
            exemple.endLabel = eD
            exemple.isUserInteractionEnabled = true
            exemple.rectangle.addGestureRecognizer(tap)
            viewCal.addSubview(exemple)
            eventsViewsDay.append(exemple)
        }
        if scale == "hour" && daySelect != jourStart && daySelect == jourEnd && monthSelect == moisStart && monthSelect == moisEnd && yearSelect == yearStart{
            let exemple = EventViewDay()
            premierEventX = 25
            let www:CGFloat = CGFloat(minuteInDayEnd*129)/CGFloat(60.0)
            exemple.frame = CGRect(x: 0, y: 10, width: www, height: 65)
            exemple.startTrait.alpha = 0
            exemple.labelEvent.text = dE
            exemple.startLabel = sD
            exemple.endLabel = eD
            exemple.isUserInteractionEnabled = true
            exemple.rectangle.addGestureRecognizer(tap)
            viewCal.addSubview(exemple)
            eventsViewsDay.append(exemple)
        }
        if scale == "day" && monthSelect == moisStart && monthSelect == moisEnd && yearSelect == yearStart{
            let exemple = EventViewMonth()
            exemple.labelEvent.text = dE
            let xxx:CGFloat = CGFloat(minuteInMonthStart*100/1440) + CGFloat(25.0)
            var www:CGFloat = CGFloat((minuteInMonthEnd-minuteInMonthStart)*100)/CGFloat(1440)
            print("from \(sD) to \(eD) : \(dE)  -> \(minuteInMonthStart) and \(minuteInMonthEnd)")
            if www < 55/3 {www = 55/3}
            exemple.frame = CGRect(x: xxx, y: 20, width: www, height: 55)
            exemple.backgroundColor = UIColor.init(white: 60, alpha: 0)
            viewCal.addSubview(exemple)
            eventsViewsMonth.append(exemple)
        }
        if scale == "month" && yearStart == yearSelect{
            let exemple = EventViewYear()
            let xxx:CGFloat = CGFloat(dayInYear*1200/365) + CGFloat(25.0)
            exemple.frame = CGRect(x: xxx, y: 20, width: 55/3, height: 55)
            exemple.backgroundColor = UIColor.init(white: 60, alpha: 0)
            viewCal.addSubview(exemple)
            eventsViewsYear.append(exemple)
        }
        
        
        
        
    }
    
    func hideEventDescription(){
        self.eventTitle.text = ""
        self.eventEndLabel.text = ""
        self.eventStartLabel.text = ""
    }
    
    func scrollToFirstEvent(){
        if premierEventX != -1{
            let cgp = CGPoint(x: premierEventX-100, y: 0)
            scrollView.setContentOffset(cgp , animated: true)
            premierEventX = -1
        }
    }
    
    func getDayOfWeek(today:String)->String {
        var result = "Error"
        let wArray = today.characters.map { String($0) }
        let strFirstDateOfmonth = "01-"+wArray[3]+wArray[4]+"-"+wArray[6]+wArray[7]+wArray[8]+wArray[9]
        if Int(wArray[0]+wArray[1])! < getDaysInMonth(today: strFirstDateOfmonth)+1 {
            let formatter  = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let todayDate = formatter.date(from: today)!
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
            let myComponents = myCalendar.components(.weekday, from: todayDate)
            result = dayWeek[myComponents.weekday!-1]
        }
        return result
    }
    
    func getDaysInMonth(today:String)->Int {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let startff = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: todayDate)))!
        let eend = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startff)!
        let myComponents2 = myCalendar.components(.day, from: eend)
        let monthDay = myComponents2.day
        return monthDay!
    }
    
    func textDayLabel(i:Int) -> String{
        let j:String = i+1<10 ? "0\(i+1)-" : "\(i+1)-"
        let k:String = monthSelect < 10 ? "0\(monthSelect)-" : "\(monthSelect)-"
        let todayString = j+k+"\(yearSelect)"
        return getDayOfWeek(today: todayString) + " " + String(i+1)
    }
    
    
    
    
    func handleLongPress(_ longPress: UILongPressGestureRecognizer) {
        if scale == "hour"{
            switch longPress.state {
            case .changed:
                
                let point = longPress.location(in: viewCal)
                let newCircle = UIView()
                newCircle.frame = CGRect(x: point.x-30, y: point.y-30, width: 10, height: 10)
                newCircle.layer.cornerRadius = 5
                newCircle.backgroundColor = UIColor.orange
                viewCal.addSubview(newCircle)
                cicleDraw.append(newCircle)
                newEventCircle.center = CGPoint(x: point.x - 20, y: point.y - 20)
                newEventCircle.alpha = point.y > 150 ? 0 : 1
            case .began:
                let point = longPress.location(in: viewCal)
                viewCal.addSubview(newEventCircle)
                newEventCircle.center = CGPoint(x: point.x - 20, y: point.y - 20)
                UIView.animate(withDuration: 0.3, animations: {
                    self.newEventCircle.frame = CGRect(x: point.x-45, y: point.y-45, width: 50, height: 50)
                    self.newEventCircle.cornerRadius = self.newEventCircle.frame.width / 2
                    self.newEventCircle.alpha = 0.5
                })
            case .ended:
                let point = longPress.location(in: viewCal)
                UIView.animate(withDuration: 0.3, animations: {
                    self.newEventCircle.frame = CGRect(x: point.x-10, y: point.y-10, width: 0, height: 0)
                    self.newEventCircle.alpha = 0
                }, completion : { finish in
                        if point.y < 150{
                            var exDroite = 30000.0
                            var exGauche = 0.0
                            for i in self.cicleDraw{
                                if i.center.x < CGFloat(exDroite){
                                    exDroite = Double(i.center.x)
                                }
                                if i.center.x > CGFloat(exGauche){
                                    exGauche = Double(i.center.x)
                                }
                            }
                            let heure =  exDroite/129
                            let minutee = (exDroite.truncatingRemainder(dividingBy: 129))*60/129
                            let minute = minutee - (minutee.truncatingRemainder(dividingBy: 5))
                            
                            let heure2 =  exGauche/129
                            let minutee2 = (exGauche.truncatingRemainder(dividingBy: 129))*60/129
                            let minute2 = minutee2 - (minutee2.truncatingRemainder(dividingBy: 5))
                        
                        
                        //creation de l'event
                            
                            let dateCrate : String = self.gg(g: self.daySelect) + "-" + self.gg(g: self.monthSelect) + "-\(self.yearSelect) " + self.gg(g: Int(heure)) + ":" + self.gg(g: Int(minute))
                            let dateCrateEnd : String = self.gg(g: self.daySelect) + "-" + self.gg(g: self.monthSelect) + "-\(self.yearSelect) " + self.gg(g: Int(heure2)) + ":" + self.gg(g: Int(minute2))
                            
                            self.Constante.set(dateCrate, forKey: "dateCreateString")
                            self.Constante.set(dateCrateEnd, forKey: "dateCreateEndString")
                            
                            self.Constante.set("Profile", forKey: "beforeAdd")
                            
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "createEvent") as UIViewController
                        self.present(vc, animated: true, completion: nil)
                        
                        //self.eventStartLabel.text = "On \
                    }
                    self.newEventCircle.removeFromSuperview()
                    
                })
            default:
                break
            }
        }
    }
    
    func gg(g:Int)->String{
        var hhh = ""
        if g < 10{
            hhh = "0\(g)"
        }
        else{
            hhh = "\(g)"
        }
        return hhh
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scale == "month"{
            if scrollView.panGestureRecognizer.state == .began{
                if scrollView.bounds.minX > 1240 - view.frame.width{
                    condNext2 = true
                }
                else {
                    condNext2 = false
                }
                if scrollView.bounds.minX < 10{
                    condPrev2 = true
                }
                else {
                    condPrev2 = false
                }
            
            }
            //smd
            if scrollView.bounds.minX < -50{
                prevYearLabel.text = "\(yearSelect-1)"
                infoPrevView.alpha = 1
                
                if scrollView.panGestureRecognizer.state == .possible{
                    condPrev = condPrev + 1
                    if condPrev == 1 && condPrev2{
                        condPrev2 = false
                        yearSelect = yearSelect-1
                        self.labelDate.text = "\(yearSelect)"
                        
                        greyLine.alpha = 1
                        blackLine.alpha = 1
                        self.greyLine.frame = CGRect(x: 0, y: 80, width: 100, height: 2)
                        self.blackLine.frame = CGRect(x: -100, y: 80, width: 100, height: 2)
                        let positionDecember = scrollView.convert(self.monthTraits[0].frame, to: view).minX
                        
                        for i in 2...9{
                            self.monthTraits[i].alpha = 0
                            self.monthLabel[i].alpha = 0
                        }
                        for i in 0...1{
                            self.monthTraits[11-i].center = CGPoint(x: -125 - 100*i, y: 80)
                            self.monthLabel[11-i].center = CGPoint(x: -125 - 100*i, y: 95)
                            self.monthTraits[i].center = CGPoint(x: positionDecember+CGFloat(100*i), y: 80)
                            self.monthLabel[i].center = CGPoint(x: positionDecember+CGFloat(100*i), y: 95)
                        }
                        
                        UIView.animate(withDuration: 1, animations: {
                            for i in 0...1{
                                self.monthTraits[11-i].center = CGPoint(x: self.view.frame.width - CGFloat(125 + 100*i), y: 80)
                                self.monthLabel[11-i].center = CGPoint(x: self.view.frame.width - CGFloat(125 + 100*i), y: 95)
                                self.monthTraits[i].center = CGPoint(x: self.view.frame.width + CGFloat(125 + 100*i), y: 80)
                                self.monthLabel[i].center = CGPoint(x: self.view.frame.width + CGFloat(125 + 100*i), y: 95)
                            }
                            self.greyLine.frame = CGRect(x: self.view.frame.width, y: 80, width: 100, height: 2)
                            self.blackLine.frame = CGRect(x: self.view.frame.width - 100, y: 80, width: 100, height: 2)
                        }, completion: { finish in
                            for i in 0...1{
                                self.monthTraits[i].center = CGPoint(x: 25 + 100*i, y: 80)
                                self.monthLabel[i].center = CGPoint(x: 25 + 100*i, y: 95)
                                self.monthTraits[10+i].center = CGPoint(x: 25 + 100*(10+i), y: 80)
                                self.monthLabel[10+i].center = CGPoint(x: 25 + 100*(10+i), y: 95)
                            }
                            for i in 2...9{
                                self.monthTraits[i].alpha = 1
                                self.monthLabel[i].alpha = 1
                            }
                            self.greyLine.alpha = 0
                            self.blackLine.alpha = 0
                            self.scrollView.contentOffset = CGPoint(x: 1250-self.view.frame.width, y: 0)
                            self.loadEvent()
                        })
                    }
                }
            }
            else{
                condPrev = 0
                infoPrevView.alpha = 0
            }
            //smu
            if scrollView.bounds.minX > 1250 - view.frame.width + 50{
                nextYearLabel.text = "\(yearSelect+1)"
                infoNextView.alpha = 1
                
                if scrollView.panGestureRecognizer.state == .possible{
                    condNext = condNext + 1
                    if condNext == 1 && condNext2{
                        condNext2 = false
                        yearSelect = yearSelect+1
                        self.labelDate.text = "\(yearSelect)"
                        
                        greyLine.alpha = 1
                        blackLine.alpha = 1
                        self.greyLine.frame = CGRect(x: view.frame.width-100, y: 80, width: 100, height: 2)
                        self.blackLine.frame = CGRect(x: view.frame.width, y: 80, width: 100, height: 2)
                        let positionDecember = scrollView.convert(self.monthTraits[11].frame, to: view).minX
                        
                        for i in 3...9{
                            self.monthTraits[i].alpha = 0
                            self.monthLabel[i].alpha = 0
                        }
                        for i in 0...2{
                            self.monthTraits[i].center = CGPoint(x: view.frame.width + CGFloat(25 + 100*i), y: 80)
                            self.monthLabel[i].center = CGPoint(x: view.frame.width + CGFloat(25 + 100*i), y: 95)
                        }
                        for i in 0...1{
                            self.monthTraits[11-i].center = CGPoint(x: positionDecember-CGFloat(100*i), y: 80)
                            self.monthLabel[11-i].center = CGPoint(x: positionDecember-CGFloat(100*i), y: 95)
                        }
                        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
                        
                        UIView.animate(withDuration: 1, animations: {
                            for i in 10...11{
                                self.monthTraits[i].center = CGPoint(x: -245 + 100*(i-10), y: 80)
                                self.monthLabel[i].center = CGPoint(x: -245 + 100*(i-10), y: 95)
                            }
                            self.greyLine.frame = CGRect(x: -100, y: 80, width: 100, height: 2)
                            self.blackLine.frame = CGRect(x: 0, y: 80, width: 100, height: 2)
                            for i in 0...2{
                                self.monthTraits[i].center = CGPoint(x: 25 + 100*i, y: 80)
                                self.monthLabel[i].center = CGPoint(x: 25 + 100*i, y: 95)
                            }
                        }, completion: { finish in
                            for i in 10...11{
                                self.monthTraits[i].center = CGPoint(x: 25 + 100*i, y: 80)
                                self.monthLabel[i].center = CGPoint(x: 25 + 100*i, y: 95)
                            }
                            for i in 3...9{
                                self.monthTraits[i].alpha = 1
                                self.monthLabel[i].alpha = 1
                            }
                            self.greyLine.alpha = 0
                            self.blackLine.alpha = 0
                            self.loadEvent()
                        })
                        
                        
                    }
                }
            }
            else{
                condNext = 0
                infoNextView.alpha = 0
            }
        }
        if scale == "day"{
            if scrollView.panGestureRecognizer.state == .began{
                if scrollView.bounds.minX > 2440 - view.frame.width{
                    condNext2 = true
                }
                else {
                    condNext2 = false
                }
                if scrollView.bounds.minX < 10{
                    condPrev2 = true
                }
                else {
                    condPrev2 = false
                }
                
            }
            //sdd
            if scrollView.bounds.minX < -50{
                prevYearLabel.text = months[(monthSelect-2+12)%12]
                infoPrevView.alpha = 1
                if scrollView.panGestureRecognizer.state == .possible{
                    condPrev = condPrev + 1
                    if condPrev == 1 && condPrev2{
                        condPrev2 = false
                        monthSelect = (monthSelect-2+12)%12+1
                        if monthSelect == 12{
                            yearSelect = yearSelect-1
                            buttonYear.setTitle("\(yearSelect)", for: UIControlState.normal)
                        }
                        self.labelDate.text = "\(months[monthSelect-1])"
                    
                        
                        greyLine.alpha = 1
                        blackLine.alpha = 1
                        self.greyLine.frame = CGRect(x: 0, y: 80, width: 100, height: 2)
                        self.blackLine.frame = CGRect(x: -100, y: 80, width: 100, height: 2)
                        let positionDecember = scrollView.convert(self.dayTraits[0].frame, to: view).minX
                        
                        for i in 2...28{
                            self.dayTraits[i].alpha = 0
                            self.dayLabel[i].alpha = 0
                        }
                        for i in 0...1{
                            self.dayTraits[30-i].center = CGPoint(x: -125 - 100*i, y: 80)
                            self.dayLabel[30-i].center = CGPoint(x: -125 - 100*i, y: 95)
                            self.dayTraits[i].center = CGPoint(x: positionDecember+CGFloat(100*i), y: 80)
                            self.dayLabel[i].center = CGPoint(x: positionDecember+CGFloat(100*i), y: 95)
                        }
                        
                        UIView.animate(withDuration: 1, animations: {
                            for i in 0...1{
                                self.dayTraits[30-i].center = CGPoint(x: self.view.frame.width - CGFloat(125 + 100*i), y: 80)
                                self.dayLabel[30-i].center = CGPoint(x: self.view.frame.width - CGFloat(125 + 100*i), y: 95)
                                self.dayTraits[i].center = CGPoint(x: self.view.frame.width + CGFloat(125 + 100*i), y: 80)
                                self.dayLabel[i].center = CGPoint(x: self.view.frame.width + CGFloat(125 + 100*i), y: 95)
                            }
                            self.greyLine.frame = CGRect(x: self.view.frame.width, y: 80, width: 100, height: 2)
                            self.blackLine.frame = CGRect(x: self.view.frame.width - 100, y: 80, width: 100, height: 2)
                        }, completion: { finish in
                            for i in 0...1{
                                self.dayTraits[i].center = CGPoint(x: 25 + 100*i, y: 80)
                                self.dayLabel[i].center = CGPoint(x: 25 + 100*i, y: 95)
                                self.dayTraits[29+i].center = CGPoint(x: 25 + 100*(29+i), y: 80)
                                self.dayLabel[29+i].center = CGPoint(x: 25 + 100*(29+i), y: 95)
                            }
                            for i in 0...30{
                                self.dayTraits[i].alpha = 1
                                self.dayLabel[i].alpha = 1
                                self.dayLabel[i].text = self.textDayLabel(i: i)
                            }
                            self.greyLine.alpha = 0
                            self.blackLine.alpha = 0
                            self.scrollView.contentOffset = CGPoint(x: 3150-self.view.frame.width, y: 0)
                            self.loadEvent()
                        })
                    }
                }
            }
            else{
                condPrev = 0
                infoPrevView.alpha = 0
            }
            //sdu
            if scrollView.bounds.minX > 3150 - view.frame.width + 50{
                nextYearLabel.text = months[(monthSelect+12)%12]
                infoNextView.alpha = 1
                
                if scrollView.panGestureRecognizer.state == .possible{
                    condNext = condNext + 1
                    if condNext == 1 && condNext2{
                        condNext2 = false
                        monthSelect = (monthSelect+12)%12+1
                        if monthSelect == 1{
                            yearSelect = yearSelect+1
                            buttonYear.setTitle("\(yearSelect)", for: UIControlState.normal)
                        }
                        self.labelDate.text = "\(months[monthSelect-1])"
                        
                        greyLine.alpha = 1
                        blackLine.alpha = 1
                        self.greyLine.frame = CGRect(x: view.frame.width-100, y: 80, width: 100, height: 2)
                        self.blackLine.frame = CGRect(x: view.frame.width, y: 80, width: 100, height: 2)
                        let positionDecember = scrollView.convert(self.dayTraits[30].frame, to: view).minX
                        
                        for i in 3...28{
                            self.dayTraits[i].alpha = 0
                            self.dayLabel[i].alpha = 0
                        }
                        for i in 0...2{
                            self.dayTraits[i].center = CGPoint(x: view.frame.width + CGFloat(25 + 100*i), y: 80)
                            self.dayLabel[i].center = CGPoint(x: view.frame.width + CGFloat(25 + 100*i), y: 95)
                        }
                        for i in 0...1{
                            self.dayTraits[30-i].center = CGPoint(x: positionDecember-CGFloat(100*i), y: 80)
                            self.dayLabel[30-i].center = CGPoint(x: positionDecember-CGFloat(100*i), y: 95)
                        }
                        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
                        
                        UIView.animate(withDuration: 1, animations: {
                            for i in 29...30{
                                self.dayTraits[i].center = CGPoint(x: -245 + 100*(i-29), y: 80)
                                self.dayLabel[i].center = CGPoint(x: -245 + 100*(i-29), y: 95)
                            }
                            self.greyLine.frame = CGRect(x: -100, y: 80, width: 100, height: 2)
                            self.blackLine.frame = CGRect(x: 0, y: 80, width: 100, height: 2)
                            for i in 0...2{
                                self.dayTraits[i].center = CGPoint(x: 25 + 100*i, y: 80)
                                self.dayLabel[i].center = CGPoint(x: 25 + 100*i, y: 95)
                            }
                        }, completion: { finish in
                            for i in 29...30{
                                self.dayTraits[i].center = CGPoint(x: 25 + 100*i, y: 80)
                                self.dayLabel[i].center = CGPoint(x: 25 + 100*i, y: 95)
                            }
                            for i in 0...30{
                                self.dayTraits[i].alpha = 1
                                self.dayLabel[i].alpha = 1
                                self.dayLabel[i].text = self.textDayLabel(i: i)
                            }
                            self.greyLine.alpha = 0
                            self.blackLine.alpha = 0
                            self.loadEvent()
                        })
                        
                        
                    }
                }
            }
            else{
                condNext = 0
                infoNextView.alpha = 0
            }
        }
        
        if scale == "hour"{
            if scrollView.panGestureRecognizer.state == .began{
                if scrollView.bounds.minX > 2440 - view.frame.width{
                    condNext2 = true
                }
                else {
                    condNext2 = false
                }
                if scrollView.bounds.minX < 10{
                    condPrev2 = true
                }
                else {
                    condPrev2 = false
                }
                
            }
            //shd
            if scrollView.bounds.minX < -50{
                prevYearLabel.text = "\((daySelect-1+31)%31)"
                infoPrevView.alpha = 1
                if scrollView.panGestureRecognizer.state == .possible{
                    condPrev = condPrev + 1
                    if condPrev == 1 && condPrev2{
                        condPrev2 = false
                        daySelect = (daySelect-1+31)%31
                        if daySelect == 30{
                            monthSelect = monthSelect-1
                            buttonMonth.setTitle("\(monthSelect)", for: UIControlState.normal)
                            if monthSelect == 11{
                                yearSelect = yearSelect-1
                                buttonYear.setTitle("\(yearSelect)", for: UIControlState.normal)
                                
                            }
                        }
                        self.labelDate.text = "\(daySelect)"
                        
                        
                        greyLine.alpha = 1
                        blackLine.alpha = 1
                        self.greyLine.frame = CGRect(x: 0, y: 80, width: 100, height: 2)
                        self.blackLine.frame = CGRect(x: -100, y: 80, width: 100, height: 2)
                        let positionDecember = scrollView.convert(self.hourTraits[0].frame, to: view).minX
                        
                        for i in 2...21{
                            self.hourTraits[i].alpha = 0
                            self.hourLabel[i].alpha = 0
                        }
                        for i in 0...1{
                            self.hourTraits[23-i].center = CGPoint(x: -125 - 129*i, y: 80)
                            self.hourLabel[23-i].center = CGPoint(x: -125 - 129*i, y: 95)
                            self.hourTraits[i].center = CGPoint(x: positionDecember+CGFloat(129*i), y: 80)
                            self.hourLabel[i].center = CGPoint(x: positionDecember+CGFloat(129*i), y: 95)
                        }
                        
                        UIView.animate(withDuration: 1, animations: {
                            for i in 0...1{
                                self.hourTraits[23-i].center = CGPoint(x: self.view.frame.width - CGFloat(25 + 129*i), y: 80)
                                self.hourLabel[23-i].center = CGPoint(x: self.view.frame.width - CGFloat(25 + 129*i), y: 95)
                                self.hourTraits[i].center = CGPoint(x: self.view.frame.width + CGFloat(125 + 129*i), y: 80)
                                self.hourLabel[i].center = CGPoint(x: self.view.frame.width + CGFloat(125 + 129*i), y: 95)
                            }
                            self.greyLine.frame = CGRect(x: self.view.frame.width, y: 80, width: 100, height: 2)
                            self.blackLine.frame = CGRect(x: self.view.frame.width - 100, y: 80, width: 100, height: 2)
                        }, completion: { finish in
                            for i in 0...1{
                                self.hourTraits[i].center = CGPoint(x: 25 + 129*i, y: 80)
                                self.hourLabel[i].center = CGPoint(x: 25 + 129*i, y: 95)
                                self.hourTraits[22+i].center = CGPoint(x: 25 + 129*(22+i), y: 80)
                                self.hourLabel[22+i].center = CGPoint(x: 25 + 129*(22+i), y: 95)
                            }
                            for i in 2...21{
                                self.hourTraits[i].alpha = 1
                                self.hourLabel[i].alpha = 1
                            }
                            self.greyLine.alpha = 0
                            self.blackLine.alpha = 0
                            self.scrollView.contentOffset = CGPoint(x: 3150-self.view.frame.width, y: 0)
                            self.loadEvent()
                        })
                    }
                }
            }
            else{
                condPrev = 0
                infoPrevView.alpha = 0
            }
            //shu
            if scrollView.bounds.minX > 3150 - view.frame.width + 50{
                nextYearLabel.text = "\((daySelect+1+31)%31)"
                infoNextView.alpha = 1
                
                if scrollView.panGestureRecognizer.state == .possible{
                    condNext = condNext + 1
                    if condNext == 1 && condNext2{
                        condNext2 = false
                        daySelect = (daySelect+1+31)%31
                        if daySelect == 0{
                            monthSelect = monthSelect+1
                            buttonMonth.setTitle("\(monthSelect)", for: UIControlState.normal)
                            if monthSelect == 0{
                                yearSelect = yearSelect+1
                                buttonYear.setTitle("\(yearSelect)", for: UIControlState.normal)
                                
                            }
                        }
                        self.labelDate.text = "\(daySelect)"
                        
                        greyLine.alpha = 1
                        blackLine.alpha = 1
                        self.greyLine.frame = CGRect(x: view.frame.width-100, y: 80, width: 100, height: 2)
                        self.blackLine.frame = CGRect(x: view.frame.width, y: 80, width: 100, height: 2)
                        let positionDecember = scrollView.convert(self.hourTraits[23].frame, to: view).minX
                        
                        for i in 3...21{
                            self.hourTraits[i].alpha = 0
                            self.hourLabel[i].alpha = 0
                        }
                        for i in 0...2{
                            self.hourTraits[i].center = CGPoint(x: view.frame.width + CGFloat(25 + 129*i), y: 80)
                            self.hourLabel[i].center = CGPoint(x: view.frame.width + CGFloat(25 + 129*i), y: 95)
                        }
                        for i in 0...1{
                            self.hourTraits[23-i].center = CGPoint(x: positionDecember-CGFloat(129*i), y: 80)
                            self.hourLabel[23-i].center = CGPoint(x: positionDecember-CGFloat(129*i), y: 95)
                        }
                        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
                        
                        UIView.animate(withDuration: 1, animations: {
                            for i in 22...23{
                                self.hourTraits[i].center = CGPoint(x: -245 + 129*(i-29), y: 80)
                                self.hourLabel[i].center = CGPoint(x: -245 + 129*(i-29), y: 95)
                            }
                            self.greyLine.frame = CGRect(x: -100, y: 80, width: 100, height: 2)
                            self.blackLine.frame = CGRect(x: 0, y: 80, width: 100, height: 2)
                            for i in 0...2{
                                self.hourTraits[i].center = CGPoint(x: 25 + 129*i, y: 80)
                                self.hourLabel[i].center = CGPoint(x: 25 + 129*i, y: 95)
                            }
                        }, completion: { finish in
                            for i in 22...23{
                                self.hourTraits[i].center = CGPoint(x: 25 + 129*i, y: 80)
                                self.hourLabel[i].center = CGPoint(x: 25 + 129*i, y: 95)
                            }
                            for i in 3...21{
                                self.hourTraits[i].alpha = 1
                                self.hourLabel[i].alpha = 1
                            }
                            self.greyLine.alpha = 0
                            self.blackLine.alpha = 0
                            self.loadEvent()
                        })
                        
                        
                    }
                }
            }
            else{
                condNext = 0
                infoNextView.alpha = 0
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func doubleTap(_ sender: Any) {
        let ss = sender as! UIGestureRecognizer
        let xx = ss.location(in: viewCal).x
        
        
        
        if scale == "hour"{
            print(ss.location(in: view).x)
            print(scrollView.convert(hourTraits[5].frame, to: view).minX)
        }
        
        //dth
         if scale == "day"{
            scale = "hour"
            
            var dayNum  = Int(abs(xx-25) / CGFloat(100))
            if dayNum == 31{dayNum = 30}
            daySelect = dayNum + 1
            
            labelDate.text = "\(daySelect)"
            buttonMonth.cornerRadius = 4
            self.buttonMonth.isEnabled = true
            self.buttonMonth.alpha = 1
            self.buttonMonth.frame = CGRect(x: self.bigFrame.width/2-38.0, y: 30, width: 0, height: 0)
            buttonMonth.backgroundColor = UIColor.darkGray
            buttonMonth.setTitle("\(months[monthSelect-1])", for: UIControlState.normal)
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
                
                    self.buttonMonth.frame = CGRect(x: self.bigFrame.width/2-60.0, y: 10, width: 100, height: 40)
                    self.labelDate.frame = CGRect(x: 10, y: 10, width: 50, height: 40)
                    self.buttonYear.frame = CGRect(x: self.bigFrame.width/2+50.0, y: 10, width: 50, height: 40)
                self.loadEvent()
            }, completion : {finish in
                self.scrollToFirstEvent()
            })
        }
        //mtd
        if scale == "month"{
            scale = "day"
            var monthNum  = Int(abs(xx-25) / CGFloat(100))
            if monthNum == 12{monthNum = 11}
            monthSelect = monthNum+1
            let month:String = months[monthSelect-1]
            labelDate.text = month
            
            labelDate.center = CGPoint(x: bigFrame.width/2-50.0, y: bigFrame.height/2+5)
            buttonYear.frame = CGRect(x: bigFrame.width/2, y: 10, width: 50, height: 40)
            buttonYear.cornerRadius = 4
            buttonYear.isEnabled = true
            buttonYear.alpha = 1
            buttonYear.backgroundColor = UIColor.darkGray
            buttonYear.setTitle("\(yearSelect)", for: UIControlState.normal)
            buttonYear.addTarget(self, action: #selector(buttonActionYear), for: UIControlEvents.touchUpInside)
            self.dateButonView.addSubview(buttonYear)
            
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
                dayLabel[i].text = textDayLabel(i: i)
                dayLabel[i].textColor = UIColor.black
                dayLabel[i].font = UIFont (name: "HelveticaNeue-Light", size: 15)
                dayLabel[i].frame = CGRect(x: 0, y: 0, width: 55, height: 20)
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
                self.loadEvent()
            })
        }
        
        
        
        
        
    }
    
   
    
    func buttonActionMonth(sender: UIButton!) {
        //htd
        if scale == "hour"{
            scale = "day"
            hideEventDescription()
            
            let mid:CGFloat = CGFloat(daySelect-1)*100 + CGFloat(25)
            let mid1 = mid - self.view.frame.width/2
            
            self.scrollView.contentOffset = CGPoint(x: mid1, y: 0)
            
            let frameBound = scrollView.bounds
            
            let daySep = daySelect-2
            
            if(daySep > 1){self.dayTraits[daySep-2].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                self.dayLabel[daySep-2].center = CGPoint(x: frameBound.minX-20, y: 95)}
            if(daySep > 0){self.dayTraits[daySep-1].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                self.dayLabel[daySep-1].center = CGPoint(x: frameBound.minX-20, y: 95)}
            if(daySep > -1){self.dayTraits[daySep].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                self.dayLabel[daySep].center = CGPoint(x: frameBound.minX-20, y: 95)}
            if(daySep < 9){self.dayTraits[daySep+1].frame = CGRect(x: frameBound.maxX-20, y: 66, width: 1, height: 20)
                self.dayLabel[daySep+1].center = CGPoint(x: frameBound.maxX-20, y: 95)}
            if(daySep < 10){self.dayTraits[daySep+2].frame = CGRect(x: frameBound.maxX-20, y: 66, width: 1, height: 20)
                self.dayLabel[daySep+2].center = CGPoint(x: frameBound.maxX-20, y: 95)}
            
            
            UIView.animate(withDuration: 0.8, animations: {
                for i in 0...30{
                    self.dayTraits[i].frame = CGRect(x: i*100+25, y: 70, width: 1, height: 17)
                    self.dayLabel[i].center = CGPoint(x: i*100+25, y: 95)
                    self.dayTraits[i].alpha = 1
                    self.dayLabel[i].alpha = 1
                }
                let yy = self.hourTraits[1].center.y
                let yy2 = self.hourLabel[1].center.y
                for i in 0...23{
                    self.hourTraits[i].alpha = 0
                    self.hourLabel[i].alpha = 0
                    self.hourTraits[i].center = CGPoint(x: mid, y: yy)
                    self.hourLabel[i].center = CGPoint(x: mid, y: yy2)
                }
                
                let month:String = self.months[self.monthSelect-1]
                self.labelDate.text = month
                self.buttonMonth.isEnabled = false
                self.buttonMonth.alpha = 0
                self.labelDate.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
                self.labelDate.center = CGPoint(x: self.bigFrame.width/2-50.0, y: self.bigFrame.height/2+5.0)
                self.buttonYear.frame = CGRect(x: self.bigFrame.width/2, y: 10, width: 50, height: 40)
                self.loadEvent()
            })
        }
    }
    
    
    func buttonActionYear(sender: UIButton!) {
        //dtm
        if scale == "day"{
            scale = "month"
            
            let mid:CGFloat = CGFloat(monthSelect)*100 + CGFloat(25)
            let mid1 = mid - self.view.frame.width/2
            
            self.scrollView.contentOffset = CGPoint(x: mid1, y: 0)
            
            let frameBound = scrollView.bounds
            
            let monthSep = monthSelect-1
            
            if(monthSep > 1){self.monthTraits[monthSep-2].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                self.monthLabel[monthSep-2].center = CGPoint(x: frameBound.minX-20, y: 95)}
            if(monthSep > 0){self.monthTraits[monthSep-1].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                self.monthLabel[monthSep-1].center = CGPoint(x: frameBound.minX-20, y: 95)}
            self.monthTraits[monthSep].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
            self.monthLabel[monthSep].center = CGPoint(x: frameBound.minX-20, y: 95)
            if(monthSep < 9){self.monthTraits[monthSep+1].frame = CGRect(x: frameBound.maxX-20, y: 66, width: 1, height: 20)
                self.monthLabel[monthSep+1].center = CGPoint(x: frameBound.maxX-20, y: 95)}
            if(monthSep < 10){self.monthTraits[monthSep+2].frame = CGRect(x: frameBound.maxX-20, y: 66, width: 1, height: 20)
                self.monthLabel[monthSep+2].center = CGPoint(x: frameBound.maxX-20, y: 95)}
            
            self.line.frame = CGRect(x: 0, y: 75, width: 1250, height: 2)
            //self.viewCal.layoutIfNeeded()
            
            for constraint in self.viewCal.constraints as [NSLayoutConstraint] {
                if constraint.identifier == "viewcalWidth" {
                    constraint.constant = 1250
                    UIView.animate(withDuration: 0.5, animations: {
                        self.view.layoutIfNeeded()
                    })
                }
            }
            
            
            
            UIView.animate(withDuration: 0.8, animations: {
                for i in 0...11{
                    self.monthTraits[i].alpha = 1
                    self.monthLabel[i].alpha = 1
                    self.monthTraits[i].frame = CGRect(x: i*100+25, y: 70, width: 1, height: 17)
                    self.monthLabel[i].center = CGPoint(x: i*100+25, y: 95)
                }
                let yy = self.dayTraits[1].center.y
                let yy2 = self.dayLabel[1].center.y
                for i in 0...30{
                    self.dayTraits[i].alpha = 0
                    self.dayLabel[i].alpha = 0
                    self.dayTraits[i].center = CGPoint(x: mid, y: yy)
                    self.dayLabel[i].center = CGPoint(x: mid, y: yy2)
                }
                
                self.labelDate.text = "\(self.yearSelect)"
                self.buttonYear.isEnabled = false
                self.buttonYear.alpha = 0
                self.labelDate.frame = CGRect(x: 0, y: 10, width: 100, height: 30)
                self.labelDate.center = CGPoint(x: self.bigFrame.width/2, y: self.bigFrame.height/2+5.0)
                self.loadEvent()
            })
            
            
        }
        //htm
        if scale == "hour"{
            scale = "month"
            hideEventDescription()
            let mid:CGFloat = CGFloat(monthSelect)*100 + CGFloat(25)
            let mid1 = mid - self.view.frame.width/2
            
            self.scrollView.contentOffset = CGPoint(x: mid1, y: 0)
            
            let frameBound = scrollView.bounds
            
            let monthSep = monthSelect-1
            
            if(monthSep > 1){self.monthTraits[monthSep-2].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                self.monthLabel[monthSep-2].center = CGPoint(x: frameBound.minX-20, y: 95)}
            if(monthSep > 0){self.monthTraits[monthSep-1].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
                self.monthLabel[monthSep-1].center = CGPoint(x: frameBound.minX-20, y: 95)}
            self.monthTraits[monthSep].frame = CGRect(x: frameBound.minX-20, y: 66, width: 1, height: 20)
            self.monthLabel[monthSep].center = CGPoint(x: frameBound.minX-20, y: 95)
            if(monthSep < 9){self.monthTraits[monthSep+1].frame = CGRect(x: frameBound.maxX-20, y: 66, width: 1, height: 20)
                self.monthLabel[monthSep+1].center = CGPoint(x: frameBound.maxX-20, y: 95)}
            if(monthSep < 10){self.monthTraits[monthSep+2].frame = CGRect(x: frameBound.maxX-20, y: 66, width: 1, height: 20)
                self.monthLabel[monthSep+2].center = CGPoint(x: frameBound.maxX-20, y: 95)}
            
            self.line.frame = CGRect(x: 0, y: 75, width: 1250, height: 2)
            //self.viewCal.layoutIfNeeded()
            
            for constraint in self.viewCal.constraints as [NSLayoutConstraint] {
                if constraint.identifier == "viewcalWidth" {
                    constraint.constant = 1250
                    UIView.animate(withDuration: 0.5, animations: {
                        self.view.layoutIfNeeded()
                    })
                }
            }
            
            UIView.animate(withDuration: 0.8, animations: {
                for i in 0...11{
                    self.monthTraits[i].alpha = 1
                    self.monthLabel[i].alpha = 1
                    self.monthTraits[i].frame = CGRect(x: i*100+25, y: 70, width: 1, height: 17)
                    self.monthLabel[i].center = CGPoint(x: i*100+25, y: 95)
                }
                let yy = self.hourTraits[1].center.y
                let yy2 = self.hourLabel[1].center.y
                for i in 0...23{
                    self.hourTraits[i].alpha = 0
                    self.hourLabel[i].alpha = 0
                    self.hourTraits[i].center = CGPoint(x: mid, y: yy)
                    self.hourLabel[i].center = CGPoint(x: mid, y: yy2)
                }
                
                self.buttonMonth.isEnabled = false
                self.buttonMonth.alpha = 0
                self.labelDate.text = "\(self.yearSelect)"
                self.buttonYear.isEnabled = false
                self.buttonYear.alpha = 0
                self.labelDate.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
                self.labelDate.center = CGPoint(x: self.bigFrame.width/2, y: self.bigFrame.height/2+5)
                self.loadEvent()
            })
        }
    }
    
}
