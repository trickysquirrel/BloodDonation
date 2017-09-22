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
    
    private var dataSource: CollectionViewDataSource<BloodTypeCollectionViewCell,BloodTypeViewModel>?
    private var presenter: BloodTypePresenter?
    private var showLocationAction: ShowLocationAction?
    private var reporter: SelectBloodReporter?

    
    func configure(presenter: BloodTypePresenter,
                   dataSource: CollectionViewDataSource<BloodTypeCollectionViewCell,BloodTypeViewModel>,
                   showLocationAction: ShowLocationAction,
                   reporter: SelectBloodReporter) {
        self.title = Localisations.selectBloodTypeTitle.localised()
        self.presenter = presenter
        self.dataSource = dataSource
        self.showLocationAction = showLocationAction
        self.reporter = reporter
        dataSource.configure(collectionView: self.collectionView)
        observeChanges()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reporter?.viewShown()
        presenter?.updateView()
    }
    

    private func observeChanges() {
        
        presenter?.onEventUpdate{ [weak self] viewModels in
            self?.dataSource?.resetRows(viewModels: viewModels, cellIdentifier: reuseIdentifier)
        }
        
        dataSource?.onEventConfigureCell { (cell, viewModel) in
            cell.configure(viewModel: viewModel)
        }

        dataSource?.onEventItemSelected { [weak self] (viewModel, indexPath) in
            self?.showLocationAction?.perform(bloodType: viewModel.type)
        }
    }

}
