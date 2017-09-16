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
    private var loadingIndicator: LoadingIndicatorProtocol?
    private var showRegistrationAction: ShowRegistrationAction?
    

    @IBOutlet weak var searchBar: SearchBar!
    
    
    func configure(presenter: LocationsPresenter,
                   dataSource: TableViewDataSource<UITableViewCell, LocationViewModel>,
                   loadingIndicator: LoadingIndicatorProtocol,
                   showRegistrationAction: ShowRegistrationAction) {
        self.presenter = presenter
        self.dataSource = dataSource
        self.loadingIndicator = loadingIndicator
        self.showRegistrationAction = showRegistrationAction
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeChanges()
        dataSource?.configure(tableView: tableView)
    }
    
    
    private func observeChanges() {
        
        searchBar.onEventChanged { [weak self] searchText in
            self?.loadingIndicator?.show(true)
            self?.presenter?.search(string: searchText)
        }

        presenter?.onEventNewLocations(block: { [weak self] viewModels, userInformation in
            self?.loadingIndicator?.show(false)
            self?.dataSource?.resetSections(title: userInformation, viewModels: [viewModels], cellIdentifier: reuseIdentifier)
            print(userInformation ?? "error dummy")
        })
        
        dataSource?.onEventConfigureCell { cell, viewModel in
            cell.textLabel?.text = viewModel.title
        }
        
        dataSource?.onEventItemSelected(selectCell: { [weak self] (viewModel, indexPath) in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            self?.showRegistrationAction?.perform(location: viewModel.location)
        })
    }

}
