//
//  deviceControllerTableViewTests.swift
//  deviceControllerTableViewTests
//
//  Created by Mac User on 2022-03-02.
//

import XCTest
@testable import _VALETChallenge

class deviceControllerTableViewTests: XCTestCase {
    
    //this represents our devicescontroller
    var devicesController : DevicesController!
    
    override func setUpWithError() throws {
        
        //init a storyboard so we can create a VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //init the devicesController VC from the storyboard
        self.devicesController = storyboard.instantiateViewController(withIdentifier: "devicesController") as? DevicesController
        
        //manually call the loadView on the controller so the UI components are 'visible'
        self.devicesController.loadView()
        //this is to ensure there is data in the tableview before running the tests
        self.devicesController.viewDidLoad()
        
    }
    
    override func tearDownWithError() throws {
        //de-init the controller
        self.devicesController = nil
    }
    
    //test to make sure the tableview is present
    func testHasTableView() {
        XCTAssertNotNil(self.devicesController.tableView)
    }
    
    //test the datasource of the tableview
    func testTableViewDataSource() {
        XCTAssertNotNil(self.devicesController.tableView.dataSource)
    }
    
    //test the delegate of the tableview
    func testTableViewDelegate() {
        XCTAssertNotNil(self.devicesController.tableView.delegate)
    }
    
    //test the datasource protocol on the controller
    func testTableViewDataSourceProtocol() {
        XCTAssertTrue(self.devicesController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(self.devicesController.responds(to: #selector(self.devicesController.tableView(_:cellForRowAt:))))
        XCTAssertTrue(self.devicesController.responds(to: #selector(self.devicesController.tableView(_:numberOfRowsInSection:))))
    }
    
    //make sure the tableview conforms to the protocols specified by the delegate
    func testTableViewDelegateProtocol() {
        XCTAssertTrue(self.devicesController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(self.devicesController.responds(to: #selector(self.devicesController.tableView(_:didSelectRowAt:))))
    }
    
    //test the ReuseIdentifier(s) on the tableView
    func testTableViewCellReuseIdentifier() {
        let cell = self.devicesController.tableView(self.devicesController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? DeviceTableViewCell
        let expectedReuseIdentifier = "deviceTableCell"
        XCTAssertEqual(cell?.reuseIdentifier, expectedReuseIdentifier)
    }
    
}
