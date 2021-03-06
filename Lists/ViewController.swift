//
//  ViewController.swift
//  Lists
//
//  Created by Nate Madera on 1/6/20.
//  Copyright © 2020 Nate Madera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: UI Elements
    private var tableView: UITableView!
    
    // MARK: Properties
    private var viewModel: ListViewModel
    
    // MARK: Constants
    private enum Constants {
        static let cellIdentifier = "listCell"
        static let separatorInset = UIEdgeInsets(top: 0.0, left: 60.0, bottom: 0.0, right: 0.0)
    }
    
    
    // MARK: Initializers
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

// MARK: - Actions
extension ViewController {
    @objc func tappedAdd() {
        print("Tapped add")
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? ItemCell else {
            fatalError("Unable to initialize cell.")
        }
        
        cell.configure(with: viewModel.titleForItem(at: indexPath))
        cell.textChanged = { _ in
            DispatchQueue.main.async {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        
        return cell
    }
}

// MARK: Private Setup
private extension ViewController {
    func setupView() {
        title = "List"
        
        // Add Views
        setupAddItemButton()
        setupTableView()
        
        // Constraints
        addConstraintsForTableView()
    }
    
    func setupAddItemButton() {
        let aButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tappedAdd))
        
        navigationItem.rightBarButtonItem = aButton
    }
    
    func setupTableView() {
        let aTableView = UITableView()
        aTableView.register(ItemCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        aTableView.rowHeight = UITableView.automaticDimension
        aTableView.estimatedRowHeight = 40.0
        aTableView.separatorInset = Constants.separatorInset
        aTableView.allowsMultipleSelection = true
        aTableView.dataSource = self
        
        tableView = aTableView
        
        view.addSubview(tableView)
    }
    
    // MARK: Layout Contraints
    func addConstraintsForTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
