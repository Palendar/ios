//
//  FirstFirstViewController.swift
//  Pal1
//
//  Created by Julien Simmer  on 04/12/2016.
//  Copyright © 2016 Julien Simmer . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstFirstViewController: UIViewController {
    
    let Constante:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        loginButton.alpha = 0
        signUpButton.alpha = 0
        
        
        let file = "file.txt" //this is the file. we will write to and read from it
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file)
            //reading
            do {
                let ex = try NSString(contentsOf: path!, encoding: String.Encoding.utf8.rawValue) as String
                let token = ex.components(separatedBy: "/&/") as [String]
                print(token)
                if token != [""]{
                    Constante.set(token, forKey: "dataWritten")
                    if token[0] == "MANU"{
                        let parameters: Parameters = [
                            "email":token[1],
                            "password":token[2]
                        ]
                        Alamofire.request("http://vinci.aero/palendar/php/login.php", method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON {
                            response in
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                let validate = json["validate"]
                                if validate == true{
                                    
                                    self.performSegue(withIdentifier: "toUSER", sender: self)
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                    if token[0] == "FB"{
                        performSegue(withIdentifier: "toUSER", sender: self)
                    }
                    
                    
                }
                else {
                    loginButton.alpha = 1
                    signUpButton.alpha = 1
                }
            }
            catch {/* error handling here */}
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
