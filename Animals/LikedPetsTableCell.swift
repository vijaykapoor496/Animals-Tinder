//
//  LikedPetsTableCell.swift
//  Animals
//
//  Created by Vijay Kapoor on 13/02/19.
//  Copyright © 2019 Vijay Kapoor. All rights reserved.
//

import UIKit
import Kingfisher

class LikedPetsTableCell: UITableViewCell {
    
 
    @IBOutlet weak var likedPetName: UILabel!
    
    @IBOutlet weak var likedPetDescription: UILabel!
    
    
    @IBOutlet weak var likedPetImage: UIImageView!
    func setLikedPetsTableCell(name: String, image: String , description: String){
        let url = URL(string: image)
        self.likedPetImage.kf.setImage(with: url)
        self.likedPetName.text = name
        self.likedPetDescription.text = description
    }
  
}
    

