//
//  ExerciseInfoImagesTableViewCell.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/22/1401 AP.
//

import UIKit
import Combine

class ExerciseInfoImagesTableViewCell: UITableViewCell, Reusable {

    //MARK: - Properties -
    lazy var collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
    var images = [AnyPublisher<UIImage, Never>]()
    
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
    func bind(to viewModel: InfoViewModel?) {
        images = viewModel?.images ?? []
        collectionView.reloadData()
    }

}
//MARK: - ViewCode -
extension ExerciseInfoImagesTableViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(collectionView)
    }
    func setupConstraints() {
        collectionView.pinEdgesToSuperview(12)
    }
    func setupAdditionalConfiguration() {
        collectionView.dataSource = self
        collectionView.delegate = self
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.register(cellType: ExerciseInfoImageCollectionViewCell.self)
    }
}
//MARK: - UICollectionViewDataSource -
extension ExerciseInfoImagesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ExerciseInfoImageCollectionViewCell.self)
        cell.bind(to: images[indexPath.item])
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout & UICollectionViewDelegate -
extension ExerciseInfoImagesTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
