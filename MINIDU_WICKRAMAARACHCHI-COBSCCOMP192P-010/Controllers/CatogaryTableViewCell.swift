//
//  CatogaryTableViewCell.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-26.
//

import UIKit
protocol YourCellDelegate : class {
    func didpressdelete(_ tag: Int)}

class CatogaryTableViewCell: UITableViewCell {

    var cellDelegate: YourCellDelegate?
    @IBOutlet weak var CatogaryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
