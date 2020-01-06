//
//  ListViewModel.swift
//  Lists
//
//  Created by Nate Madera on 1/6/20.
//  Copyright © 2020 Nate Madera. All rights reserved.
//

import Foundation

// MARK: Protocol
protocol ListViewModelProtocol {
    func numberOfItems(in section: Int) -> Int
    func titleForItem(at indexPath: IndexPath) -> String?
}

// MARK: View Model
struct ListViewModel {
    
    // MARK: Properties
    private var items: [String]
    
    // MARK: Initializers
    init(items: [String] = [String]()) {
        self.items = items
    }
}

// MARK: Protocol Functions
extension ListViewModel: ListViewModelProtocol {
    func numberOfItems(in section: Int) -> Int {
        return items.count
    }
    
    func titleForItem(at indexPath: IndexPath) -> String? {
        guard items.indices.contains(indexPath.row) else { return nil }
        
        return items[indexPath.row]
    }
}
