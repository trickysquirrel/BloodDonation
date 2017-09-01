//
//  BloodTypeCollectionViewController.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BloodTypeCellId"

class BloodTypeCollectionViewController: UICollectionViewController {
    
    private let dataSource = CollectionViewDataSource<BloodTypeCollectionViewCell,BloodTypeViewModel>()
    private var presenter: BloodTypePresenter?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bloodTypeSelection = BloodTypeSelection()
        presenter = BloodTypePresenter(bloodTypeSelection: bloodTypeSelection)
        dataSource.configure(collectionView: self.collectionView)
        observeCollectionViewChanges()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let viewModels = presenter?.updateView() {
            dataSource.resetRows(viewModels: viewModels, cellIdentifier: reuseIdentifier)
        }
    }
    

    private func observeCollectionViewChanges() {
        
        dataSource.onEventConfigureCell { (cell, viewModel) in
            cell.configure(viewModel: viewModel)
        }

        dataSource.onEventItemSelected { (viewModel, indexPath) in
            print("perform next thing")
        }
    }

}
