//
//  Model2.swift
//  Pal1
//
//  Created by Julien Simmer  on 06/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class Model2: Model {
    
    let headerView = UIView()
    let footerView = UIView()
    let buttonToSearch = UIButton()
    let PalendarLabel = UILabel()
    let SettingsButton = UIButton()
    let buttonToHome = UIButton()
    let buttonToGroup = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.backgroundColor = UIColor.init(netHex: 0xE6E6E6)
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        self.view.addSubview(headerView)
        
        footerView.backgroundColor = UIColor.init(netHex: 0xE6E6E6)
        footerView.frame = CGRect(x: 0, y: self.view.frame.height-50, width: self.view.frame.width, height: 50)
        self.view.addSubview(footerView)

        buttonToSearch.frame = CGRect(x: 7, y: 28, width: 53, height: 34)
        let imageSearch = UIImage(named: "search")
        buttonToSearch.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 16)
        buttonToSearch.addTarget(self, action: #selector(buttonSearch), for: .touchUpInside)
        buttonToSearch.setImage(imageSearch?.withRenderingMode(.alwaysOriginal), for: .normal)
        headerView.addSubview(buttonToSearch)
        
        PalendarLabel.text = "Palendar"
        PalendarLabel.textAlignment = .center
        PalendarLabel.frame = CGRect(x: self.view.frame.width/2-67/2, y: 35, width: 67, height: 21)
        headerView.addSubview(PalendarLabel)
        
        SettingsButton.frame = CGRect(x: self.view.frame.width-70, y: 20, width: 72, height: 50)
        let imageSettings = UIImage(named: "settings")
        SettingsButton.imageEdgeInsets = UIEdgeInsetsMake(12, 25, 14, 20)
        SettingsButton.addTarget(self, action: #selector(buttonSettings), for: .touchUpInside)
        SettingsButton.setImage(imageSettings?.withRenderingMode(.alwaysOriginal), for: .normal)
        headerView.addSubview(SettingsButton)
        
        buttonToHome.frame = CGRect(x: 0, y: 0, width: 60, height: 50)
        let imageHome = UIImage(named: "home")
        buttonToHome.imageEdgeInsets = UIEdgeInsetsMake(15, 17, 15, 20)
        buttonToHome.addTarget(self, action: #selector(buttonHome), for: .touchUpInside)
        buttonToHome.setImage(imageHome?.withRenderingMode(.alwaysOriginal), for: .normal)
        footerView.addSubview(buttonToHome)
        
        buttonToGroup.frame = CGRect(x: self.view.frame.width-72, y: 0, width: 72, height: 50)
        let imageList = UIImage(named: "listGroup")
        buttonToGroup.imageEdgeInsets = UIEdgeInsetsMake(11, 30, 11, 20)
        buttonToGroup.addTarget(self, action: #selector(buttonListGroup), for: .touchUpInside)
        buttonToGroup.setImage(imageList?.withRenderingMode(.alwaysOriginal), for: .normal)
        footerView.addSubview(buttonToGroup)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonSearch(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "search") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    func buttonSettings(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "settings") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    func buttonHome(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "foo") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func buttonListGroup(sender: UIButton!) {
        displayListGroup(fromTop: 70)
    }
    
    


}
