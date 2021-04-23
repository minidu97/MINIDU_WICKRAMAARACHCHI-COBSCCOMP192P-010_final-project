//
//  StoreViewController.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-23.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var Preview: UIView!
    @IBOutlet weak var Catogary: UIView!
    @IBOutlet weak var Menu: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func SegmentChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            Preview.isHidden = false
            Catogary.isHidden = true
            Menu.isHidden = true
        case 1:
            Preview.isHidden = true
            Catogary.isHidden = false
            Menu.isHidden = true
        case 2:
            Preview.isHidden = true
            Catogary.isHidden = true
            Menu.isHidden = false
        default:
            Preview.isHidden = false
        }

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
