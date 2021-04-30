//
//  OrderInfoViewController.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-27.
//

import UIKit
import Firebase
import FirebaseDatabase
public struct Items: Codable {
    let ItemName :String?
    let Price :Int?
    let Qty :Int?
    
    enum CodingKeys: String, CodingKey {
        case ItemName
        case Price
        case Qty
    }
}

class OrderInfoViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var lblUserInfo: UILabel!
    @IBOutlet weak var lblArivalTime: UILabel!
    @IBOutlet weak var tblOrderdInfo: UITableView!
    var items = [Items]();
    var ref: DatabaseReference!
    let OrderId = UserDefaults.standard.string(forKey: "OrderId")
    let CustomerName = UserDefaults.standard.string(forKey: "CustomerName")
    var Longitude = 0.00;
    var Latitude = 0.00;
    var TimeRemaining = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblOrderdInfo.delegate = self;
        tblOrderdInfo.dataSource = self;
        getItemDetails()
        getLocationDetails()
        calTime()


        // Do any additional setup after loading the view.
    }
    @IBAction func btnBack(_ sender: Any) {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "menu" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)*/
        self.dismiss(animated: true, completion: nil)
    }
    func getItemDetails() {
        
        let ref = Database.database().reference()
        ref.child("Orders").child("\(OrderId ?? "")").child("Items").observe(.value, with:{
            (snapshot) in
                        
            if let data = snapshot.value {
                if let orderditems = data as? [String: Any]{
                    self.items.removeAll();
                    for itemInfo in orderditems {
                        if let orderditems = itemInfo.value as? [String: Any]{
                            let singleFoodItem = Items(
                                ItemName: orderditems["ItemName"] as? String, Price: orderditems["Price"] as? Int, Qty: orderditems["Qty"] as! Int)
                            self.items.append(singleFoodItem)
                                    }
                                }
                                self.tblOrderdInfo.reloadData()
                            }
                        }
                    })
                }
    
    
    func getLocationDetails() {
         print("\(OrderId ?? "")")
         let ref = Database.database().reference()
         ref.child("Orders").child("\(OrderId ?? "")").child("Location").observe(.value, with:{
             (snapshot) in
             if let data = snapshot.value {
                 if let LocationDetails = data as? [String: Any]{
                     for itemInfo in LocationDetails {
                        self.Longitude = (LocationDetails["Longitude"] as! NSString).doubleValue
                        self.Latitude = (LocationDetails["Latitude"] as! NSString).doubleValue
                                 }
                                 self.tblOrderdInfo.reloadData()
                             }
             }
            })
    }
    func calTime(){
        if(Longitude > 65.78 && Latitude > 45.45){
            TimeRemaining = "15 min"
        }
        else{
            TimeRemaining = "3 min"
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tableView);
        print("Row At: \( self.items.count)")
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            let Ordercell = tblOrderdInfo.dequeueReusableCell(withIdentifier: "OrderInfocell", for: indexPath) as! OrderInfoTableViewCell
        Ordercell.lblQty.text = "\(self.items[indexPath.row].Qty ?? 0) x";
        Ordercell.lblItemName.text = self.items[indexPath.row].ItemName;
        Ordercell.lblPrice.text = "Rs.\(self.items[indexPath.row].Price ?? 0).00";
        lblUserInfo.text = "\(CustomerName ?? "") (\(OrderId ?? ""))";
        lblArivalTime.text = TimeRemaining;
            return Ordercell;
        //print(TimeRemaining)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
