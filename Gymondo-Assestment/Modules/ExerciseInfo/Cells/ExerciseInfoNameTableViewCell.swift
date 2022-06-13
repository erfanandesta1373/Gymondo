//
//  ExerciseInfoNameTableViewCell.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/22/1401 AP.
//

import UIKit

class ExerciseInfoNameTableViewCell: UITableViewCell, Reusable {

    //MARK: - Properties -
    let nameLabel = UILabel()
    
    //MARK: - Overrides -
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
    
    //MARK: - Methods -
    func setData(name: String) {
        nameLabel.text = name
    }

}
//MARK: - ViewCode -
extension ExerciseInfoNameTableViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(nameLabel)
    }
    func setupConstraints() {
        nameLabel.pinEdgesToSuperview(12)
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    func setupAdditionalConfiguration() {
        nameLabel.numberOfLines = 0
    }
}
