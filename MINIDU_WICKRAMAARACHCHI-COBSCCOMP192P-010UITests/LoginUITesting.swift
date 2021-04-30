//
//  LoginUITesting.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010UITests
//
//  Created by Minidu Wickramaarachchi on 2021-04-30.
//

import XCTest

class LoginUiTest: XCTestCase {

    override func setUp() {
         
           // In UI tests it is usually best to stop immediately when a failure occurs.
           continueAfterFailure = false

          
       }
    
    func testLogin(){
           let app = XCUIApplication()
           app.launch()
        
        let emailField = app.textFields["EmailInput"]
                let pwdField = app.secureTextFields["PasswordInput"]
                let btn = app.buttons["btnLogin"]
               
              
                emailField.tap()
                emailField.typeText("trendymaxxx@gmail.com")
        
               pwdField.tap()
               pwdField.typeText("Minidu@0766")
        btn.tap()
                
               
    }

}
