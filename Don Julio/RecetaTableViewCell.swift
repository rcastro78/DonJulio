//
//  RecetaTableViewCell.swift
//  Don Julio
//
//  Created by Rafael David Castro Luna on 2/8/17.
//  Copyright © 2017 com.hn. All rights reserved.
//

import UIKit

class RecetaTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblReceta: UILabel!
    @IBOutlet weak var imgReceta: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    
}
