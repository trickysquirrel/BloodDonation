//
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class SelectRegionViewController: UIViewController {

    @IBOutlet weak var regionPicker: UIPickerView!
    private var presenter: SelectRegionPresenter?
    private var viewModels: [RegionViewModel] = []
    private var showLocationAction: ShowLocationAction?

    func configure(presenter: SelectRegionPresenter, actions: ShowLocationAction) {
        self.presenter = presenter
        self.showLocationAction = actions
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter?.navigationTitle()
        regionPicker.dataSource = self
        regionPicker.delegate = self
        viewModels = presenter?.updateView() ?? []
        regionPicker.reloadAllComponents()
    }
}


extension SelectRegionViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModels[safe: row]?.title ?? ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let countryCode = viewModels[safe: row]?.countryCode ?? .unknown
        if countryCode != .unknown {
            showLocationAction?.perform(bloodType: .oPositive, countryCode: countryCode)
        }
    }
}


extension SelectRegionViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModels.count
    }
}
