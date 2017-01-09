//
//  User.swift
//  Pal1
//
//  Created by Julien Simmer  on 03/12/2016.
//  Copyright © 2016 Julien Simmer . All rights reserved.
//

import UIKit

class User: Model2{
    
    @IBOutlet weak var fav1: UIButton!
    @IBOutlet weak var fav2: UIButton!
    @IBOutlet weak var fav3: UIButton!
    
    @IBOutlet weak var myFaceButton: UIButton!
    var nbGroupFav:Int = 3
    var groupFav:[String] = ["Basket", "Garden", "ECE"]
    
    override func viewDidLoad() {
        
        buttonToHome.alpha = 0
        
        super.viewDidLoad()
        
        Constante.set("foo", forKey: "lastPage")
        
        let array = Constante.stringArray(forKey: "dataWritten")
        //name.text = array?[1]
        
        if array?[0] == "FB"{
            if let url = NSURL(string: (array?[4])!) {
                if let data = NSData(contentsOf: url as URL) {
                    if let imaget = UIImage(data: data as Data) {
                        myFaceButton.setImage(imaget.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                }
            }
            //imageView.downloadedFrom(link: (array?[4])!)
        }
        
        //récupérer la liste de tous les groupes
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    @IBAction func touchFace(_ sender: Any) {
        
    }
    
    
    @IBAction func fav3Action(_ sender: Any) {
        Constante.set(groupFav[2], forKey: "groupChoosen")
        self.performSegue(withIdentifier: "homeToGroup", sender: self)
    }
    
    @IBAction func fav1Action(_ sender: Any) {
        Constante.set(groupFav[0], forKey: "groupChoosen")
        self.performSegue(withIdentifier: "homeToGroup", sender: self)
    }
    
    @IBAction func fav2Action(_ sender: Any) {
        Constante.set(groupFav[1], forKey: "groupChoosen")
        self.performSegue(withIdentifier: "homeToGroup", sender: self)
        
    }
    
    
    
    
}
