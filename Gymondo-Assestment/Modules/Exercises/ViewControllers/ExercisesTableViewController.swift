//
//  ExercisesTableViewController.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit
import Combine

class ExercisesTableViewController: UITableViewController {

    //MARK: - Properties -
    private let viewModel: ExercisesViewModel
    private let appear = PassthroughSubject<Void, Never>()
    private let selection = PassthroughSubject<Int, Never>()
    private var cancellables = [AnyCancellable]()
    private var exercise: [ExerciseViewModel] = []
    
    init(viewModel: ExercisesViewModel) {
        self.viewModel = viewModel
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
        appear.send()
    }
    
    //MARK: - Methods -
    private func setupView() {
        title = "Exercises"
        tableView.separatorStyle = .none
        tableView.register(cellType: ExerciseTableViewCell.self)
    }
    func bind(to viewModel: ExercisesViewModel) {
        let input = ExercisesViewModelInput(appear: appear, selection: selection)
        let output = viewModel.transform(input: input)
        
        output.sink { [weak self] state in
            switch state {
            case .success(let exercises):
                self?.exercise = exercises
                self?.tableView.reloadData()
            case .noResults:
                // show empty view
                break
            case .failure(let error):
                // show error alert
                print(error)
            }
        }.store(in: &cancellables)
    }

    // MARK: - Table view data source and delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercise.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ExerciseTableViewCell.self)
        cell.bind(to: exercise[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection.send(exercise[indexPath.row].id)
    }
}
