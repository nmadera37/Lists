//
//  ItemCell.swift
//  Lists
//
//  Created by Nate Madera on 1/6/20.
//  Copyright © 2020 Nate Madera. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    // MARK: UI Elements
    private var checkView: UIView!
    private var titleLabel: UILabel!
    
    // MARK: Constants
    private enum Constants {
        static let checkViewHeight = CGFloat(25.0)
    }
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    // MARK: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        checkView.layer.borderColor = isSelected ? UIColor.dodgerBlue.cgColor : UIColor.lightGray.cgColor
        checkView.backgroundColor = isSelected ? .dodgerBlue : .clear
    }
    
    func configure(with viewModel: String?) {
        titleLabel.text = viewModel
    }
}

// MARK: - Private Setup
private extension ItemCell {
    func setupView() {
        selectionStyle = .none
        
        // Add Views
        setupCheckView()
        setupTitleLabel()
        
        // Add Constraints
        addConstraintsForCheckView()
        addConstraintsForTitleLabel()
    }
    
    func setupCheckView() {
        let aView = UIView()
        aView.clipsToBounds = true
        aView.layer.cornerRadius = Constants.checkViewHeight / 2.0
        aView.layer.borderColor = UIColor.lightGray.cgColor
        aView.layer.borderWidth = 2.0
        
        checkView = aView
        
        addSubview(checkView)
    }
    
    func setupTitleLabel() {
        let aLabel = UILabel()
        
        titleLabel = aLabel
        
        addSubview(titleLabel)
    }
    
    // MARK: Layout Constraints
    func addConstraintsForCheckView() {
        checkView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0),
            checkView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkView.heightAnchor.constraint(equalToConstant: Constants.checkViewHeight),
            checkView.widthAnchor.constraint(equalToConstant: Constants.checkViewHeight)
        ])
    }
    
    func addConstraintsForTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: checkView.trailingAnchor, constant: 15.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25.0),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
