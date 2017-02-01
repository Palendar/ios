//
//  createEvent.swift
//  Pal1
//
//  Created by Julien Simmer  on 31/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class createEvent: UIViewController {

    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var datePickerr: UIDatePicker!
    
    
    let Constante:UserDefaults = UserDefaults.standard
    var d:String = ""
    
    var dateEndString:Date = Date()
    var dateStartString:Date = Date()
    
    var dd = ""
    var vv = ""
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        errorMessage.alpha = 0
        dd = Constante.string(forKey: "dateCreateString")!
        vv = Constante.string(forKey: "dateCreateEndString")!
        print(dd)
        print(vv)
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.locale = Locale.init(identifier: "fr_FR")
        dateEndString = formatter.date(from: vv)!
        dateStartString = formatter.date(from: dd)!
        
        datePickerr.setDate(dateStartString, animated: false)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func startButtonPress(_ sender: Any) {
        endButton.borderWidth = 0
        startButton.borderWidth = 2
        datePickerr.setDate(dateStartString, animated: true)
    }
    
    @IBAction func endButtonPress(_ sender: Any) {
        startButton.borderWidth = 0
        endButton.borderWidth = 2
        datePickerr.setDate(dateEndString, animated: true)
    }

    @IBAction func create(_ sender: Any) {
        if groupName.text != ""{
            let parameters: Parameters = [
                "name":groupName.text!,
                "description":descriptionText.text!,
                "dateStart":dd,
                "dateEnd": vv
            ]
            /* No serveur
            Alamofire.request("http://vinci.aero/palendar/php/createEvent.php", method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let groupID = json["id"]
                    self.performSegue(withIdentifier: "toHome", sender: self)
                case .failure(let error):
                    print(error)
                    self.errorMessage.text = "Erreur dans la création de l'Event Veuillez réessayer"
                    self.errorMessage.alpha = 1
                }
            }
             */ //En attendant
            Constante.set(groupName.text!, forKey: "dateDescriptionAdd")
            Constante.set(dd, forKey: "dateStartAdd")
            Constante.set(vv, forKey: "dateEndAdd")
            Constante.set(true, forKey: "comeFromAdd")
            if Constante.string(forKey: "beforeAdd") == "Group"{
                self.performSegue(withIdentifier: "toGroup", sender: self)
            }else{
                self.performSegue(withIdentifier: "toProfile", sender: self)
            }
            
        }
            
        else {
            errorMessage.alpha = 1
            errorMessage.text = "Veuillez préciser un nom"
        }
    }
    
    @IBAction func endName(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func endDescription(_ sender: Any) {
        view.endEditing(true)
        scrollDescriptionForKeyboard(val: 186)
    }

    @IBAction func touchdownDesciprtion(_ sender: Any) {
        scrollDescriptionForKeyboard(val: -2)
    }
    
    func scrollDescriptionForKeyboard(val:CGFloat){
        for constraint in self.view.constraints as [NSLayoutConstraint] {
            if constraint.identifier == "descrpitionToop" {
                constraint.constant = val
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @IBAction func cancelPRess(_ sender: Any) {
        if Constante.string(forKey: "beforeAdd") == "Group"{
            self.performSegue(withIdentifier: "toGroup", sender: self)
        }else{
            self.performSegue(withIdentifier: "toProfile", sender: self)
        }
    }
    
    
}
