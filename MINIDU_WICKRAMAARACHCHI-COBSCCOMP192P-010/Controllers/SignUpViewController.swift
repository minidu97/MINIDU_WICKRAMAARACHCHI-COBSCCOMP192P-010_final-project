//
//  SignUpViewController.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010
//
//  Created by Minidu Wickramaarachchi on 2021-04-20.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpw: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupbtn(_ sender: Any) {
        if email.text?.isEmpty == true{
            let alert = UIAlertController(title: "Error", message: "Check Your Email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if phonenumber.text?.isEmpty == true{
            let alert = UIAlertController(title: "Error", message: "Enter the Phone Number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if password.text?.isEmpty == true{
            let alert = UIAlertController(title: "Error", message: "Enter the Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        SignUp()
        
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LOGIN_VIEW" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func SignUp(){
        if(password.text == confirmpw.text){
            Auth.auth().createUser(withEmail: email.text!,password: password.text!) { (authResult, error) in
                if let error = error as NSError? {
                                switch AuthErrorCode(rawValue: error.code) {
                                case .operationNotAllowed:
                                    let alert = UIAlertController(title: "Error", message: "Email is not allowed..!", preferredStyle: .alert)
                                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                self.present(alert, animated: true, completion: nil)
                                    break
                                case .emailAlreadyInUse:
                                    let alert = UIAlertController(title: "Error", message: "The email address is already in use by another account.", preferredStyle: .alert)
                                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                self.present(alert, animated: true, completion: nil)
                                    break
                                  
                                case .invalidEmail:
                                    let alert = UIAlertController(title: "Error", message: "The email address is badly formatted. ", preferredStyle: .alert)
                                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                self.present(alert, animated: true, completion: nil)
                                    break
                                case .weakPassword:
                                    let alert = UIAlertController(title: "Error", message: "The password must be 6 characters long or more . ", preferredStyle: .alert)
                                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                self.present(alert, animated: true, completion: nil)
                                    break
                                default:
                                    let alert = UIAlertController(title: "Error", message: "Something is wrong", preferredStyle: .alert)
                                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                self.present(alert, animated: true, completion: nil)
                                }
                              }
                print("User signs up successfully")
            let alertController: UIAlertController = UIAlertController(title: "Success", message: "User Registration is Successful", preferredStyle: .alert)
                      let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "menu" )
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true)
                        self.navigationController?.pushViewController(vc,animated: true)
                      }

                      alertController.addAction(okAction)
                      self.present(alertController, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Password Didnt Match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
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
