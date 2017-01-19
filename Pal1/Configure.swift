//
//  Configure.swift
//  Pal1
//
//  Created by Julien Simmer  on 04/12/2016.
//  Copyright © 2016 Julien Simmer . All rights reserved.
//

import UIKit
import EventKit

class Configure: UIViewController {

    @IBOutlet weak var indicSynchroCal: UIActivityIndicatorView!
    
    @IBOutlet weak var imageCheckSynchro: UIImageView!
    
    
    var eventStore: EKEventStore!
    var calendar: EKCalendar!
    
    var dateStart: [NSDate] = []
    var dateEnd: [NSDate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicSynchroCal.alpha = 0
        imageCheckSynchro.alpha = 0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func synchroCal(_ sender: Any) {
        indicSynchroCal.alpha = 1
        indicSynchroCal.startAnimating()
        synchroCal()
        
        
    }
    


    func synchroCal(){
        self.eventStore = EKEventStore()
        
        self.eventStore.requestAccess(to: EKEntityType.event, completion: {
            (success: Bool, error: Error?) in
            if success{
                // 2
                
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "fr_FR")
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                let string = "01-01-2017 00:00"
                let newDate = dateFormatter.date(from:string)
                
                let dateFormatter2 = DateFormatter()
                dateFormatter2.locale = Locale(identifier: "fr_FR")
                dateFormatter2.dateFormat = "dd-MM-yyyy HH:mm"
                dateFormatter2.timeZone = TimeZone(secondsFromGMT: 0)
                let string2 = "01-03-2017 00:00"
                let newDate2 = dateFormatter2.date(from:string2)
                
                let predicate: NSPredicate = self.eventStore.predicateForEvents(withStart: newDate!, end: newDate2!, calendars: self.eventStore.calendars(for: .event))
                for i in 0...self.eventStore.events(matching: predicate).count-1{
                    self.dateStart.append(self.eventStore.events(matching: predicate)[i].startDate as NSDate)
                    self.dateEnd.append(self.eventStore.events(matching: predicate)[i].endDate as NSDate)
                }
                //print(self.dateStart)
                //print(self.dateEnd)
                
                self.indicSynchroCal.alpha = 0
                self.indicSynchroCal.stopAnimating()
                self.imageCheckSynchro.alpha = 1
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")
            }
        })
    }
}
