//
//  ItemsTableViewCell.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-28.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var PricetblView: UITableView!
    @IBOutlet weak var btnPrint: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblItemTotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
