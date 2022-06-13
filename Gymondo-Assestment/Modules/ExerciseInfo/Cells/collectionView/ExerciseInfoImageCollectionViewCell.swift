//
//  ExerciseInfoImageCollectionViewCell.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/22/1401 AP.
//

import UIKit
import Combine

class ExerciseInfoImageCollectionViewCell: UICollectionViewCell, Reusable {
    
    //MARK: - Properties -
    private let imageView = UIImageView()
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
    func bind(to image: AnyPublisher<UIImage, Never>) {
        cancelImageLoading()
        cancellable = image.sink(receiveValue: { [unowned self] image in
            self.imageView.image = image
        })
    }
    private func cancelImageLoading() {
        imageView.image = nil
        cancellable?.cancel()
    }
}
//MARK: - ViewCode -
extension ExerciseInfoImageCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(imageView)
    }
    func setupConstraints() {
        imageView.pinEdgesToSuperview()
    }
    func setupAdditionalConfiguration() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.backgroundColor = UIColor(named: "primary")
    }
}
