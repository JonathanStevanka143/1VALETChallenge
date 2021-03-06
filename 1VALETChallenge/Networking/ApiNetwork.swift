//
//  ApiNetwork.swift
//  1VALETChallenge
//
//  Created by Mac User on 2022-02-28.
//

import Foundation

class ApiNetwork: NSObject {
    
    //create a connection to the endpoint the project uses
    //represents the url endpoint for all devices
    private let endPointUrl = URL(string: "www.exampleAPIEndpoint.com/user/devices")
    
    //this will hold our fake JSON data coming back
    private var fakeJson:[[String:Any]]! =
        [
            
            ["id":"1234","os":"iOS 14","status":"Available","size":"1600 x 800","isFavourite":false,"imageUrl":"","title":"iPhone 11","description":"this is an example description testing my fake JSON"],
             
            ["id":"1239","os":"Oreo","status":"Not Available","size":"1600 x 800","isFavourite":false,"imageUrl":"","title":"Android Pixel 2","description":"this is an example description testing my fake JSON, this is an example description testing my fake JSON"],
            
            
            ["id":"1235","os":"Oreo api 23","status":"Available","size":"1600 x 800","isFavourite":false,"imageUrl":"","title":"iPhone 11","description":"this is an example description testing my fake JSON"],
            
            ["id":"1236","os":"iOS 14","status":"Available","size":"1600 x 800","isFavourite":false,"imageUrl":"","title":"iPhone 11","description":"this is an example description testing my fake JSON, this is an example description testing my fake JSON"],
            
            ["id":"1237","os":"iOS 14","status":"Not Available","size":"1600 x 800","isFavourite":false,"imageUrl":"","title":"iPhone 7","description":"this is an example description testing my fake JSON"],
            
            ["id":"1238","os":"iOS 14","status":"Available","size":"1600 x 800","isFavourite":false,"imageUrl":"","title":"iPhone 5","description":"this is an example description testing my fake JSON"],
            
    ]
    //this will hold all of the converted devices from our FakeJson class
    //will be used to help us with searching
    private var devicesArray:[DeviceData] = []
    
    func grabCurrentDevices() -> [DeviceData] {
        return devicesArray
    }

    func apiToGetEmployeeData(completion : @escaping ([DeviceData]) -> ()){
        
        //ACTING as if the URL request is actually running
        //We end up with 3 DeviceData models after the jsonDecoder.decode runs.
        //for simplicity sake because i cant use codeable due to not using real requests im just going to make a foreach loop that will make them into models
        //for testing purposes return the converted models
        
        //create an array to hold the models
        devicesArray = []
        
        //cycle through our fake devices
        for deviceJSON in fakeJson {
            
            //create a new model for the users Device
            let newModel = DeviceData(id: deviceJSON["id"] as! String, title: deviceJSON["title"] as! String, os: deviceJSON["os"] as! String, size: deviceJSON["size"] as! String, imageUrl: deviceJSON["imageUrl"] as! String, deviceDescription: deviceJSON["description"] as! String, isFavourite: deviceJSON["isFavourite"] as! Bool, status: (DeviceData.availability.init(rawValue: deviceJSON["status"] as! String) ?? DeviceData.availability(rawValue: "Not Available"))!)
            
            
            //add the new model to the array
            devicesArray.append(newModel)
        }
        
        if devicesArray.isEmpty == false {
            //return the new devices
            completion(devicesArray)
        }
        
        //MARK: Live data
//        URLSession.shared.dataTask(with: endPointUrl!) { (data, urlResponse, error) in
//
//            if let data = data {
//
//                let jsonDecoder = JSONDecoder()
//
//                let devData = try! jsonDecoder.decode(Devices.self, from: data)
//                completion(devData)
//            }
//        }.resume()
    }
    
    
    //this allows us to check and see if a live URL request return would work.
    func modelConversionTest() -> [DeviceData]{
        
        //this will hold the converted models
        var decodedArray:[DeviceData] = []
        
        //check to see if we can serialize the fakeJson
        if let fakeJSONSerialized = try? JSONSerialization.data(withJSONObject: fakeJson, options: []) {
            
            //treat the 'fakeJSONSerialized' like a response object from a server
            if let jsonResponseObject = try! JSONSerialization.jsonObject(with: fakeJSONSerialized, options: []) as? [[String:Any]] {
                
                //for all of the devices we were returned, convert them into objects to be used
                for item in jsonResponseObject {
                    //init a jsondecoder
                    let jsonDecoder = JSONDecoder()
                    
                    //serialize the current item
                    if let itemData = try? JSONSerialization.data(withJSONObject: item, options: []) {
                        //decode the object into a DeviceData model
                        let devData = try! jsonDecoder.decode(DeviceData.self, from: itemData)
                        //append the data to the decoded array
                        decodedArray.append(devData)
                    }

                }
            
            }
            
        }
        
        return decodedArray
    }
    
    
    
}
