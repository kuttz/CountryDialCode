//
//  DialCodePickerViewController.swift
//  CountryCodes
//
//  Created by Sreekuttan D on 09/07/23.
//

import UIKit
import CountryDialCode

protocol DialCodePickerDelegate: AnyObject {
    func didSelect(dialCode: CountryCode)
}

class DialCodePickerViewController: UITableViewController {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var dialCodes: [CountryCode] = []
    
    fileprivate var searchList: [CountryCode] = []
    
    fileprivate let cellID: String = "CountryCodeCell"
    
    var selectedCode: String? = ""
    
    weak var delegate: DialCodePickerDelegate?
    
    init(dialCodes: [CountryCode], selected: String? = nil) {
        super.init(style: .insetGrouped)
        self.dialCodes = dialCodes
        self.selectedCode = selected
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        searchController.searchBar.isTranslucent = false
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchBarStyle = .minimal
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        
        navigationItem.searchController = searchController
        navigationItem.title = "Select Dial Code"
        navigationItem.rightBarButtonItem = done
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.keyboardDismissMode = .onDrag

    }
    
    @objc fileprivate func doneAction() {
        self.dismiss(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchList.count : dialCodes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let dialCode = searchController.isActive ? searchList[indexPath.row] : dialCodes[indexPath.row]
        var config = UIListContentConfiguration.valueCell()
        config.text = dialCode.flag() + " " + (dialCode.localizedName ?? "")
        config.secondaryText = dialCode.dialCode
        
        cell.accessoryType = selectedCode == dialCode.dialCode ? .checkmark : .none
        cell.contentConfiguration = config

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dialCode = searchController.isActive ? searchList[indexPath.row] : dialCodes[indexPath.row]
        delegate?.didSelect(dialCode: dialCode)
        searchController.isActive = false
        self.dismiss(animated: true)
    }

}

// MARK: - UISearchResultsUpdating
extension DialCodePickerViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // your search operation
        updateSearch()
    }
    
    func updateSearch() {
        let searchText = searchController.searchBar.text ?? ""
        
        if searchText.isEmpty {
            searchList = dialCodes
        } else {
            searchList = dialCodes.filter {
                $0.name.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil ||
                $0.dialCode.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil
            }
        }
        tableView.reloadData()
    }
    
}

