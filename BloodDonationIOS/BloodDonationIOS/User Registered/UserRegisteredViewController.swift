//
//  UserRegisteredViewController.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class UserRegisteredViewController: UIViewController {

    private var presenter: UserRegisteredPresenter?
    private var areYouSureAlert: AreYouSureAlert?
    private var informationAlert: InformationAlert?
    private var unreigisterAction: Action?
    
    
    func configure(presenter: UserRegisteredPresenter,
                   areYouSureAlert: AreYouSureAlert,
                   informationAlert: InformationAlert?,
                   unreigisterAction: Action) {
        self.presenter = presenter
        self.areYouSureAlert = areYouSureAlert
        self.informationAlert = informationAlert
        self.unreigisterAction = unreigisterAction
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView(completion: { [weak self] viewModel in
            guard let registrationView = self?.view as? RegistrationView else { return }
            registrationView.configure(viewModel: viewModel)
        })
    }
    
    
    @IBAction func userDidSelectToResetData() {
        areYouSureAlert?.displayAlertTitle(title: Localisations.alertTitleWarning.localised(),
                                           message: Localisations.alertMsgUnRegister.localised(),
                                           presentingViewController: self,
                                           continueActionSelected: { [weak self] in
            self?.resetUser()
        })
    }
    
    
    private func resetUser() {
        
        if let errorMessage = self.presenter?.resetUser() {

            self.informationAlert?.displayErrorAlertTitle(title: Localisations.alertTitleError.localised(),
                                                          message: errorMessage,
                                                          presentingViewController: self)
        }
        else {
            self.unreigisterAction?.perform()
        }
    }
    
}
