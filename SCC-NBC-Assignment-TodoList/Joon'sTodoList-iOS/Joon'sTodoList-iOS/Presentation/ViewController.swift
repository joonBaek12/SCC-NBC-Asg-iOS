//
//  ViewController.swift
//  Joon'sTodoList-iOS
//
//  Created by Joon Baek on 2023/12/15.
//

import UIKit

import RxSwift

// MARK: - ViewController

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = ViewModel()
    
    // MARK: - UI Properties
    
    private lazy var titleLabel: UILabel = { createTitleLabel() }()
    private lazy var todoTableView: UITableView = { createTodoTableView() }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setLayout()
    }
}

// MARK: - Extensions

extension ViewController {
    private func setLayout() {
        [titleLabel, todoTableView].forEach { view.addSubview($0) }
        
        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            todoTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            todoTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "Joons TodoList"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }
    
    private func createTodoTableView() -> UITableView {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        // .self 왜 붙여야댐?
        tableView.register(UITableView.self, forCellReuseIdentifier: "TodoTableViewCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as? TodoTableViewCell else { return UITableViewCell()
        }
        
        return cell
    }
}
