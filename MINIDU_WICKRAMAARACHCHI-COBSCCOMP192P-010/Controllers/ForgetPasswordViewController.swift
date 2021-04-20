//
//  ForgetPasswordViewController.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-20.
//

import UIKit
import FirebaseAuth

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getpw(_ sender: Any) {
        
            if email.text?.isEmpty == true{
                let alert = UIAlertController(title: "Error", message: "Please Enter Your Email", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
            else{
                Auth.auth().sendPasswordReset(withEmail:email.text! ) {  error in
                        if let error = error {
                            let alert = UIAlertController(title: "Failed", message: "Please Meet Your Service Provider", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            return
                        }
                    let alertController: UIAlertController = UIAlertController(title: "Success", message: "Please refer the link sent to your E-Mail to reset the password", preferredStyle: .alert)

                              let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(identifier: "LOGIN_VIEW" )
                                vc.modalPresentationStyle = .overFullScreen
                                self.present(vc, animated: true)
                                self.navigationController?.pushViewController(vc,animated: true)
                              }

                              alertController.addAction(okAction)
                              self.present(alertController, animated: true, completion: nil)
                    
                    
                }
            }
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LOGIN_VIEW" )
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

