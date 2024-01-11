//
//  ViewControllerWithRx.swift
//  TodoList
//
//  Created by Joon Baek on 2023/12/19.
//

import UIKit

import RxSwift
import RxCocoa

final class ViewControllerWithRx: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    var viewModel: ViewModelWithRx?
    
    // MARK: - UI Properties
    
    private lazy var titleLabel: UILabel = { createTitleLabel() }()
    private lazy var todoTableView: UITableView = { createTodoTableView() }()
    
    // MARK: - Life Cycle
    
    init(viewModel: ViewModelWithRx) {
        self.viewModel = viewModel
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
        bindViewModel()
    }
}

// MARK: - Extensions

extension ViewControllerWithRx {
    
    // MARK: - Layout Helpers
    
    private func setUI() {
        view.backgroundColor = .white
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
        footerView.frame = CGRect(x: 0, y: 0, width: todoTableView.bounds.width, height: 50)
        
        todoTableView.tableHeaderView = headerView
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
        tableView.backgroundColor = .clear
        
        return tableView
    }
}

// MARK: - Delegates

extension ViewControllerWithRx: AddTaskHeaderViewDelegate {
    func addTaskButtonTapped(with text: String, at indexPath: IndexPath) {
        viewModel?.addTodo(with: text)
        todoTableView.reloadData()
    }
}

//extension ViewControllerWithRx: ClearTasksFooterViewDelegate {
//    func numberOfPendingTasks() -> Int {
//        return viewModel?.numberOfTodos() ?? 0
//    }
//
//    func clearTasksButtonTapped() {
////        viewModel?.clearAllTodos()
//        // 위에서 구현한 todoObservable을 통해 자동으로 갱신되므로 따로 reloadData를 호출할 필요 X
//    }
//}

// MARK: - Bindings
extension ViewControllerWithRx {
    private func bindViewModel() {
        // tableView에 바인딩
        viewModel?.todoObservable
            .bind(to: todoTableView.rx.items(
                cellIdentifier: "TodoTableViewCell",
                cellType: TodoTableViewCell.self)
            ) { _, element, cell in
//                cell.configureTodoLabel(with: element, at: )
            }.disposed(by: disposeBag)
        
        // tableView 셀 선택에 대한 로직 처리
        todoTableView.rx.itemSelected
            .subscribe(onNext: {[weak self] indexPath in
//                self?.viewModel.
            })
            .disposed(by: disposeBag)
    }
}
