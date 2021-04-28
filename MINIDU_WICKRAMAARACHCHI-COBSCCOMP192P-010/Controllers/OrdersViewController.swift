//
//  OrdersViewController.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-27.
//

import UIKit
import Firebase
import FirebaseDatabase
public struct Orders: Codable {
    let CustomerName :String?
    let OrderId :String?
    let OrderStetus :String?
    
    enum CodingKeys: String, CodingKey {
        case CustomerName
        case OrderId
        case OrderStetus
    }
}

class OrdersViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var OrderTblView: UITableView!
    var orders = [Orders]();
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        OrderTblView.delegate = self;
        OrderTblView.dataSource = self;
        getOrderDetails()
        // Do any additional setup after loading the view.
    }
    func getOrderDetails() {
        
        let ref = Database.database().reference()
        ref.child("Orders").observe(.value, with:{
            (snapshot) in
                        
            if let data = snapshot.value {
                if let orderitems = data as? [String: Any]{
                    self.orders.removeAll();
                    for itemInfo in orderitems {
                        if let orderitem = itemInfo.value as? [String: Any]{
                            let singleFoodItem = Orders(
                                CustomerName: orderitem["CustomerName"] as! String, OrderId: orderitem["OrderId"] as! String, OrderStetus: orderitem["OrderStetus"] as! String)
                            self.orders.append(singleFoodItem)
                                    }
                                }
                                self.OrderTblView.reloadData()
                            }
                        }
                    })
                }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tableView);
        print("Row At: \( self.orders.count)")
        return orders.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            let catogaryCell = OrderTblView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell
        catogaryCell.CusName.text = self.orders[indexPath.row].CustomerName;
        catogaryCell.OrderId.text = self.orders[indexPath.row].OrderId;
            return catogaryCell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(self.orders[indexPath.row].OrderId, forKey: "OrderId")
        UserDefaults.standard.set(self.orders[indexPath.row].CustomerName, forKey: "CustomerName")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "OrderInfoView" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
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
