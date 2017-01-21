//
//  FirstFirstViewController.swift
//  Pal1
//
//  Created by Julien Simmer  on 04/12/2016.
//  Copyright © 2016 Julien Simmer . All rights reserved.
//

import UIKit

class FirstFirstViewController: UIViewController {
    
    let Constante:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        loginButton.alpha = 0
        signUpButton.alpha = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
                    //aller direct a la view User
                    performSegue(withIdentifier: "toUSER", sender: self)
                    
                }
                else {
                    loginButton.alpha = 1
                    signUpButton.alpha = 1
                }
            }
            catch {/* error handling here */}
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
