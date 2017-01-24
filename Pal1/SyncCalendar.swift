//
//  SyncCalendar.swift
//  Pal1
//
//  Created by Julien Simmer  on 06/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit
import EventKit

class SyncCalendar: Model {
    
    
    @IBOutlet weak var indicatorProgress: UIActivityIndicatorView!
    
    var lastPageFromSettings = ""
    
    var eventStore: EKEventStore!
    var calendar: EKCalendar!
    
    var dateStart: [String] = []
    var dateEnd: [String] = []
    var descriptionEvent: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        lastPageFromSettings = Constante.string(forKey: "lastPage")!
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func syncCal(_ sender: Any) {
        indicatorProgress.startAnimating()
        self.eventStore = EKEventStore()
        
        self.eventStore.requestAccess(to: EKEntityType.event, completion: {
            (success: Bool, error: Error?) in
            if success{
                let dateFormatter = DateFormatter()
                
                dateFormatter.locale = Locale(identifier: "fr_FR")
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600)
                let string = "01-01-2017 00:00"
                let newDate = dateFormatter.date(from:string)
                
                let dateFormatter2 = DateFormatter()
                dateFormatter2.locale = Locale(identifier: "fr_FR")
                dateFormatter2.dateFormat = "dd-MM-yyyy HH:mm"
                dateFormatter2.timeZone = TimeZone(secondsFromGMT: 3600)
                let string2 = "01-03-2017 00:00"
                let newDate2 = dateFormatter2.date(from:string2)
                
                let predicate: NSPredicate = self.eventStore.predicateForEvents(withStart: newDate!, end: newDate2!, calendars: self.eventStore.calendars(for: .event))
                for i in 0...self.eventStore.events(matching: predicate).count-1{
                    let dateStart = self.eventStore.events(matching: predicate)[i].startDate
                    let dateEnd = self.eventStore.events(matching: predicate)[i].endDate
                    let descr = self.eventStore.events(matching: predicate)[i].title
                    
                    print("from \(dateStart) to \(dateEnd) : \(descr)")
                    
                    let ddd = dateFormatter2.string(from: dateStart)
                    let ddd2 = dateFormatter2.string(from: dateEnd)
                    
                    self.dateStart.append(ddd)
                    self.dateEnd.append(ddd2)
                    self.descriptionEvent.append(descr)
                }
                self.Constante.set(self.dateStart, forKey: "dateStart")
                self.Constante.set(self.dateEnd, forKey: "dateEnd")
                self.Constante.set(self.descriptionEvent, forKey: "descriptionEvent")
                
                print("------")
                print("------")
                
                self.indicatorProgress.stopAnimating()
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")
            }
        })
    }
    
    

    @IBAction func listGroup(_ sender: Any) {
        UIView.animate(withDuration: 0.8, animations: {
            self.listG.frame = CGRect(x: 0, y: self.listeGroupDisplay ? 870 : 70, width: self.view.frame.width, height: self.view.frame.height-115)
        })
        self.listeGroupDisplay = !listeGroupDisplay
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: lastPageFromSettings) as UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }

    @IBAction func homeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "foo") as UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }
}
