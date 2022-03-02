//
//  DevicesController.swift
//  1VALETChallenge
//
//  Created by Mac User on 2022-02-28.
//

import Foundation
import UIKit

class DevicesController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //this will be used to search stored device data
    @IBOutlet var searchBar: UISearchBar!
    //this table view will be used to display the current devices the user has
    @IBOutlet var tableView: UITableView!
    
    //the viewModel representing this controller
    private var devicesViewModel : DevicesViewModel!
    
    override func viewWillDisappear(_ animated: Bool) {
        //this will show the navbar on the device details page
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //this will hide the navbar for this page
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set-up the ViewModel for this class
        self.callToViewModelForUpdateUI()
        //set the searchbar delegate
        self.searchBar.delegate = self
        //set the tableview delegate
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    //MARK: UI related
    
    //this function will setup the Viewmodel and create the initial call to grab default devices
    func callToViewModelForUpdateUI(){
        self.devicesViewModel = DevicesViewModel()
        //bind the currentViewController that way we can dynamically update the data
        self.devicesViewModel.bindDevicesViewModelToController = {
            //if the data was set on the VM, update the data on the front end
            self.updateDataSource()
        }
        //create the initial call to grab the data
        //important this is after the bind call so we can receive data
        self.devicesViewModel.callToGetDeviceData()
    }
    
    
    func updateDataSource(){
        //UI change must be done on main thread
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: tableview methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1.grab the data for the path
        //2.init a controller and set the data
        //3.present the VC
        
        //grab the current data for selected row
        let currentData = self.devicesViewModel.devData[indexPath.row]

        //init the device details controller
        guard let controller = self.storyboard?.instantiateViewController(identifier: "deviceDetailsController") as? DeviceDetailsController else {
            fatalError()
        }
        
        //set the 'currentDevice' on the Vm to the device that was clicked on
        controller.currentDevice = currentData
        //set the presentation to fullscreen
        controller.modalPresentationStyle = .fullScreen
        //push the VC into the navigation controller
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //get rid of un-neccesary lines under the last item when there is not enough data to fill the page
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the total amount of devices in our array
        return self.devicesViewModel.devData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //grab the 'currentDevice' from our array
        let currentDevice = self.devicesViewModel.devData[indexPath.row]
        //init a reusableCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "deviceTableCell") as! DeviceTableViewCell? else {
            fatalError()
        }
        
        //using mutable string to create more informative text
        var myMutableString = NSMutableAttributedString()
        
        //check the value of the enum
        if currentDevice.status.rawValue == "Available" {
            
            //create a new attributed string
            myMutableString = NSMutableAttributedString(string: "Status: \(currentDevice.status.rawValue)", attributes: nil)
            //set the foreground attribute that way we can manipulate the text color
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.001247007969, green: 0.6028117069, blue: 0.0351134165, alpha: 1), range: NSRange(location:7,length: currentDevice.status.rawValue.count + 1))
            
        }else if currentDevice.status.rawValue == "Not Available"{
            
            //create a new attributed string
            myMutableString = NSMutableAttributedString(string: "Status: \(currentDevice.status.rawValue)", attributes: nil)
            //set the foreground attribute that way we can manipulate the text color
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), range: NSRange(location:7,length: currentDevice.status.rawValue.count + 1))
            
        }
        
        //set the data on the cell
        cell.deviceTitleLabel.text = currentDevice.title
        cell.deviceAvailabilityLabel.attributedText = myMutableString
        
        //return the cell
        return cell
    }
    
    
    
    //MARK: SearchField methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let searchText = searchBar.text else {
            fatalError()
        }
        devicesViewModel.searchForDevice(searchText: searchText)
        
    }
    
    
}
