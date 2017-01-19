//
//  Profile.swift
//  Pal1
//
//  Created by Julien Simmer  on 04/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class Profile: Model2{
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var boutonCalendar: UIButton!
    
    @IBOutlet weak var boutonBNotif: UIButton!
    
    
    override func viewDidLoad() {
        
        Constante.set("Profile", forKey: "lastPage")
        
        super.viewDidLoad()
        boutonBNotif.setTitleColor(UIColor.black, for: .normal)
        
        /*
        let PV:ProfileView = ProfileView(nibName: "ProfileView", bundle: nil)
        self.addChildViewController(PV)
        self.scrollView.addSubview(PV.view)
        PV.didMove(toParentViewController: self)
        */
        
        let CV:CalendarView = CalendarView(nibName: "CalendarView", bundle: nil)
        self.addChildViewController(CV)
        self.scrollView.addSubview(CV.view)
        CV.didMove(toParentViewController: self)
        
        let NV:NotificationView = NotificationView(nibName: "NotificationView", bundle: nil)
        self.addChildViewController(NV)
        self.scrollView.addSubview(NV.view)
        NV.didMove(toParentViewController: self)
        
        CV.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-170)
        
        NV.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height-170)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width*2, height: self.view.frame.size.height-170)
        
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func CalendarButton(_ sender: Any) {
        //UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        //}, completion: nil)
        boutonBNotif.titleLabel?.textColor = UIColor.black
    }
    
    @IBAction func NotificationButton(_ sender: Any) {
        //UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.scrollView.contentOffset = CGPoint(x: self.view.frame.width, y: 0)
        //}, completion: nil)
        boutonCalendar.titleLabel?.textColor = UIColor.black
        boutonBNotif.setTitleColor(UIColor.init(netHex: 0x0080FF), for: .normal)
    }
    
    
    
    
    
    
    
    
    
    

}
