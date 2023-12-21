//
//  TodoTableViewCell.swift
//  Joon'sTodoList-iOS
//
//  Created by Joon Baek on 2023/12/15.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TodoTableViewCell"
    
    // MARK: - UI Properties
    
    private lazy var addTaskStackView: UIStackView = { createAddTaskStackView() }()
    
    private lazy var addTaskTextField: UITextField = { createTodoTextField() }()
    private lazy var addTaskButton: UIButton = { createAddTodoButton() }()
    
    private lazy var todoLabel: UILabel = { createTodoLabel() }()
    private lazy var todoSegment: UISegmentedControl = { createTodoSegment() }()
    
    private lazy var descriptionLabel: UILabel = { createDescriptionLabel() }()
    private lazy var clearTasksButton: UIButton = { createClearTasksButton() }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension TodoTableViewCell {
    
    private func setLayout() {
        
        addSubview(addTaskStackView)
        
        [todoLabel, todoSegment].forEach { addTaskStackView.addArrangedSubview($0) }
        
        // 검증 필요
        addTaskStackView.frame = bounds
        addTaskStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
//        addTaskStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            addTaskStackView.topAnchor.constraint(equalTo: topAnchor),
//            addTaskStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            addTaskStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            addTaskStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
    }
    
    private func createTodoTextField() -> UITextField {
        let textField = UITextField()
        
        textField.placeholder = "Todo"
        textField.borderStyle = .roundedRect
        
        return textField
    }
    
    private func createAddTodoButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        
        return button
    }
    
    private func createAddTaskStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        
        return stackView
    }
    
    private func createTodoLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.textColor = .black
        
        return label
    }
    
    private func createTodoSegment() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl()
        
        return segmentedControl
    }
    
    private func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        
        //        label.text = "You have \(viewModel) pending tasks"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        
        return label
    }
    
    private func createClearTasksButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("Clear", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        
        return button
    }
}
