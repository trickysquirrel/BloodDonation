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
    private var alert: InformationAlert?
    
    func configure(presenter: RegistrationPresenter, alert: InformationAlert) {
        self.presenter = presenter
        self.alert = alert
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    
    private func updateView() {
        presenter?.updateView(completion: { [weak self] response in
            self?.handlePresenterResponse(response: response)
        })
    }
    
    
    @IBAction func userSelectedConfirmationButton() {
        presenter?.registerUser(completion: { [weak self] response in
            self?.handlePresenterResponse(response: response)
        })
    }
    
    
    private func handlePresenterResponse(response: RegistrationResponse) {
        guard let registrationView = view as? RegistrationView else { return }
        switch response {
        case .updateView(let viewModel):
            registrationView.configure(viewModel: viewModel)
        case .registrationSuccess:
            print("registration success")
        case .error(let errorMessage):
            self.alert?.displayErrorAlertTitle(title: Localisations.alertTitleError.localised(),
                                               message: errorMessage,
                                               presentingViewController: self)
        }
    }

}
