//
//  DeviceDetailsController.swift
//  1VALETChallenge
//
//  Created by Mac User on 2022-02-28.
//

import Foundation
import UIKit

class DeviceDetailsController: UIViewController {
    
    //where we can place a mock image of the device
    @IBOutlet var deviceImage: UIImageView!
    //device name label
    @IBOutlet var deviceTitleLabel: UILabel!
    //device OS label
    @IBOutlet var operatingSystemLabel: UILabel!
    //device size label
    @IBOutlet var deviceSizeLabel: UILabel!
    //device description label
    @IBOutlet var deviceDescriptionLabel: UILabel!
    //device favourite label
    @IBOutlet var deviceFavouriteLabel: UILabel!
    
    @IBOutlet var deviceStatusLabel: UILabel!
    
    //this will hold the model data from the previous controller
    var currentDevice : DeviceData!
    
    //the viewModel representing this controller
    private var deviceDetailsViewModel : DeviceDetailsViewModel!
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set-up the initial view
        setUpView()
    }
    
    func setUpView()  {
        //init the VM so we can utilize it
        self.deviceDetailsViewModel = DeviceDetailsViewModel()
        //bind the currentViewController that way we can dynamically update the data
        self.deviceDetailsViewModel.bindDevicesViewModelToController = {
            //if the data was set on the VM, update the data on the front end
            self.updateUI()
        }
        //create call to set the data
        //important this is after the bind call so we can receive data
        if currentDevice != nil {
            self.deviceDetailsViewModel.setDeviceData(device: currentDevice)
        }
    }
    
    func updateUI() {
        //1.if this function gets called, its due to data being set inside the VM
        //2.set the data up from the viewmodel
        
        DispatchQueue.main.async {
            //set the title of the controller
            self.title = self.deviceDetailsViewModel.devData.title
            
            //setup all of the labels required
            self.deviceTitleLabel.text = self.deviceDetailsViewModel.devData.title
            self.operatingSystemLabel.text = self.deviceDetailsViewModel.devData.os
            self.deviceSizeLabel.text = self.deviceDetailsViewModel.devData.size
            self.deviceDescriptionLabel.text = self.deviceDetailsViewModel.devData.deviceDescription
            self.deviceFavouriteLabel.text = String(self.deviceDetailsViewModel.devData.isFavourite)
            
            
            //using mutable string for the UX
            var myMutableString = NSMutableAttributedString()
            
            //check the value of the enum
            if self.deviceDetailsViewModel.devData.status.rawValue == "Available" {
                
                //create a new attributed string
                myMutableString = NSMutableAttributedString(string: "Status: \(self.deviceDetailsViewModel.devData.status.rawValue)", attributes: nil)
                //set the foreground attribute that way we can manipulate the text color
                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.001247007969, green: 0.6028117069, blue: 0.0351134165, alpha: 1), range: NSRange(location:7,length: self.deviceDetailsViewModel.devData.status.rawValue.count + 1))
                
            }else if self.deviceDetailsViewModel.devData.status.rawValue == "Not Available"{
                
                //create a new attributed string
                myMutableString = NSMutableAttributedString(string: "Status: \(self.deviceDetailsViewModel.devData.status.rawValue)", attributes: nil)
                //set the foreground attribute that way we can manipulate the text color
                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), range: NSRange(location:7,length: self.deviceDetailsViewModel.devData.status.rawValue.count + 1))
                
            }
            
            //set the new mutString for the device status to give it increased UI appeal
            self.deviceStatusLabel.attributedText = myMutableString

        }
        
        
        
    }
    
    
}
