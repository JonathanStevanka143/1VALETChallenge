//
//  DevicesController.swift
//  1VALETChallenge
//
//  Created by Mac User on 2022-02-28.
//

import Foundation
import UIKit

class DevicesController: UIViewController {

    //this will be used to search stored device data
    @IBOutlet var searchBar: UISearchBar!
    //this table view will be used to display the current devices the user has
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
