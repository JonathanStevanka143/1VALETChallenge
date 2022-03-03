//
//  _VALETChallengeTests.swift
//  1VALETChallengeTests
//
//  Created by Mac User on 2022-02-28.
//

import XCTest
@testable import _VALETChallenge

class _VALETChallengeTests: XCTestCase {

    var apiNetwork : ApiNetwork!
    var devicesVM : DevicesViewModel!
    var deviceDetailsVM : DeviceDetailsViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //init the API network
        apiNetwork = ApiNetwork()
        //init the VM's
        devicesVM = DevicesViewModel()
        //grab the device data, simulates a GET request
        devicesVM.callToGetDeviceData()
        
        //init the deviceDetails VM
        deviceDetailsVM = DeviceDetailsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //de-init the APInetwork
        apiNetwork = nil
        //de-init the VM's
        devicesVM = nil
        deviceDetailsVM = nil
        try super.tearDownWithError()
    }
    
    //MARK: DeviceVM

    func testDeviceVMSearch() throws {
        //1. given
        //2. when
        //3. then
        
        //1. the string to search
        let search = "iph"
        
        //2. search for the devices in the data
        devicesVM.searchForDevice(searchText: search)
        
        //3. compute the result
        //with our current fake data, 'iph' should return 4 devices
        XCTAssertEqual(devicesVM.devData.count,5)
        
    }

    func testDeviceVMGrabAllData() throws {
        //1. when
        //2. then
        
        //1. search for the devices in the data
        devicesVM.callToGetDeviceData()
        
        //2. compute the result
        //with our current fake data, devData should never return false
        XCTAssertFalse(devicesVM.devData.isEmpty)
    }
    
    //MARK: DeviceDetailsVM
    
    func testDeviceDetailsVMGrabAllData() throws {
        //1. given
        //2. when
        //3. then
        
        //1. create a fake device totest
        let device = DeviceData(id: "id", title: "iphone 13", os: "ios 14", size: "1600 x 800", imageUrl: "", deviceDescription: "this is a test", isFavourite: false, status: .notAvailable)
        
        //2. set the device data
        deviceDetailsVM.setDeviceData(device: device)
        
        //3. make sure the device data is not nil
        XCTAssertTrue(deviceDetailsVM.devData != nil)
    }
    
    //MARK: API/JSON tests
    
    func testJSONResponseDecode() throws {
        //1.given
        //2.then
        
        //1.this will hold the grab the models that were converted
        let decodedArray = apiNetwork.modelConversionTest()
        
        //2. check to see if all models successfully converted over
        XCTAssertEqual(decodedArray.count,5)
    }

}
