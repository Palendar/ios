//
//  CreateGroup.swift
//  Pal1
//
//  Created by Julien Simmer  on 04/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CreateGroup: UIViewController, UITableViewDataSource {
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var tableViewMembers: UITableView!
    @IBOutlet weak var errorMessage: UILabel!
    
    
    let Constante:UserDefaults = UserDefaults.standard
    
    
    let testUsers:[String] = ["Nathalie", "Henry", "Raphael", "Sarah", "Nina"]
    var member:[String] = []
    
    override func viewDidAppear(_ animated: Bool) {
        tableViewMembers.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewDidLoad() {
        errorMessage.alpha = 0
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inft:Int = member.count
        return inft
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell!.textLabel!.text = member[indexPath.row]
        return cell!
    }
    
    @IBAction func endGroupName(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func endDescription(_ sender: Any) {
        view.endEditing(true)
        scrollDescriptionForKeyboard(val: 150)
    }
    
    @IBAction func touchDownDesciription(_ sender: Any) {
        scrollDescriptionForKeyboard(val: -2)
    }
    
    
    @IBAction func addMember(_ sender: Any) {
        let intt:Int = Int(arc4random_uniform(5))
        member.append(testUsers[intt])
        tableViewMembers.reloadData()
    }
    
    
    @IBAction func createGroupButton(_ sender: Any) {
        if groupName.text != "" && descriptionText.text != ""{
            let parameters: Parameters = [
                "name":groupName.text!,
                "description":descriptionText.text!
            ]
            Alamofire.request("http://vinci.aero/palendar/php/createGroup.php", method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let groupID = json["id"]
                    self.performSegue(withIdentifier: "toHome", sender: self)
                case .failure(let error):
                    print(error)
                    self.errorMessage.text = "Erreur dans la création du groupe Veuillez réessayer"
                    self.errorMessage.alpha = 1
                }
            }
        }
        else {
            errorMessage.alpha = 1
            errorMessage.text = "Veuillez préciser un nom et une description"
        }
        
    }
    
    func scrollDescriptionForKeyboard(val:CGFloat){
        for constraint in self.view.constraints as [NSLayoutConstraint] {
            if constraint.identifier == "descrpitionTop" {
                constraint.constant = val
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }

}
