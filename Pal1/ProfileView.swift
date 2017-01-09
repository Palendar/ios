//
//  ProfileView.swift
//  Pal1
//
//  Created by Julien Simmer  on 05/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class ProfileView: Model {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var image: UIButton!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var array:[String] = ["","","","",""]
        array = Constante.stringArray(forKey: "dataWritten")!
        //name.text = array?[1]
        
        if array[0] == "FB"{
            if let url = NSURL(string: (array[4])) {
                if let data = NSData(contentsOf: url as URL) {
                    if let imaget = UIImage(data: data as Data) {
                        image.setImage(imaget.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                }
            }
        }
        
        name.text = "\(array[1]) \(array[2])"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editName(_ sender: Any) {
        
    }
    @IBAction func clickImage(_ sender: Any) {
        
    }
    @IBAction func endDescription(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func GroupsAction(_ sender: Any) {
        displayListGroup(fromTop: 0)
    }
    
    
}
