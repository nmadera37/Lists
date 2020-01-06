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
        static let cellIdentifier = "cell"
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

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = viewModel.titleForItem(at: indexPath)
        
        return cell
    }
}

// MARK: Private Setup
private extension ViewController {
    func setupView() {
        title = "List"
        
        // Add Views
        setupTableView()
        
        // Constraints
        addConstraintsForTableView()
    }
    
    func setupTableView() {
        let aTableView = UITableView()
        aTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
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
