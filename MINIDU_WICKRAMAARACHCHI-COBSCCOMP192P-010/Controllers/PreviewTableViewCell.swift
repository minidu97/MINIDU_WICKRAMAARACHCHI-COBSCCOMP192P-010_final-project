//
//  PreviewTableViewCell.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-26.
//

import UIKit

class PreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var FoodName: UILabel!
    @IBOutlet weak var FoodDescription: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Percentage: UILabel!
    @IBOutlet weak var Switch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func SwitchState(_ sender: Any) {
    }
    
}
