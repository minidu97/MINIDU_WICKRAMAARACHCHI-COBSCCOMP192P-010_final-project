//
//  CatogaryViewController.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-26.
//

import UIKit
import Firebase
import FirebaseDatabase
public struct Catogaries: Codable {
    let CatogaryName :String?
    let Id :String?
    
    enum CodingKeys: String, CodingKey {
        case CatogaryName
        case Id
        
    }
}

class CatogaryViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var CatogaryView: UITextField!
    @IBOutlet weak var CatogaryTableView: UITableView!
    var catogaries = [Catogaries]();
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        CatogaryTableView.delegate = self;
        CatogaryTableView.dataSource = self;
        getCatogaryDetails()
        self.CatogaryTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddCatogaryBtn(_ sender: Any) {
        self.ref = Database.database().reference()
        let randomInt = Int.random(in: 1..<10000)
        self.ref.child("Catogaries").child("\(randomInt)").setValue(["Name": self.CatogaryView.text!])
        if (CatogaryView.text == "") {
            let alert = UIAlertController(title: "Failed", message: "Please Meet Your Service Provider", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Success", message: "Catogary Added Successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            CatogaryView.text="";
        }
    }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print(tableView);
            print("Row At: \( self.catogaries.count)")
            return catogaries.count;
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               
                let catogaryCell = CatogaryTableView.dequeueReusableCell(withIdentifier: "CatogaryCell", for: indexPath) as! CatogaryTableViewCell
                catogaryCell.CatogaryName.text = self.catogaries[indexPath.row].CatogaryName;
                return catogaryCell;
        }

                    

        func getCatogaryDetails() {
            
            let ref = Database.database().reference()
            ref.child("Catogaries").observe(.value, with:{
                (snapshot) in
                            
                if let data = snapshot.value {
                    if let foodItems = data as? [String: Any]{
                        self.catogaries.removeAll();
                        for itemInfo in foodItems {
                            if let foodInfo = itemInfo.value as? [String: Any]{
                                let singleFoodItem = Catogaries(
                                    CatogaryName: foodInfo["Name"] as! String, Id: itemInfo.key)
                                      self.catogaries.append(singleFoodItem)
                                        }
                                    }
                                    self.CatogaryTableView.reloadData()
                                }
                            }
                        })
                    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
        }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if (editingStyle == .delete) {
                let alert = UIAlertController(title: "Confirm", message: "Are you sure want to delete the category?", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    self.deleteCategory(id: self.catogaries[indexPath.row].Id!)
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                present(alert, animated: true, completion: nil)
                
            }
        }
    func deleteCategory(id:String){
        let ref = Database.database().reference()
        ref.child("Catogaries").child("\(id)").removeValue();
        self.CatogaryTableView.reloadData()
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
