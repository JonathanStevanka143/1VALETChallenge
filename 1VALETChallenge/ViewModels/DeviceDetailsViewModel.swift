//
//  DeviceDetailsViewModel.swift
//  1VALETChallenge
//
//  Created by Mac User on 2022-03-02.
//

import Foundation

class DeviceDetailsViewModel: NSObject {
    
    //*Future ability for this VM*
    //our API class for making calls to the network
    //incase in the future we need to dynamically load in more details about a speific device then what is not already shown
    //IE: from a different API, users who also have access to the same device
    private var apiNetwork: ApiNetwork!
    
    //this will hold the deviceData being displayed for the currently clicked on item
    private(set) var devData : DeviceData! {
        didSet {
            self.bindDevicesViewModelToController()
        }
    }
    
    //allow binding for this view model
    var bindDevicesViewModelToController : (() -> ()) = {}
    
    func setDeviceData(device:DeviceData) {
        //set the current device
        self.devData = device
        
    }
}
