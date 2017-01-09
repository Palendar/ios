//
//  Model.swift
//  Pal1
//
//  Created by Julien Simmer  on 04/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class Model: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let Constante:UserDefaults = UserDefaults.standard
    
    var listOfGroup:[String] = ["Basket", "Garden", "Anjou", "ECE", "projet Java"]
    var listG:UITableView = UITableView()
    var listeGroupDisplay:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listeGroupDisplay = false
        listG.delegate = self
        listG.dataSource = self
        listG.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        listG.frame = CGRect(x: 0, y: 870, width: self.view.frame.width, height: self.view.frame.height-115)
        self.view.addSubview(listG)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inft:Int = listOfGroup.count
        return inft
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell!.textLabel!.text = listOfGroup[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.white
        let name = selectedCell.textLabel?.text! ?? "empty"
        print(name)
        Constante.set(name, forKey: "groupChoosen")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Group") as UIViewController
        self.present(vc, animated: false, completion: nil)
    }
    
    func displayListGroup(fromTop: CGFloat){
        UIView.animate(withDuration: 0.8, animations: {
            self.listG.frame = CGRect(x: 0, y: self.listeGroupDisplay ? 870 : fromTop, width: self.view.frame.width, height: self.view.frame.height-115)
        })
        self.listeGroupDisplay = !listeGroupDisplay
    }


}
