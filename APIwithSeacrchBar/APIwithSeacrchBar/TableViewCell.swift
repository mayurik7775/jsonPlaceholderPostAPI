//
//  TableViewCell.swift
//  APIwithSeacrchBar
//
//  Created by Mac on 04/04/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var idlbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
