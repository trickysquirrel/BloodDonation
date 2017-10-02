//
//  RegistrationViewController.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

	@IBOutlet weak var confirmationButton: TransitionButton!
    private var presenter: RegistrationPresenter?
    private var alert: InformationAlert?
    private var showUserRegisteredAction: Action?
    private var reporter: RegisterReporter?
    
    
    func configure(presenter: RegistrationPresenter, alert: InformationAlert, showUserRegisteredAction: Action?, reporter: RegisterReporter) {
        self.presenter = presenter
        self.alert = alert
        self.showUserRegisteredAction = showUserRegisteredAction
        self.reporter = reporter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		configureConfirmationButton()
        updateView()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reporter?.viewShown()
    }
    
    
    private func updateView() {
        presenter?.updateView(completion: { [weak self] response in
            self?.handlePresenterResponse(response: response)
        })
    }
    
    
    @IBAction func userSelectedConfirmationButton() {
		confirmationButton.startAnimation()
        presenter?.registerUser(completion: { [weak self] response in
            self?.handlePresenterResponse(response: response)
        })
    }
    
    // TODO: show a please wait while we register
    private func handlePresenterResponse(response: RegistrationResponse) {
        guard let registrationView = view as? RegistrationView else { return }
        switch response {
        case .updateView(let viewModel):
            registrationView.configure(viewModel: viewModel)
        case .registrationSuccess:
			confirmationButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 0.5, completion: {
				self.showUserRegisteredAction?.perform()
			})
        case .error(let errorMessage):
			confirmationButton.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.2, completion: nil)
            self.alert?.displayAlert(title: Localisations.alertTitleError.localised(),
                                               message: errorMessage,
                                               presentingViewController: self)
        }
    }

}

extension RegistrationViewController {

	func configureConfirmationButton() {
		confirmationButton.cornerRadius = confirmationButton.frame.size.height / 2
		confirmationButton.spinnerColor = .white
	}

}
