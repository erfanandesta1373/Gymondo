//
//  ExerciseTableViewCell.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell, Reusable {

    private let exerciseImageView = UIImageView()
    private let name = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .none
        setupView()
    }

}

extension ExerciseTableViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(exerciseImageView)
        addSubview(name)
    }
    
    func setupConstraints() {
        exerciseImageView.pinLeft()
        exerciseImageView.pinEdgesVerticallyToSuperview(10)
        exerciseImageView.width(with: 50, comparator: .equalToConstant)
        exerciseImageView.squareViewConstraint()
        
        name.pinLeft(20, target: exerciseImageView)
        name.pinRight()
        name.centerVerticallyToSuperView()
    }
    
    func setupAdditionalConfiguration() {
        exerciseImageView.contentMode = .scaleAspectFill
        exerciseImageView.layer.cornerRadius = 8
    }
    
}
