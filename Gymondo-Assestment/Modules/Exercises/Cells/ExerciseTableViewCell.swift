//
//  ExerciseTableViewCell.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit
import Combine

class ExerciseTableViewCell: UITableViewCell, Reusable {

    //MARK: - Properties -
    private let exerciseImageView = UIImageView()
    private let nameLabel = UILabel()
    private var cancellable: AnyCancellable?
    
    //MARK: - Overrides -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .none
        setupView()
    }

    //MARK: - Methods -
    func bind(to exerciseViewModel: ExerciseViewModel) {
        cancelImageLoading()
        nameLabel.text = exerciseViewModel.name
        cancellable = exerciseViewModel.image.sink(receiveValue: { [unowned self] image in
            self.exerciseImageView.image = image
        })
    }

    private func cancelImageLoading() {
        exerciseImageView.image = nil
        cancellable?.cancel()
    }
}
//MARK: - ViewCode -
extension ExerciseTableViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(exerciseImageView)
        addSubview(nameLabel)
    }
    
    func setupConstraints() {
        exerciseImageView.pinLeft(12)
        exerciseImageView.pinEdgesVerticallyToSuperview(10)
        exerciseImageView.width(with: 50, comparator: .equalToConstant)
        exerciseImageView.squareViewConstraint()
        
        nameLabel.pinLeft(20, target: exerciseImageView)
        nameLabel.pinRight(12)
        nameLabel.centerVerticallyToSuperView()
    }
    
    func setupAdditionalConfiguration() {
        exerciseImageView.contentMode = .scaleAspectFit
        exerciseImageView.layer.cornerRadius = 8
        exerciseImageView.clipsToBounds = true
        
        nameLabel.numberOfLines = 0
    }
    
}
