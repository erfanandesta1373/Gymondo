//
//  ViewCode.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import Foundation

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupView()
    func setupAdditionalConfiguration()
}

// MARK: - Setup View method

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}

// MARK: - Default implementation to make it `optional`

extension ViewCode {
    func setupAdditionalConfiguration() {}
}
