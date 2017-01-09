//
//  SyncCalendar.swift
//  Pal1
//
//  Created by Julien Simmer  on 06/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class SyncCalendar: Model {
    
    var lastPageFromSettings = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        lastPageFromSettings = Constante.string(forKey: "lastPage")!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
