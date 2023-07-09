//
//  ViewController.swift
//  CountryCodes
//
//  Created by Sreekuttan D on 26/06/23.
//

import UIKit
import CountryDialCode

class ViewController: UIViewController {
    
    @IBOutlet weak var countryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let country = CountryDialCode.current()
        updateLabel(with: country)
    }
    
    fileprivate func updateLabel(with country: CountryCode?) {
        guard let country = country,
              let name = country.localizedName else {
            return
        }
        countryLabel.text = String(describing: country.flag()) + " (" + country.dialCode + ")" + " " +  name
    }

    @IBAction func openDialCodePicker(_ sender: Any) {
        
        let dialCodes = CountryDialCode.getAllCodes()
        let selected = CountryDialCode.current()?.dialCode
        let pickerVC = DialCodePickerViewController(dialCodes: dialCodes,selected: selected)
        pickerVC.delegate = self
        
        showDetailViewController(UINavigationController(rootViewController: pickerVC), sender: self)
    }
}

// MARK: - DialCodePickerDelegate
extension ViewController: DialCodePickerDelegate {
    
    func didSelect(dialCode: CountryCode) {
        updateLabel(with: dialCode)
    }
}
