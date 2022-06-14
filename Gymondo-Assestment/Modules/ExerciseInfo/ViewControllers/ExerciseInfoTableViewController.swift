//
//  ExerciseInfoTableViewController.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/22/1401 AP.
//

import UIKit
import Combine

class ExerciseInfoTableViewController: UITableViewController {

    enum Row: CaseIterable {
        case name
        case images
        case variations
    }
    
    //MARK: - Properties -
    let viewModel: ExerciseInfoViewModelProtocol
    let appear: CurrentValueSubject<Int, Never>
    private let selection = PassthroughSubject<Int, Never>()
    private var cancellables = [AnyCancellable]()
    var exercise: InfoViewModel?
    
    init(viewModel: ExerciseInfoViewModelProtocol, id: Int) {
        self.viewModel = viewModel
        self.appear = CurrentValueSubject<Int, Never>(id)
        super.init(nibName: nil, bundle: nil)
    }
    
    //MARK: - Overrides -
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind(to: viewModel)
    }
    
    //MARK: - Methods -
    private func setupView() {
        title = "Exercise Info"
        
        tableView.separatorStyle = .none
        tableView.register(cellType: ExerciseInfoNameTableViewCell.self)
        tableView.register(cellType: ExerciseInfoImagesTableViewCell.self)
        tableView.register(cellType: ExerciseInfoVariationsTableViewCell.self)
    }
    
    func bind(to viewModel: ExerciseInfoViewModelProtocol) {
        let input = ExerciseInfoViewModelInput(appear: appear, selection: selection)
        let output = viewModel.transform(input: input)
        
        output.sink { [weak self] state in
            switch state {
            case .success(let exercise):
                self?.exercise = exercise
                self?.tableView.reloadData()
            case .failure(let error):
                // show error alert
                print(error)
            }
        }.store(in: &cancellables)
    }

    // MARK: - Table view data source and delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = Row.allCases[indexPath.row]
        switch row {
        case .name:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ExerciseInfoNameTableViewCell.self)
            cell.setData(name: exercise?.name ?? "")
            return cell
        case .images:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ExerciseInfoImagesTableViewCell.self)
            cell.bind(to: exercise)
            return cell
        case .variations:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ExerciseInfoVariationsTableViewCell.self)
            cell.bind(to: exercise, with: selection)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = Row.allCases[indexPath.row]
        switch row {
        case .name:
            return 50
        case .images:
            return 120
        case .variations:
            return 90
        }
    }
}
