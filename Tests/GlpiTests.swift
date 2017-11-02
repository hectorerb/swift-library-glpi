/*
 * LICENSE
 *
 * GlpiTests.swift is part of the GLPI API Client Library for Swift,
 * a subproject of GLPI. GLPI is a free IT Asset Management.
 *
 * Glpi is Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ------------------------------------------------------------------------------
 * @author    Hector Rondon - <hrondon@teclib.com>
 * @date      13/10/17
 * @copyright (C) 2017 Teclib' and contributors
 * @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 * @link      https://github.com/flyve-mdm/ios-library-glpi
 * @link      http://www.glpi-project.org/
 * ------------------------------------------------------------------------------
 */

import XCTest
@testable import Glpi
import Alamofire

class GlpiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Test initSession request
    func testInitSession() {
        
        let expectationResult = expectation(description: "initSession")
        
        let expectedUserToken = Constants.initSessionTesting["userToken"] ?? ""
        let expectedAppToken = Constants.initSessionTesting["appToken"] ?? ""
        let expectedMethod = Constants.initSessionTesting["method"] ?? ""
        
        Alamofire.request(Routers.initSessionByUserToken(expectedUserToken, expectedAppToken).request()).response { response in

            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Authorization") ?? "", "user_token \(expectedUserToken)")
            XCTAssertEqual(response.request?.httpMethod ?? "", expectedMethod)
            XCTAssertEqual(response.response?.statusCode ?? 0, 200)
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test KillSession request
    func testKillSession() {
        
        let expectationResult = expectation(description: "killSession")
        
        Alamofire.request(Routers.killSession.request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "GET")
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test getMyProfiles request
    func testGetMyProfiles() {
        
        let expectationResult = expectation(description: "getMyProfiles")
        
        Alamofire.request(Routers.getMyProfiles.request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "GET")
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test getActiveProfile request
    func testGetActiveProfile() {
        
        let expectationResult = expectation(description: "getActiveProfile")
        
        Alamofire.request(Routers.getActiveProfile.request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "GET")
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test changeActiveProfile request
    func testChangeActiveProfile() {
        
        let expectationResult = expectation(description: "changeActiveProfile")
        
        var dictionary = [String: AnyObject]()
        dictionary["profiles_id"] = 4 as AnyObject
        
        Alamofire.request(Routers.changeActiveProfile(dictionary).request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "POST")
            
            let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!

            XCTAssertEqual(String(data: (response.request?.httpBody)!, encoding: .utf8) ?? "", jsonString)

            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test getMyEntities request
    func testGetMyEntities() {
        
        let expectationResult = expectation(description: "getMyEntities")
        
        Alamofire.request(Routers.getMyEntities.request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "GET")
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test getActiveEntities request
    func testGetActiveEntities() {
        
        let expectationResult = expectation(description: "getActiveEntities")
        
        Alamofire.request(Routers.getActiveEntities.request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "GET")
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test changeActiveEntities request
    func testChangeActiveEntities() {
        
        let expectationResult = expectation(description: "changeActiveEntities")
        
        var dictionary = [String: AnyObject]()
        dictionary["entities_id"] = 1 as AnyObject
        
        Alamofire.request(Routers.changeActiveEntities(dictionary).request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "POST")
            
            let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!

            XCTAssertEqual(String(data: (response.request?.httpBody)!, encoding: .utf8) ?? "", jsonString)
            
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test getFullSession request
    func testGetFullSession() {
        
        let expectationResult = expectation(description: "getFullSession")
        
        Alamofire.request(Routers.getFullSession.request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "GET")
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test getAllItems request
    func testGetAllItems() {
        
        let expectationResult = expectation(description: "getAllItems")
        
        Alamofire.request(Routers.getAllItems(ItemType.Computer, nil).request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "GET")
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test getAnItems request
    func testGetAnItems() {
        
        let expectationResult = expectation(description: "getAnItems")
        
        Alamofire.request(Routers.getItem(ItemType.Computer, 119, nil).request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "GET")
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test getsubItems
    func testGetSubItems() {
        
        let expectationResult = expectation(description: "getsubItems")
        
        Alamofire.request(Routers.getSubItems(ItemType.User, 24, ItemType.UserEmail, nil).request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "GET")
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test addItems
    func testAddItems() {
        
        let expectationResult = expectation(description: "addItems")
        
        var dictionary = [String: AnyObject]()
        var dictionaryData = [String: String]()
        dictionaryData["name"] = "Hector Rondon"
        dictionary["input"] = dictionaryData as AnyObject
        
        Alamofire.request(Routers.addItems(ItemType.User, dictionary).request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "POST")
            
            let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            
            XCTAssertEqual(String(data: (response.request?.httpBody)!, encoding: .utf8) ?? "", jsonString)
            
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test updateItems
    func testUpdateItems() {
        
        let expectationResult = expectation(description: "updateItems")
        
        var dictionary = [String: AnyObject]()
        var dictionaryData = [String: String]()
        dictionaryData["name"] = "Hector Rondon Update"
        dictionary["input"] = dictionaryData as AnyObject
        
        Alamofire.request(Routers.updateItems(ItemType.User, 24, dictionary).request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "PUT")
            
            let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            
            XCTAssertEqual(String(data: (response.request?.httpBody)!, encoding: .utf8) ?? "", jsonString)
            
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test deleteItems
    func testDeleteItems() {
        
        let expectationResult = expectation(description: "deleteItems")
        
        var dictionary = [String: AnyObject]()
        var dictionaryData = [String: Int]()
        dictionaryData["id"] = 24
        dictionary["input"] = dictionaryData as AnyObject
        
        Alamofire.request(Routers.deleteItems(ItemType.User, nil, nil, dictionary).request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "DELETE")
            
            let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            
            XCTAssertEqual(String(data: (response.request?.httpBody)!, encoding: .utf8) ?? "", jsonString)
            
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test lostPassword
    func testLostPassword() {
        let expectationResult = expectation(description: "lostPassword")
        
        var dictionary = [String: AnyObject]()
        dictionary["email"] = "flyve@hi2.in" as AnyObject
        
        Alamofire.request(Routers.lostPassword(dictionary).request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "PUT")
            
            let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            
            XCTAssertEqual(String(data: (response.request?.httpBody)!, encoding: .utf8) ?? "", jsonString)
            
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test resetPassword
    func testResetPassword() {
        let expectationResult = expectation(description: "resetPassword")
        
        var dictionary = [String: AnyObject]()
        dictionary["email"] = "flyve@hi2.in" as AnyObject
        dictionary["password_forget_token"] = "941891fcf47581084d43d2dec49b1c43a58380f4" as AnyObject
        dictionary["password"] = "12345678" as AnyObject
        
        Alamofire.request(Routers.lostPassword(dictionary).request()).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "PUT")
            
            let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            
            XCTAssertEqual(String(data: (response.request?.httpBody)!, encoding: .utf8) ?? "", jsonString)
            
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}