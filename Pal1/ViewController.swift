//
//  ViewController.swift
//  Pal1
//
//  Created by Julien Simmer  on 02/12/2016.
//  Copyright © 2016 Julien Simmer . All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import FBSDKCoreKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    @IBOutlet weak var inputUser: UITextField!
   
    @IBOutlet weak var inputPass: UITextField!
    
    @IBOutlet weak var buttonConnect: UIButton!
    
    @IBOutlet weak var errorConnect: UILabel!
    
    let Constante:UserDefaults = UserDefaults.standard

    
    var logged:Bool = false
    override func viewDidLoad() {
        errorConnect.alpha = 0
        super.viewDidLoad() 
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signinAction(_ sender: Any) {
        let email = inputUser.text
        let pass = inputPass.text
        
        if email != "" && pass != ""{
            //Verifier si ils existent bien dans la base :
            //récupérer le prenom
            let parameters: Parameters = [
                "email":email!,
                "password":pass!
            ]
            Alamofire.request("http://vinci.aero/palendar/php/login.php", method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let validate = json["validate"]
                    if validate == true{
                        let text = "MANU/&/\(email!)/&/\(pass!)"
                        self.ecrireLocal(str: text)
                        let token = text.components(separatedBy: "/&/")
                        self.Constante.set(token, forKey: "dataWritten")
                        self.performSegue(withIdentifier: "toUSERLOGIN", sender: self)
                    }
                    else{
                        self.errorConnect.alpha = 1
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        else{
            
        }
        
    }
    
    @IBAction func ee(_ sender: Any) {
        inputPass.becomeFirstResponder()
        scrollForKeyboard(val: 50)
    }
    @IBAction func ee22(_ sender: Any) {
        view.endEditing(true)
        scrollForKeyboard(val: 120)
    }
    
    @IBAction func beginUser(_ sender: Any) {
        scrollForKeyboard(val: 20)
    }
    @IBAction func befinPass(_ sender: Any) {
        scrollForKeyboard(val: 50)
    }
    
    
    
    @IBAction func FbLogin(_ sender: Any) {
        loginButtonClicked()
    }
    
    func loginButtonClicked() {
        let loginManager = LoginManager()
        if !logged{
            
            loginManager.logIn([ .publicProfile, .email, .userFriends], viewController: self) { loginResult in
                switch loginResult {
                    
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login.")
                case .success(_, _, let accessToken):
                    //vérifier si l'id ou email existe dans la base, sinon passer en sign up
                    self.logged = true
                    print("Logged in!")
                    print(accessToken.appId)
                    FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, email, picture.type(large)"]).start { (connection, result, error) -> Void in
                        if error != nil {
                            print (error!)
                        } else if let userData = result as? NSDictionary {
                            let prenom = userData["first_name"]! as? String
                            let nom = userData["last_name"]! as? String
                            let mail = userData["email"]! as? String
                            let d1 = userData["picture"]! as? NSDictionary
                            let d2 = d1?["data"] as? NSDictionary
                            let imageUrl = d2?["url"] as? String
                            //self.profileImage.downloadedFrom(link: d3!)
                            
                            
                            
                            //on ecrit les données de connection dans un fichier pour eviter de se reconnecter à chaque fois
                            let text = "FB/&/\(prenom!)/&/\(nom!)/&/\(mail!)/&/\(imageUrl!)"
                            self.ecrireLocal(str: text)
                            let token = text.components(separatedBy: "/&/")
                            self.Constante.set(token, forKey: "dataWritten")
                            //aller direct a la view User
                            self.performSegue(withIdentifier: "toUSERLOGIN", sender: self)
                        }
                    }
                    
                }
            }
        }
        else{
            print("Logged out!")
            self.logged = false
        }
    }
    
    func ecrireLocal(str:String){
        let file = "file.txt"
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file)
            
            //writing
            do {
                try str.write(to: path!, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
    }
    
    
    
    func scrollForKeyboard(val:CGFloat){
        for constraint in self.view.constraints as [NSLayoutConstraint] {
            if constraint.identifier == "toTOOP" {
                constraint.constant = val
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
}
