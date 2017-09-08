//
//  LocationTableViewController.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

private let reuseIdentifier = "LocationTypeCellId"

class LocationTableViewController: UITableViewController {

    private var dataSource: TableViewDataSource<UITableViewCell, LocationViewModel>?
    private var presenter: LocationsPresenter?
    @IBOutlet weak var searchBar: SearchBar!
    
    
    func configure(presenter: LocationsPresenter,
                   dataSource: TableViewDataSource<UITableViewCell, LocationViewModel>) {
        self.presenter = presenter
        self.dataSource = dataSource
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeChanges()
        dataSource?.configure(tableView: tableView)
    }
    
    
    private func observeChanges() {
        
        searchBar.onEventChanged { [weak self] searchText in
            self?.presenter?.search(string: searchText)
        }

        presenter?.onSearchResultsEvent(updateBlock: { [weak self] viewModels in
            self?.dataSource?.resetSections(viewModels: [viewModels], cellIdentifier: reuseIdentifier)
        })
        
        dataSource?.onEventConfigureCell { cell, viewModel in
            cell.textLabel?.text = viewModel.title
        }
        
        dataSource?.onEventItemSelected(selectCell: { [weak self] (viewModel, indexPath) in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        })
    }

}
