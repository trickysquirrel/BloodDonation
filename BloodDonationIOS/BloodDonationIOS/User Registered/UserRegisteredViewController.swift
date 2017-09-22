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
    private var reporter: UserRegisteredReporter?
    
    
    func configure(presenter: UserRegisteredPresenter,
                   areYouSureAlert: AreYouSureAlert,
                   informationAlert: InformationAlert?,
                   unreigisterAction: Action,
                   reporter: UserRegisteredReporter) {
        self.presenter = presenter
        self.areYouSureAlert = areYouSureAlert
        self.informationAlert = informationAlert
        self.unreigisterAction = unreigisterAction
        self.reporter = reporter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reporter?.viewShown()
    }

    
    @IBAction func userDidSelectToResetData() {
        areYouSureAlert?.displayAlertTitle(title: Localisations.alertTitleWarning.localised(),
                                           message: Localisations.alertMsgUnRegister.localised(),
                                           presentingViewController: self,
                                           continueActionSelected: { [weak self] in
            self?.resetUser()
        })
    }
    
    
    private func updateView() {
        presenter?.updateView(completion: { [weak self] viewModel in
            guard let registrationView = self?.view as? RegistrationView else { return }
            registrationView.configure(viewModel: viewModel)
        })
    }
    
    
    private func resetUser() {
        if let errorMessage = self.presenter?.resetUser() {
            self.informationAlert?.displayAlert(title: Localisations.alertTitleError.localised(),
                                                          message: errorMessage,
                                                          presentingViewController: self)
        }
        else {
            self.unreigisterAction?.perform()
        }
    }
    
}
