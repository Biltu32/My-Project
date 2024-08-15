//
//  Weatherdetails.swift
//  Weather
//
//  Created by DAPL-Asset-210 on 12/07/24.
//

import UIKit

class Weatherdetails: UITableViewCell {

    @IBOutlet weak var viewrec : UIView!
    @IBOutlet weak var labelDay : UILabel!
    @IBOutlet weak var labelMaxtemp : UILabel!
    @IBOutlet weak var labelMintemp : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewrec.layer.cornerRadius = 10
        viewrec.layer.borderWidth = 0.5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
