//
//  SignUp.swift
//  Pal1
//
//  Created by Julien Simmer  on 04/12/2016.
//  Copyright © 2016 Julien Simmer . All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import FBSDKCoreKit
import Alamofire
import SwiftyJSON

class SignUp: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var surname: UITextField!
    
    @IBOutlet weak var inputEmail: UITextField!

    @IBOutlet weak var inputPass1: UITextField!
    
    @IBOutlet weak var inputPass2: UITextField!
    
    @IBOutlet weak var pass1Check: UILabel!
    
    @IBOutlet weak var pass2Check: UILabel!
    
    @IBOutlet weak var Gender: UISegmentedControl!
    
    @IBOutlet weak var birthLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    let Constante:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func editCh(_ sender: Any) {
        if inputPass1.text != ""{
            pass1Check.alpha = 1
        }
        else{
            pass1Check.alpha = 0
        }
        if (inputPass1.text?.characters.count)! > 5{
            pass1Check.textColor = UIColor.green
            pass1Check.text = "OK"
        }
        else{
            pass1Check.textColor = UIColor.red
            pass1Check.text = "Too Short"
        }
    }
    @IBAction func editCha2(_ sender: Any) {
        if inputPass2.text != ""{
            pass2Check.alpha = 1
            if inputPass1.text == inputPass2.text{
                pass2Check.textColor = UIColor.green
                pass2Check.text = "OK"
            }
            else{
                pass2Check.textColor = UIColor.red
                pass2Check.text = "Not Equal"
            }
        }
        else{
            pass2Check.alpha = 0
        }
        
    }
    
    
    @IBAction func signFBAction(_ sender: Any) {
        loginButtonClicked()
    }
    
    
    
    
    @IBAction func userEnd(_ sender: Any) {
        surname.becomeFirstResponder()
        scrollForKeyboard(val: -25)
    }
    
    @IBAction func surnameEnd(_ sender: Any) {
        inputEmail.becomeFirstResponder()
        scrollForKeyboard(val: -70)
    }
    
    @IBAction func emailEnd(_ sender: Any) {
        inputPass1.becomeFirstResponder()
        scrollForKeyboard(val: -110)
        
    }
    @IBAction func pass1End(_ sender: Any) {
        inputPass2.becomeFirstResponder()
        scrollForKeyboard(val: -130)
    }

    @IBAction func pass2End(_ sender: Any) {
        view.endEditing(true)
        scrollForKeyboard(val: 10)
    }
   
    @IBAction func tuchUser(_ sender: Any) {
        scrollForKeyboard(val: 10)
    }
    @IBAction func tuchMail(_ sender: Any) {
        inputEmail.placeholder = ""
        scrollForKeyboard(val: -70)
    }
    @IBAction func tuchPass(_ sender: Any) {
        scrollForKeyboard(val: -110)
    }
    @IBAction func tuchPass2(_ sender: Any) {
        scrollForKeyboard(val: -130)
    }
    
    
    
    @IBAction func signUpAction(_ sender: Any) {
        if surname.text != "" && userName.text != "" && inputEmail.text != "" && (inputPass1.text?.characters.count)! > 5 && inputPass2.text! == inputPass1.text {
            let surnamee = surname.text
            let prenom = userName.text
            let pass = inputPass1.text
            let email = inputEmail.text
            
            
            let parameters: Parameters = [
                "email":email!,
                "password":pass!,
                "firstname":prenom!,
                "lastname":surnamee!
            ]
            
            let parameters2: Parameters = [
                "email":email!
            ]
            
            Alamofire.request("http://vinci.aero/palendar/php/checkEmail.php", method: .post, parameters: parameters2, encoding: URLEncoding.httpBody).responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    //print("search : ")
                    let json = JSON(value)
                    
                    let validate = json["validate"]
                    if validate == true{
                        Alamofire.request("http://vinci.aero/palendar/php/register.php", method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON {
                            response in
                            switch response.result {
                            case .success(let value):
                                //print("search : ")
                                let json = JSON(value)
                                
                                let validate = json["validate"]
                                if validate == true{
                                    let text = "MANU/&/\(email!)/&/\(pass!)"
                                    self.ecrireLocal(str: text)
                                    let token = text.components(separatedBy: "/&/")
                                    self.Constante.set(token, forKey: "dataWritten")
                                    self.performSegue(withIdentifier: "toConfigure", sender: self)
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                    else{
                        self.inputEmail.text = ""
                        self.inputEmail.attributedPlaceholder = NSAttributedString(string: "Cette adresse possède déjà un compte",
                                                                        attributes: [NSForegroundColorAttributeName: UIColor.red])
                    }
                   
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        else{
            UIView.animate(withDuration: 0.5, animations: {
                self.userName.borderStyle  = UITextBorderStyle.roundedRect
            })
            UIView.animate(withDuration: 0.5, animations: {
                self.userName.borderStyle  = UITextBorderStyle.none
            })
        }
    }

    func scrollForKeyboard(val:CGFloat){
        for constraint in self.view.constraints as [NSLayoutConstraint] {
            if constraint.identifier == "toTOP" {
                constraint.constant = val
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    
    func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email, .userFriends], viewController: self) { loginResult in
                switch loginResult {
                    
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login.")
                case .success(_, _, let accessToken):
                    //vérifier si l'id ou email n'existe pas encore dans la base, sinon passer en sign in
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
                            
                            let text = "FB/&/\(prenom!)/&/\(nom!)/&/\(mail!)/&/\(imageUrl!)"
                            
                            self.ecrireLocal(str: text)
                            
                            //on ecrit les données de connection dans un fichier pour eviter de se reconnecter à chaque fois
                            
                            let token = text.components(separatedBy: "/&/")
                            self.Constante.set(token, forKey: "dataWritten")
                            //aller direct a la view User
                            self.performSegue(withIdentifier: "toConfigure", sender: self)
                        }
                    }
                    
                }
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
    
    @IBAction func birthDatebutton(_ sender: Any) {
        birthdateViewFromTop(distance: 70)
    }
    
    func birthdateViewFromTop(distance: CGFloat){
        for constraint in self.view.constraints as [NSLayoutConstraint] {
            if constraint.identifier == "BirthDateToTop" {
                constraint.constant = distance
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @IBAction func hideBirthDateView(_ sender: Any) {
        birthdateViewFromTop(distance: 600)
        let date = datePicker.date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateString = formatter.string(from: date)
        birthLabel.text = dateString
    }
    
    

}
