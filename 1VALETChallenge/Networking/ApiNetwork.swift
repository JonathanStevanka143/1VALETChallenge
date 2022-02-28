//
//  ApiNetwork.swift
//  1VALETChallenge
//
//  Created by Mac User on 2022-02-28.
//

import Foundation

class ApiNetwork: NSObject {
    
    //create a connection to the endpoint the project uses
    private let endPointUrl = URL(string: "www.exampleAPIEndpoint.com")
    
    //this will hold our fake JSON data coming back
    var fakeJson:[[String:Any]]! =
        [
            
            ["id":"1234","type":"Sensor","price":20,"currency":"USD","isFavourite":false,"imageUrl":"","title":"Test Sensor","description":"this is an example description testing my fake JSON"],
            
            ["id":"1235","type":"Thermostat","price":25,"currency":"USD","isFavourite":false,"imageUrl":"","title":"Test Sensor","description":"this is an example description testing my fake JSON"],
            
            ["id":"1236","type":"Thermostat","price":25,"currency":"USD","isFavourite":false,"imageUrl":"","title":"Test Sensor","description":"this is an example description testing my fake JSON"]
    
    ]
    
    
    
    
    func apiToGetEmployeeData(completion : @escaping ([DeviceData]) -> ()){
        
        
        //ACTING as if the URL request is actually running
        //We end up with 3 DeviceData models after the jsonDecoder.decode runs.
        //for simplicity sake because i cant use codeable due to not using real requests im just going to make a foreach loop that will make them into models
        //for testing purposes return the converted models
        
        //create an array to hold the models
        var devicesArray:[DeviceData] = []
        
        
        for deviceJSON in fakeJson {
            let newModel = DeviceData(id: deviceJSON["id"] as! String, type: deviceJSON["type"] as! String, currency: deviceJSON["currency"] as! String, imageUrl: deviceJSON["imageUrl"] as! String, title: deviceJSON["title"] as! String, deviceDescription: deviceJSON["description"] as! String, price: deviceJSON["price"] as! Int, isFavourite: deviceJSON["isFavourite"] as! Bool)
            devicesArray.append(newModel)
        }
        
        if devicesArray.isEmpty == false {
            completion(devicesArray)
        }
        
        //MARK: future use for pulling in Live data
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
    
}
