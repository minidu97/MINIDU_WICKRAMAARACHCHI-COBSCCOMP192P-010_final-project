//
//  MenuViewController.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-27.
//

import UIKit
import Foundation
import Firebase
import FirebaseStorage



class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    var catogaries = [Catogaries]();
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var CatogaryPicker: UIPickerView!
    @IBOutlet weak var txtDiscount: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBAction func btnCheckBox(_ sender: Any) {
        if(btnclick%2 == 1)
        {
            btnAdd.isEnabled = true;
        }
        else{
            btnAdd.isEnabled = false;
        }
    btnclick = btnclick + 1;
    }
    var btnclick = 1;
    
    var foodName = ""
    var foodDescription = ""
    var foodDiscount = ""
    var foodPrice = ""
    var foodCategory = ""
    var pickerData: [String] = [String]()
    
    @IBAction func btnAddclk(_ sender: Any) {
        AddFood();
    }
    //var ref: DatabaseReference!
    var ref = Database.database().reference()
    var randomInt = Int.random(in: 1..<10000)
    var imageURL = ""
    private let storage = Storage.storage().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        getCatogaryDetails() ;
        //tab action to Image Viewer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgItem.isUserInteractionEnabled = true
        imgItem.addGestureRecognizer(tapGestureRecognizer)
   
              self.CatogaryPicker.delegate = self
              self.CatogaryPicker.dataSource = self
        //picker data
        btnAdd.isEnabled = false;
    }
    
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        // Number of columns of data
        func numberOfComponents(in pickerView: UIPickerView) ->Int {
            return 1
        }
        
        // The number of rows of data
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int {
            return pickerData.count
        }
        
        // The data to return fopr the row and component (column) that's being passed in
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerData[row]
        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
               case CatogaryPicker:
        self.foodCategory =  pickerData[row]// This gives only the row value but  need string value*
                break;
        default: break
            
        }
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)

        // Your action
    }
    
    func AddFood(){
        foodName    = self.txtName.text ??  "";
        foodDescription    = self.txtDescription.text ?? "";
        foodDiscount    = self.txtDiscount.text ?? "";
        foodPrice   = self.txtPrice.text ?? "";
        if (txtName.text == "" || txtDescription.text == "" || txtDiscount.text == "" || txtPrice.text == "")
              {
            let alert = UIAlertController(title: "Error", message: "Fields Cannot be Empty", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
              }
        if !isValidatePrice(price: txtPrice.text ?? ""){
                    let alert = UIAlertController(title: "Error", message: "Please Check Your Enterd price format", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
        else{
            self.ref.child("Items").child("\(randomInt)").setValue(
                ["foodName": self.foodName,
                 "description": self.foodDescription,
                 "Price": self.foodPrice,
                 "image": self.imageURL,
                 "category": self.foodCategory,
                 "discount":self.foodDiscount])
            let alert = UIAlertController(title: "Success", message: "Item Added Successfully", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
            txtName.text = "";
            txtDescription.text = "";
            txtDiscount.text = "" ;
            txtPrice.text = "";
        }
    }
    func isValidatePrice(price: String) -> Bool {
                    let NUMBER_REGEX = #"^[0-9]*$"#
                     let numberTest = NSPredicate(format: "SELF MATCHES %@", NUMBER_REGEX)
                     let result = numberTest.evaluate(with: price)
                     return result
                }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            picker.dismiss(animated: true, completion: nil)
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                return
            }
            guard let imageData = image.pngData() else {
                return
            }
        storage.child("foods").child("\(self.randomInt)").child("image.png").putData(imageData, metadata: nil, completion: { [self] _, error in
                guard error == nil else {
                    print("Faild to Upload")
                    return
                }
                print("Upload Success")
            self.storage.child("foods").child("\(self.randomInt)").child("image.png").downloadURL(completion: {url, error in
                    guard let url = url, error == nil else{
                        return
                    }
                    let urlString = url.absoluteString
                    DispatchQueue.main.async {
                        self.imgItem .image = image
                    }
                    self.imageURL = urlString;
                    print("URL: \(urlString)")
                    UserDefaults.standard.set(urlString, forKey: "url")
                })
                
            })
        }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
          picker.dismiss(animated: true, completion: nil)
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
                                  self.pickerData.append(foodInfo["Name"] as! String);
                                  self.CatogaryPicker.reloadAllComponents();
                                    }
                                }
                            }
                        }
                    })
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
