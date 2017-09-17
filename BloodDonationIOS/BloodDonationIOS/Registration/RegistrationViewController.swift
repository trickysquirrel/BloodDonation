//
//  RegistrationViewController.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private var presenter: RegistrationPresenter?

    func configure(presenter: RegistrationPresenter) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView() {
        guard   let viewModel = presenter?.updateView(),
                let registrationView = view as? RegistrationView else {
                return
        }
        registrationView.configure(viewModel: viewModel)
    }

}
