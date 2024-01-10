//
//  ViewController.swift
//  Joon'sTodoList-iOS
//
//  Created by Joon Baek on 2023/12/15.
//

import UIKit

// MARK: - ViewController

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var model: Model?
    
    // MARK: - UI Properties
    
    private lazy var titleLabel: UILabel = { createTitleLabel() }()
    private lazy var todoTableView: UITableView = { createTodoTableView() }()
    
    // MARK: - Life Cycle
    
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setupTableHeaderAndFooterView()
        registerCells()
        setDelegates()
    }
}

// MARK: - Extensions

extension ViewController {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setDelegates() {
        // 다운캐스팅이 필요한 이유
        if let headerView = todoTableView.tableHeaderView as? AddTaskHeaderView {
            headerView.delegate = self
        }
        
        if let footerView = todoTableView.tableFooterView as? ClearTasksFooterView {
            footerView.delegate = self
        }
    }
    
    private func setLayout() {
        navigationController?.navigationBar.isHidden = true
        
        [titleLabel, todoTableView].forEach { view.addSubview($0) }
        
        // Constraints
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            todoTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            todoTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    private func setupTableHeaderAndFooterView() {
        let headerView = AddTaskHeaderView()
        let footerView = ClearTasksFooterView()
        
        headerView.frame = CGRect(x: 0, y: 0, width: todoTableView.bounds.width, height: 50)
        headerView.indexPath = IndexPath(row: 0, section: 0)
        todoTableView.tableHeaderView = headerView
        
        footerView.frame = CGRect(x: 0, y: 0, width: todoTableView.bounds.width, height: 50)
        todoTableView.tableFooterView = footerView
    }
    
    private func registerCells() {
        todoTableView.register(AddTaskHeaderView.self, forHeaderFooterViewReuseIdentifier: "AddTaskHeaderView")
        todoTableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
        todoTableView.register(ClearTasksFooterView.self, forHeaderFooterViewReuseIdentifier: "ClearTasksFooterView")
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Joons TodoList"
        label.font = .boldSystemFont(ofSize: 26)
        label.textColor = .black
        
        return label
    }
    
    private func createTodoTableView() -> UITableView {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        return tableView
    }
}

// MARK: - Delegates

extension ViewController: AddTaskHeaderViewDelegate {
    func addTaskButtonTapped(with text: String, at indexPath: IndexPath) {
        model?.addTodo(with: text)
        todoTableView.reloadData()
    }
}

extension ViewController: ClearTasksFooterViewDelegate {
    func numberOfPendingTasks() -> Int {
        model?.numberOfTodos() ?? 0
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let emptyHeaderView = UIView()

        return emptyHeaderView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let emptyFoorterView = UIView()

        return emptyFoorterView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model?.deleteTodo(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = model?.numberOfTodos() ?? 0
        let footerView = tableView.tableFooterView as? ClearTasksFooterView
        
        footerView?.updateDescriptionLabel()
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as? TodoTableViewCell else {
            return UITableViewCell()
        }
        
        let todoText = model?.getTodo(at: indexPath.row)
        cell.configureTodoLabel(with: todoText ?? "")
        cell.indexPath = indexPath
        
        return cell
    }
}
