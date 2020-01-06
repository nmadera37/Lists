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
    private var textView: UITextView!
    
    var textChanged: ((String) -> Void)?
    
    // MARK: Constants
    private enum Constants {
        static let padding = CGFloat(15.0)
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
        textView.text = viewModel
    }
}

extension ItemCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
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
        let aTextView = UITextView()
        aTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        aTextView.font = UIFont.systemFont(ofSize: 20.0)
        aTextView.isScrollEnabled = false
        aTextView.delegate = self
        
        textView = aTextView
        
        addSubview(textView)
    }
    
    // MARK: Layout Constraints
    func addConstraintsForCheckView() {
        checkView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            checkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            checkView.topAnchor.constraint(equalTo: topAnchor, constant: 15.0),
            checkView.heightAnchor.constraint(equalToConstant: Constants.checkViewHeight),
            checkView.widthAnchor.constraint(equalToConstant: Constants.checkViewHeight)
        ])
    }
    
    func addConstraintsForTitleLabel() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: checkView.trailingAnchor, constant: Constants.padding),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0)
        ])
    }
}
