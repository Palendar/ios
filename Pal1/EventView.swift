//
//  EventView.swift
//  Pal1
//
//  Created by Julien Simmer  on 20/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class EventViewDay: UIView {

    let rectangle = UIView()
    let startTrait = UIView()
    let endTrait = UIView()
    let labelEvent = UILabel()
    let whiteBack = UIView()
    var startLabel:String = ""
    var endLabel:String = ""
    
    let couleur = UIColor.init(red: 213, green: 221, blue: 246)
    
    override func draw(_ rect: CGRect) {
        
        whiteBack.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        whiteBack.backgroundColor = UIColor.white
        
        rectangle.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/2)
        rectangle.cornerRadius = 4
        rectangle.backgroundColor = couleur
        
        startTrait.frame = CGRect(x: 0, y: self.frame.height/2-10, width: 2, height: self.frame.height/2+10)
        startTrait.backgroundColor = couleur
        
        endTrait.frame = CGRect(x: self.frame.width-2, y: self.frame.height/2-10, width: 2, height: self.frame.height/2+10)
        endTrait.backgroundColor = couleur
        
        labelEvent.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/2)
        labelEvent.textColor = UIColor.black
        labelEvent.font = UIFont (name: "HelveticaNeue-Light", size: 18)
        labelEvent.textAlignment = NSTextAlignment.center
        
        self.addSubview(whiteBack)
        self.addSubview(startTrait)
        self.addSubview(endTrait)
        self.addSubview(rectangle)
        self.addSubview(labelEvent)
    }

}

class EventViewMonth: UIView {
    
    let rectangle = UIView()
    let trait = UIView()
    let labelEvent = UILabel()
    
    let couleur = UIColor.init(red: 213, green: 221, blue: 246)
    
    override func draw(_ rect: CGRect) {
        
        rectangle.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/3)
        rectangle.cornerRadius = self.frame.height/6
        rectangle.backgroundColor = couleur
        
        trait.frame = CGRect(x: 0, y: self.frame.height/6, width: 2, height: 5*self.frame.height/6)
        trait.backgroundColor = couleur
        
        labelEvent.frame = CGRect(x: 4, y: 0, width: self.frame.width-8, height: self.frame.height/3)
        labelEvent.textColor = UIColor.black
        labelEvent.font = UIFont (name: "HelveticaNeue-Light", size: 10)
        labelEvent.textAlignment = NSTextAlignment.center
        
        self.addSubview(trait)
        self.addSubview(rectangle)
        self.addSubview(labelEvent)
    }
    
}

