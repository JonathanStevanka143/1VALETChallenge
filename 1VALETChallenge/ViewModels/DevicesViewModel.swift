//
//  DevicesViewModel.swift
//  1VALETChallenge
//
//  Created by Mac User on 2022-02-28.
//

import Foundation

class DevicesViewModel: NSObject {
    
    //our API class for making calls to the network
    private var apiNetwork: ApiNetwork!
    
    override init(){
        super.init()
        self.apiNetwork = ApiNetwork()
        callToGetDeviceData()
    }
    
    func callToGetDeviceData(){
        self.apiNetwork.apiToGetEmployeeData { (deviceData) in
            print(deviceData)
        }
    }
}
