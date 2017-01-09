//
//  CalendarGroupView.swift
//  Pal1
//
//  Created by Julien Simmer  on 05/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class CalendarGroupView: UIViewController {

    @IBOutlet weak var labelCenter: UILabel!
    
    let Constante:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelCenter.text = Constante.object(forKey: "groupChoosen") as! String?
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
