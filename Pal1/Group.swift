//
//  Group.swift
//  Pal1
//
//  Created by Julien Simmer  on 05/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class Group: Model2 {
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var buttonCalendar: UIButton!
    
    @IBOutlet weak var memberCalendar: UIButton!
    
    
    override func viewDidLoad() {
        Constante.set("Group", forKey: "lastPage")
        
        memberCalendar.setTitleColor(UIColor.black, for: .normal)
        super.viewDidLoad()
        
        let CGV:CalendarGroupView = CalendarGroupView(nibName: "CalendarGroupView", bundle: nil)
        self.addChildViewController(CGV)
        self.scrollView.addSubview(CGV.view)
        CGV.didMove(toParentViewController: self)
        
        let MGV:MemberGroupView = MemberGroupView(nibName: "MemberGroupView", bundle: nil)
        self.addChildViewController(MGV)
        self.scrollView.addSubview(MGV.view)
        MGV.didMove(toParentViewController: self)
        
        CGV.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-170)
        
        MGV.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height-170)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width*2, height: self.view.frame.size.height-170)
        
        scrollView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        
    @IBAction func CalendarAction(_ sender: Any) {
        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        memberCalendar.titleLabel?.textColor = UIColor.black
    }
    
    @IBAction func memberAction(_ sender: Any) {
        self.scrollView.contentOffset = CGPoint(x: self.view.frame.width, y: 0)
        buttonCalendar.titleLabel?.textColor = UIColor.black
        memberCalendar.setTitleColor(UIColor.init(netHex: 0x0080FF), for: .normal)
    }
    
    

}
