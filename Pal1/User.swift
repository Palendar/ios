//
//  User.swift
//  Pal1
//
//  Created by Julien Simmer  on 03/12/2016.
//  Copyright © 2016 Julien Simmer . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class User: Model2{
    
    @IBOutlet weak var fav1: UIButton!
    @IBOutlet weak var fav2: UIButton!
    @IBOutlet weak var fav3: UIButton!
    
    @IBOutlet weak var myFaceButton: UIButton!
    var nbGroupFav:Int = 3
    var groupFav:[String] = ["Basket", "Garden", "ECE"]
    
    var uneSeulefois:Bool = true
    
    override func viewDidLoad() {
        Constante.set(false, forKey: "comeFromAdd")
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
        }
        
        
        /*
        let parameters: Parameters = ["search": "n"]
        Alamofire.request("http://vinci.aero/palendar/php/search.php", method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (key, subJson) in json{
                    let id = subJson["id"]
                    let pass = subJson["pass"]
                    let pseudo = subJson["pseudo"]
                }
            case .failure(let error):
                print(error)
            }
        }
        */
        
        
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        Alamofire.request("http://vinci.aero/palendar/php/test.php").responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (key, subJson) in json{
                    let id = subJson["id"]
                    let pass = subJson["pass"]
                    let pseudo = String(describing: subJson["pseudo"])
                }
            case .failure(let error):
                print(error)
                print("ERROR")
                if self.uneSeulefois{
                    self.showNoConnection()
                    self.uneSeulefois = false
                }
                
            }
        }
    }*/
    
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
