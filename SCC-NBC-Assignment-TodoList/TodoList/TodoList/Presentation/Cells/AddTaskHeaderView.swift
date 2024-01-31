//
//  AddTaskHeaderView.swift
//  TodoList
//
//  Created by Joon Baek on 2023/12/17.
//

import UIKit

protocol AddTaskHeaderViewDelegate: AnyObject {
    func addTaskButtonTapped(with text: String, at indexPath: IndexPath)
}

// MARK: - AddTaskHeaderView

class AddTaskHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    static let identifier = "AddTaskHeaderView"
    
    weak var delegate: AddTaskHeaderViewDelegate?
    
    var indexPath: IndexPath?
    
    // MARK: - UI Properties
    
    private lazy var containerStackView: UIStackView = { TodoTableViewCell.createAddTaskStackView() }()
    
    private lazy var addTaskTextField: UITextField = { createTodoTextField() }()
    private lazy var addTaskButton: ColorButton = { ColorButton(title: "Add", color: .systemGreen) }()
    
    // MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setLayout()
        addButtonTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension AddTaskHeaderView {
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        addSubview(containerStackView)
        
        [addTaskTextField, addTaskButton].forEach { containerStackView.addArrangedSubview($0) }
        
        containerStackView.frame = bounds
        containerStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func createTodoTextField() -> UITextField {
        let textField = UITextField()
        
        textField.placeholder = "Todo"
        textField.borderStyle = .roundedRect
        
        return textField
    }
    
    // MARK: - Methods
    
    private func addButtonTarget() {
        addTaskButton.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Action Helpers
    
    private func clearTextField() {
        addTaskTextField.text = nil
    }
    
    @objc private func handleButtonTapped() {
        guard let todoText = addTaskTextField.text else { return }
        guard let indexPath = indexPath else { return }
        
        delegate?.addTaskButtonTapped(with: todoText, at: indexPath)
        clearTextField()
    }
}
