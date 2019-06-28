//
//  NYCAssessmentTests.swift
//  NYCAssessmentTests
//
//  Created by Paurush on 29/06/19.
//  Copyright © 2019 Paurush. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testModelAndAPI() {
        if let url = URL(string: strArticleUrl) {
            let promise = expectation(description: "Success API")
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                promise.fulfill()
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    if let tempData = data {
                        do {
                            let jsonData = try JSONSerialization.jsonObject(with: tempData, options: .allowFragments)
                            if let json = jsonData as? [String : Any], let results = json["results"] as? [[String : Any]] {
                                let nycModel = results.map({ (resultJson) -> NYCModel in
                                    return NYCModel(json: resultJson)
                                }).filter {
                                    $0.type.lowercased() == "article"
                                }
                                
                                // For checking model and api data is same
                                self.checkforProper(model: nycModel[0], and: results[0])
                                
                               } else {
                                XCTFail("Not a valid json.")
                            }
                        } catch let error {
                            XCTFail(error.localizedDescription)
                        }
                    }
                    else {
                        XCTFail("Data received from Api is nil.")
                    }
                }
                else {
                    XCTFail("Status code is other than 200.")
                }
            }.resume()
        } else {
            XCTFail("Url is not valid.")
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func checkforProper(model: NYCModel, and apiResult: [String : Any]) {
        XCTAssert(model.abstract == apiResult["abstract"] as? String, "Not equal.")
        XCTAssert(model.url == apiResult["url"] as? String, "Not equal.")
        XCTAssert(model.adx_keywords == apiResult["adx_keywords"] as? String, "Not equal.")
        XCTAssert(model.published_date == apiResult["published_date"] as? String, "Not equal.")
        XCTAssert(model.section == apiResult["section"] as? String, "Not equal.")
        XCTAssert(model.byline == apiResult["byline"] as? String, "Not equal.")
        XCTAssert(model.type == apiResult["type"] as? String, "Not equal.")
        XCTAssert(model.title == apiResult["title"] as? String, "Not equal.")
        XCTAssert(model.source == apiResult["source"] as? String, "Not equal.")
        XCTAssert(model.id == apiResult["id"] as? Int64, "Not equal.")
        XCTAssert(model.asset_id == apiResult["asset_id"] as? Int64, "Not equal.")
        XCTAssert(model.views == apiResult["views"] as? Int, "Not equal.")
        XCTAssert(model.des_facet == apiResult["des_facet"] as? [String], "Not equal.")
        XCTAssert(model.org_facet == apiResult["org_facet"] as? [String], "Not equal.")
        XCTAssert(model.per_facet == apiResult["per_facet"] as? [String], "Not equal.")
        XCTAssert(model.geo_facet == apiResult["geo_facet"] as? [String], "Not equal.")
    }

}
