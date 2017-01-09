//
//  Search.swift
//  Pal1
//
//  Created by Julien Simmer  on 06/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class Search: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var groupbutton: UIButton!
    
    @IBOutlet weak var peopleButton: UIButton!

    @IBOutlet weak var textView: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    let Constante:UserDefaults = UserDefaults.standard
    
    var lastPageFromSettings = ""
    
    var exempleData = ["Igloo", "PFE2", "Running Day", "Never Party"]
    var exempleData2 = ["Henry Dupont", "Flavien Jeuri", "Hénormé Sec", "Julien Merci", "Wilson LaRacket"]
    var dataToUse = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataToUse = exempleData
        textView.becomeFirstResponder()
        lastPageFromSettings = Constante.string(forKey: "lastPage")!
        peopleButton.setTitleColor(UIColor.black, for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AnnulerBuuton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: lastPageFromSettings) as UIViewController
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func groupAction(_ sender: Any) {
        peopleButton.setTitleColor(UIColor.black, for: .normal)
        dataToUse = exempleData
        tableView.reloadData()
    }
    
    @IBAction func peopleAction(_ sender: Any) {
        groupbutton.titleLabel?.textColor = UIColor.black
        peopleButton.setTitleColor(UIColor.init(netHex: 0x0080FF), for: .normal)
        dataToUse = exempleData2
        tableView.reloadData()
    }
    @IBAction func endSearchEdit(_ sender: Any) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataToUse.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SearchCellView = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchCellView
        
        cell.name.text = dataToUse[indexPath.row]
        cell.rond.backgroundColor = UIColor.white
        cell.selectedRound = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        let selectedCell:SearchCellView = tableView.cellForRow(at: indexPath) as! SearchCellView
        selectedCell.contentView.backgroundColor = UIColor.white
        selectedCell.separator.backgroundColor = UIColor.init(netHex: 0xE6E6E6)
        let selected:Bool = selectedCell.selectedRound
        selectedCell.rond.backgroundColor = UIColor.init(netHex: selected ? 0xFFFFFF : 0x0080FF)
        selectedCell.selectedRound = !selected
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell:SearchCellView = tableView.cellForRow(at: indexPath) as! SearchCellView
        
        let selected:Bool = selectedCell.selectedRound
        selectedCell.rond.backgroundColor = UIColor.init(netHex: !selected ? 0xFFFFFF : 0x0080FF)
        
    }
    
    @IBAction func sendInvitation(_ sender: Any) {
        
        
    }
    
    
    
    
    
}
