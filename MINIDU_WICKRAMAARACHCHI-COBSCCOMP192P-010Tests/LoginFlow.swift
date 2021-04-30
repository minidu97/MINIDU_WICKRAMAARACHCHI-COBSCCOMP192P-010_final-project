//
//  LoginFlow.swift
//  MINIDU_WICKRAMAARACHCHI-COBSCCOMP192P-010Tests
//
//  Created by Minidu Wickramaarachchi on 2021-04-30.
//

import XCTest

class LoginFlow: XCTestCase {

    let authenticationService = AuthenticationService()
    func testValidEmail(){
        let result = authenticationService.validateEmail(email: "trendymaxxx@gmail.com")
        XCTAssertEqual(result, true)
    }
    
    func testInvalidEmail(){
        let result = authenticationService.validateEmail(email: "everymanoffline.com.test")
               XCTAssertEqual(result, false)
    }
    
    func testValidPassword(){
        let result = authenticationService.isValidPassword(pwd: "Minidu@0766")
        XCTAssertEqual(result, true)
    }
    
    func  testInvalidPassword(){
        let result = authenticationService.isValidPassword(pwd: "minidu0716950344")
               XCTAssertEqual(result, false)
    }

}
