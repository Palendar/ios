//
//  ModifProfil.swift
//  Pal1
//
//  Created by Julien Simmer  on 10/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class ModifProfil: Model {
    
    var lastPageFromSettings = ""
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var image: UIButton!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        lastPageFromSettings = Constante.string(forKey: "lastPage")!
        
        var array:[String] = ["","","","",""]
        array = Constante.stringArray(forKey: "dataWritten")!
        //name.text = array?[1]
        
        if array[0] == "FB"{
            if let url = NSURL(string: (array[4])) {
                if let data = NSData(contentsOf: url as URL) {
                    if let imaget = UIImage(data: data as Data) {
                        image.setImage(imaget.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                }
            }
        }
        
        name.text = "\(array[1]) \(array[2])"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func endDescirption(_ sender: Any) {
        view.endEditing(true)
    }
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func home(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "foo") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: lastPageFromSettings) as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func listG(_ sender: Any) {
        UIView.animate(withDuration: 0.8, animations: {
            self.listG.frame = CGRect(x: 0, y: self.listeGroupDisplay ? 870 : 70, width: self.view.frame.width, height: self.view.frame.height-115)
        })
        self.listeGroupDisplay = !listeGroupDisplay
    }
    
    
    
    
    
}
