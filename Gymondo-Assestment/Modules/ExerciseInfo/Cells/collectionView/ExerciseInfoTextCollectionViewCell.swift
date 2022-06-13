//
//  ExerciseInfoTextCollectionViewCell.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/22/1401 AP.
//

import UIKit
import Combine

class ExerciseInfoTextCollectionViewCell: UICollectionViewCell, Reusable {
    
    //MARK: - Properties -
    private let textLabel = UILabel()
    private var cancellable: AnyCancellable?
    
    //MARK: - Overrides -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    //MARK: - Methods -
    func bind(to text: String) {
        textLabel.text = text
    }
}
//MARK: - ViewCode -
extension ExerciseInfoTextCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(textLabel)
    }
    func setupConstraints() {
        textLabel.pinEdgesToSuperview()
    }
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor(named: "primary")
        layer.cornerRadius = 25
        textLabel.textAlignment = .center
    }
}
