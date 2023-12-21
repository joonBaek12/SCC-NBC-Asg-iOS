//
//  ClearTasksFooterView.swift
//  TodoList
//
//  Created by Joon Baek on 2023/12/17.
//

import UIKit

protocol ClearTasksFooterViewDelegate: AnyObject {
    func numberOfPendingTasks() -> Int
}

// MARK: - ClearTasksFooterView

class ClearTasksFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    static let identifier = "ClearTasksFooterView"
    
    weak var delegate: ClearTasksFooterViewDelegate? {
        didSet {
            updateDescriptionLabel()
        }
    }
    
    // MARK: - UI Properties
    
    private lazy var containerStackView: UIStackView = { TodoTableViewCell.createAddTaskStackView() }()
    
    private lazy var descriptionLabel: UILabel = { createDescriptionLabel() }()
    private lazy var clearTasksButton: ColorButton = { ColorButton(title: "Clear", color: .systemRed) }()
    
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

extension ClearTasksFooterView {
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        addSubview(containerStackView)
        
        [descriptionLabel, clearTasksButton].forEach { containerStackView.addArrangedSubview($0) }
        
        containerStackView.frame = bounds
        containerStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        
        return label
    }
    
    // MARK: - Setups
    
    private func addButtonTarget() {
//        clearTasksButton.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    }
    
    // MARK: - Action Helpers
    
    func updateDescriptionLabel() {
        guard let delegate = delegate else { return }
        
        let pendingTasksCount = delegate.numberOfPendingTasks()
        descriptionLabel.text = "You have \(pendingTasksCount) pending tasks"
    }
}
