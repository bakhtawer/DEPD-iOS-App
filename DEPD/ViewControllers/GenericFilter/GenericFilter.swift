//
//  GenericFilter.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/10/2024.
//

import UIKit

// Enum for filter types
enum FilterType {
    case checkbox
    case dropdown
    case multiSelect
}

// Model to represent each filter item
class FilterItem {
    let type: FilterType
    let title: String
    let name: String
    var value: Any?  // Selected value(s)
    let options: [String]
    
    init(type: FilterType, title: String, name: String, options: [String] = [], defaultValue: Any? = nil) {
        self.type = type
        self.title = title
        self.options = options
        self.value = defaultValue
        self.name = name
    }
}

protocol FilterViewControllerDelegate: AnyObject {
    func didApplyFilters(selectedOptions: [String: Any])
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: FilterViewControllerDelegate?
    
    // Holds filter items with their selected values
    var filterItems: [FilterItem] = []
    var selectedOptions: [String: Any] = [:]
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
        view.backgroundColor = .white
        if !selectedOptions.isEmpty {
            for item in filterItems {
                item.value = selectedOptions[item.name]
            }
        }
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilterCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetButtonTapped))
    }
    
    @objc private func doneButtonTapped() {
        // Confirm all values in filterItems to selectedOptions dictionary
        for item in filterItems {
            selectedOptions[item.name] = item.value
        }
        print("Selected Options:", selectedOptions)  // Print selected options dictionary
        delegate?.didApplyFilters(selectedOptions: selectedOptions)
        dismiss(animated: true)
    }
    
    @objc private func resetButtonTapped() {
        // Reset each filterItem's value to nil
        for item in filterItems {
            item.value = nil
        }
        selectedOptions.removeAll()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "FilterCell")
        let filterItem = filterItems[indexPath.row]
        
        cell.textLabel?.text = filterItem.title
        cell.accessoryType = .none
        cell.detailTextLabel?.text = nil  // Reset detail text for reuse
        cell.accessoryView = nil
        
        switch filterItem.type {
        case .checkbox:
            let switchControl = UISwitch()
            switchControl.isOn = (filterItem.value as? Bool) ?? false
            switchControl.tag = indexPath.row
            switchControl.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
            cell.accessoryView = switchControl
            cell.detailTextLabel?.text = switchControl.isOn ? "" : ""
            
        case .dropdown:
            cell.accessoryType = .disclosureIndicator
            cell.detailTextLabel?.text = filterItem.value as? String ?? ""
            
        case .multiSelect:
            cell.accessoryType = .disclosureIndicator
            if let selectedOptions = filterItem.value as? [String], !selectedOptions.isEmpty {
                cell.detailTextLabel?.text = selectedOptions.joined(separator: ", ").replacingOccurrences(of: "\r\n", with: "")
            } else {
                cell.detailTextLabel?.text = ""
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filterItem = filterItems[indexPath.row]
        
        if filterItem.type == .dropdown || filterItem.type == .multiSelect {
            showOptions(for: filterItem, at: indexPath)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc private func switchToggled(_ sender: UISwitch) {
        let filterItem = filterItems[sender.tag]
        filterItem.value = sender.isOn
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    
    private func showOptions(for filterItem: FilterItem, at indexPath: IndexPath) {
        let optionsVC = OptionsViewController(filterItem: filterItem) { selectedValue in
            filterItem.value = selectedValue
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        navigationController?.pushViewController(optionsVC, animated: true)
    }
}



// MARK: - OptionsViewController

class OptionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let filterItem: FilterItem
    var completion: ((Any?) -> Void)?
    let tableView = UITableView()
    
    init(filterItem: FilterItem, completion: @escaping (Any?) -> Void) {
        self.filterItem = filterItem
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
        title = filterItem.title
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterItem.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let option = filterItem.options[indexPath.row]
        
        cell.textLabel?.text = option
        cell.accessoryType = .none
        
        if filterItem.type == .multiSelect {
            let selectedOptions = filterItem.value as? [String] ?? []
            cell.accessoryType = selectedOptions.contains(option) ? .checkmark : .none
        } else if filterItem.type == .dropdown {
            cell.accessoryType = (filterItem.value as? String) == option ? .checkmark : .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = filterItem.options[indexPath.row]
        
        if filterItem.type == .multiSelect {
            var selectedOptions = filterItem.value as? [String] ?? []
            if selectedOptions.contains(option) {
                selectedOptions.removeAll { $0 == option }
            } else {
                selectedOptions.append(option)
            }
            filterItem.value = selectedOptions
        } else {
            filterItem.value = option
            tableView.reloadData()
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completion?(filterItem.value)
    }
}
