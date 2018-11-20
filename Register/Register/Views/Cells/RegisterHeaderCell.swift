//
//  RegisterHeaderCell.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import CodeBase

class RegisterHeaderCell: TableViewCell {
    
    @IBOutlet weak var headerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.headerImageView.image = UIImage.imageFromCodeBase(name: "pizza-icon")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
