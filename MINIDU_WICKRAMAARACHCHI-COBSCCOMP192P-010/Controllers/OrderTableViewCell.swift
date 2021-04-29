//
//  OrderTableViewCell.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-27.
//

import UIKit
import Firebase

class OrderTableViewCell: UITableViewCell {

    var ref = Database.database().reference()
    @IBOutlet weak var CusName: UILabel!
    @IBOutlet weak var OrderId: UILabel!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnReject(_ sender: UIButton) {
        self.ref.child("Orders/\(sender.tag)/Status").setValue("Cancel")
    }
    @IBAction func btnAccept(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
