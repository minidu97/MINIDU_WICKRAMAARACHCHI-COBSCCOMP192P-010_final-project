//
//  PreviewViewController.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-26.
//

import UIKit
import Firebase
import FirebaseDatabase
import AlamofireImage
public struct FoodItems: Codable {
    let price :String?
    let catogary :String?
    let description :String?
    let discount :String?
    let foodname :String?
    let image :String?
    
    enum CodingKeys: String, CodingKey {
        case price
        case catogary
        case description
        case discount
        case foodname
        case image
        
    }
}
struct GroupFoodItems{
    var key:String
    var item:[FoodItems]
}

class PreviewViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{


    @IBOutlet weak var PreviewTable: UITableView!
    var fooditems: [FoodItems] = [
      
   ]
    
    var groupfoodItems: [GroupFoodItems] = [
    
    ]
    var ref: DatabaseReference!
    var price = "Rs. ";
    var Percentage = " %"
    var ending = ".00"

    override func viewDidLoad() {
        
        super.viewDidLoad()
        PreviewTable.delegate = self;
        PreviewTable.dataSource = self;
        getfooditemDetails()
        //self.CatogaryTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    func getfooditemDetails() {
        
        let ref = Database.database().reference()
        ref.child("Items").observe(.value, with:{
            (snapshot) in
                        
            if let data = snapshot.value {
                if let fooditem = data as? [String: Any]{
                    self.fooditems.removeAll();
                    for itemInfo in fooditem {
                        if let fooditem = itemInfo.value as? [String: Any]{
                            let singleFoodItem = FoodItems(
                                price: fooditem["Price"] as? String, catogary: fooditem["category"] as? String, description: fooditem["description"] as? String, discount: fooditem["discount"] as? String, foodname: fooditem["foodName"] as? String, image: fooditem["image"] as? String)
                            self.fooditems.append(singleFoodItem)
                                    }
                                }
                        let groupByCategory = Dictionary(grouping: self.fooditems) { (items) -> String in
                            return (items.catogary ?? "")
                        }
     
                        groupByCategory.forEach({(key,val) in
     
                            self.groupfoodItems.append(GroupFoodItems.init(key: key, item: val))
                        })
                                self.PreviewTable.reloadData()
                            }
                        }
                    })
                }
    func numberOfSections(in tableView: UITableView) -> Int {
        groupfoodItems.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(groupfoodItems.count > 0){
            return groupfoodItems[section].key
        }
        return ""
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupfoodItems[section].item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Itemcell = PreviewTable.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! PreviewTableViewCell
        Itemcell.FoodName.text = groupfoodItems[indexPath.section].item[indexPath.row].foodname ;
        Itemcell.FoodDescription.text = groupfoodItems[indexPath.section].item[indexPath.row].description;
        Itemcell.Percentage.text = groupfoodItems[indexPath.section].item[indexPath.row].discount! + Percentage;
        Itemcell.Price.text = price + groupfoodItems[indexPath.section].item[indexPath.row].price! + ending;
        if let url = URL(string: groupfoodItems[indexPath.section].item[indexPath.row].image ?? "") {
            Itemcell.ImageView.af_setImage(withURL: url)
                }
        return Itemcell;
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
