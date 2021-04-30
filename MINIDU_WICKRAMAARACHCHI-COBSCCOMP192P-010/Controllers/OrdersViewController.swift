//
//  OrdersViewController.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-27.
//

import UIKit
import Firebase
import FirebaseDatabase
public struct NewOrder: Codable {
    let id : String?
    let cusName : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case id
        case cusName
        case status
    }
}
public struct ReadyOrder: Codable {
    let id : String?
    let cusName : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case id
        case cusName
        case status
    }
}

class OrdersViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var OrderTblView: UITableView!
    var newOrders = [NewOrder]()
    var readyOrder = [ReadyOrder]()
    var ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        OrderTblView.delegate = self;
        OrderTblView.dataSource = self;
        getOrderDetails()
        self.OrderTblView.reloadData()
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0)
        {
            return "Ready Orders"
        }
        else
        {
            return "New Orders"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(section == 0)
        {
            return readyOrder.count
        }
        else
        {
            return newOrders.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderCell = OrderTblView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell
        if(indexPath.section == 0)
        {
            orderCell.OrderId.text = readyOrder[indexPath.row].id;
            orderCell.CusName.text = readyOrder[indexPath.row].cusName;
            orderCell.btnAccept.tag = Int(readyOrder[indexPath.row].id ?? "0") ?? 0
            orderCell.btnReject.tag = Int(readyOrder[indexPath.row].id ?? "0") ?? 0
            orderCell.btnAccept.backgroundColor = UIColor.orange
            orderCell.btnAccept.setTitle("Arriving", for: .normal)
            orderCell.btnReject.isHidden = true;
            
        }
        else
        {
            orderCell.btnAccept.tag = Int(newOrders[indexPath.row].id ?? "0") ?? 0
            orderCell.btnReject.tag = Int(newOrders[indexPath.row].id ?? "0") ?? 0
            orderCell.OrderId.text = newOrders[indexPath.row].id;
            orderCell.CusName.text = newOrders[indexPath.row].cusName;
            orderCell.isEditing = false;
        }
        return orderCell;
    }
    
    func getOrderDetails()
    {
        let ref = Database.database().reference()
        ref.child("Orders").observe(.value, with:{
            (snapshot) in
            if let data = snapshot.value {
                if let Orders = data as? [String: Any]{
                    self.newOrders.removeAll();
                    self.readyOrder.removeAll();
                    for item in Orders {
                        if let orderInfo = item.value as? [String: Any]{
                            print(orderInfo)
                                    let status = orderInfo["Status"] as? String;
                                        if( "New" == status)
                                        {
                                            self.newOrders.append(NewOrder(id: orderInfo["OrderId"] as? String,cusName: orderInfo["Customer"] as? String, status: orderInfo["Status"] as? String));
                                            
                                        }
                                        else{
                                            self.readyOrder.append(ReadyOrder(id: orderInfo["OrderId"] as? String,cusName: orderInfo["Customer"] as? String, status: orderInfo["Status"] as? String));
                                        }
                                    }
                                }
                                self.OrderTblView.reloadData()
                          }
                    }
             })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        UserDefaults.standard.set(self.readyOrder[indexPath.row].id, forKey: "OrderId")
        UserDefaults.standard.set(self.readyOrder[indexPath.row].cusName, forKey: "CustomerName")
        print(indexPath.section)
        if(indexPath.section == 0){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "OrderInfoView" )
        vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)}
    
        
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
