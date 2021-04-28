//
//  AccountViewController.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-28.
//

import UIKit
import Firebase
import FirebaseDatabase
public struct Deliveries: Codable {
    let Name :String?
    let Price :String?
    let Date :String?
    
    enum CodingKeys: String, CodingKey {
        case Name
        case Price
        case Date
        
    }
}

class AccountViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var level1view: UITableView!
    @IBOutlet weak var StartDatePicker: UIDatePicker!
    @IBOutlet weak var EndDatePicker: UIDatePicker!
    @IBOutlet weak var lblTotalAmount: UILabel!
    var deliveries = [Deliveries]();
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        level1view.delegate = self;
        level1view.dataSource = self;
        getDeliveryDetails()
        //self.CatogaryTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    func getDeliveryDetails() {
        
        let ref = Database.database().reference()
        ref.child("Deliveries").observe(.value, with:{
            (snapshot) in
            if let data = snapshot.value {
                if let DeliveredItems = data as? [String: Any]{
                    self.deliveries.removeAll();
                    if let DeliveredItem = DeliveredItems as? [String: Any]{
                            let SingleDelivery = Deliveries(
                                Name: DeliveredItem["Name"] as? String, Price: DeliveredItem["Price"] as? String, Date: DeliveredItem["Date"] as? String)
                            self.deliveries.append(SingleDelivery)
                                    }
                                }
                                self.level1view.reloadData()
                            }
                        }
                    )
                }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tableView);
        print("Row At: \( self.deliveries.count)")
        return deliveries.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let Deliveries = level1view.dequeueReusableCell(withIdentifier: "Print&Price", for: indexPath) as! Level1TableViewCell
        Deliveries.lblDate.text = self.deliveries[indexPath.row].Date
        Deliveries.lblTotal.text = self.deliveries[indexPath.row].Price
        Deliveries.ItemName.text = self.deliveries[indexPath.row].Name
        Deliveries.ItemPrice.text = self.deliveries[indexPath.row].Price
            return Deliveries;

        //print(TimeRemaining)
    }
    
    //Item&Price

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
