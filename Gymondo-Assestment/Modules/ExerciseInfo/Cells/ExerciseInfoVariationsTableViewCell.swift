//
//  ExerciseInfoVariationsTableViewCell.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/22/1401 AP.
//

import UIKit
import Combine

class ExerciseInfoVariationsTableViewCell: UITableViewCell, Reusable {

    //MARK: - Properties -
    private lazy var collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
    private var variations = [String]()
    var selection: PassthroughSubject<Int, Never>?
    
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
    func bind(to viewModel: InfoViewModel?, with selection: PassthroughSubject<Int, Never>) {
        self.variations = viewModel?.variations.map( { "\($0)" }) ?? []
        collectionView.reloadData()
        self.selection = selection
    }

}
//MARK: - ViewCode -
extension ExerciseInfoVariationsTableViewCell: ViewCode {
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
        collectionView.register(cellType: ExerciseInfoTextCollectionViewCell.self)
    }
}
//MARK: - UICollectionViewDataSource -
extension ExerciseInfoVariationsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return variations.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ExerciseInfoTextCollectionViewCell.self)
        cell.bind(to: "var: " + variations[indexPath.item])
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout & UICollectionViewDelegate -
extension ExerciseInfoVariationsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selection?.send(indexPath.item)
    }
}
