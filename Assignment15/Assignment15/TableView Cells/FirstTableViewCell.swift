//
//  FirstTableViewCell.swift
//  Assignment15
//
//  Created by Suhaas Choppavarapu on 9/8/20.
//  Copyright © 2020 Suhaas Choppavarapu. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    //MARK:- Properties
    static let identifier = "firstCell"
    
    //MARK:- IBOutlets
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
}
