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

    
    func configure(presenter: BloodTypePresenter) {
        self.presenter = presenter
        dataSource.configure(collectionView: self.collectionView)
        observeChanges()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.updateView()
    }
    

    private func observeChanges() {
        
        presenter?.onEventUpdate{ [weak self] viewModels in
            self?.dataSource.resetRows(viewModels: viewModels, cellIdentifier: reuseIdentifier)
        }
        
        dataSource.onEventConfigureCell { (cell, viewModel) in
            cell.configure(viewModel: viewModel)
        }

        dataSource.onEventItemSelected { [weak self] (viewModel, indexPath) in
            self?.presenter?.updateBloodType(viewModel.type)
        }
    }

}
