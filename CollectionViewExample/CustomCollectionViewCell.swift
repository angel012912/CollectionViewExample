//
//  CustomCollectionViewCell.swift
//  CollectionViewExample
//
//  Created by Angel Garcia on 27/06/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 1
        return stackView
    }()
    
    private let deviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let deviceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(deviceImageView)
        mainStackView.addArrangedSubview(deviceNameLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints(){
        
       let mainStackViewConstraints = [
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
        ]
        
        let constraints = [mainStackViewConstraints]
        constraints.forEach { constraint in
            NSLayoutConstraint.activate(constraint)
        }
    }
    
    public func configure(model: Device){
        deviceImageView.image = UIImage(systemName: model.imageName)
        deviceNameLabel.text = model.title
    }
}
