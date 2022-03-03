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
    
    //this holds all of our data and also acts as our callback
    private(set) var devData : [DeviceData]! {
        didSet {
            self.bindDevicesViewModelToController()
        }
    }
    
    //allows us to bind our controllers
    var bindDevicesViewModelToController : (() -> ()) = {}
    
    override init(){
        super.init()
        self.apiNetwork = ApiNetwork()
    }
    
    //get the data from the API
    func callToGetDeviceData(){
        self.apiNetwork.apiToGetEmployeeData { (deviceData) in
            self.devData = deviceData
        }
    }
    
    //this allows the user to search for a specific device
    func searchForDevice(searchText : String) {
        //1. search for the title of a device given the searchtext
        //2. set the devdata variable so the call back will get updated
        //3. check if the text == "" or 'nil' and set the data back to the original devices
                
        //because the '.grabCurrentDevices()' func will always have the users devices where 'devData' could be null use this instead for a better UX
        //this if statement creates fluid searching
        if self.apiNetwork.grabCurrentDevices().isEmpty == false && searchText != "" {
            
            //make sure the search is not empty
            if searchText != "" {
                
                //filter all close matches from the devices
                let filteredArray = self.apiNetwork.grabCurrentDevices().filter{ $0.title.range(of: searchText, options: .caseInsensitive) != nil }
                //setting the 'devData' will automatically update the devices screen due to binding
                self.devData = filteredArray
                
            }
            
        }
        //if the text is null or equals '""' the user has stopped typing, reset the data back to normal
        else if searchText == "" {
            self.devData = self.apiNetwork.grabCurrentDevices()
        }
        
    }
    
    
}
