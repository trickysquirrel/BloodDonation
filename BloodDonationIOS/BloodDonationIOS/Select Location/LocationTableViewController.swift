//
//  LocationTableViewController.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: SearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeChanges()
    }
    
    private func observeChanges() {
        searchBar.onEventChanged { searchText in
            print("search for \(searchText)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
