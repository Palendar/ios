//
//  SearchCellView.swift
//  Pal1
//
//  Created by Julien Simmer  on 06/01/2017.
//  Copyright © 2017 Julien Simmer . All rights reserved.
//

import UIKit

class SearchCellView: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rond: UIView!
    @IBOutlet weak var separator: UIView!
    
    var selectedRound:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
