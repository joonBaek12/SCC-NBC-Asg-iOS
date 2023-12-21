//
//  TodoTableViewCell.swift
//  Joon'sTodoList-iOS
//
//  Created by Joon Baek on 2023/12/15.
//

import UIKit

// MARK: - TodoTableViewCell

final class TodoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TodoTableViewCell"
    
    var indexPath: IndexPath?
    
    // MARK: - UI Properties
    
    private lazy var containerStackView: UIStackView = { TodoTableViewCell.createAddTaskStackView() }()
    
    private lazy var todoLabel: UILabel = { createTodoLabel() }()
    private lazy var todoSegment: UISegmentedControl = { createTodoSegment() }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension TodoTableViewCell {
    
    // MARK: - Setups
    
    private func setupCell() {
        selectionStyle = .none
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        addSubview(containerStackView)
        
        [todoLabel, todoSegment].forEach { containerStackView.addArrangedSubview($0) }
        
        // edges.equalToSuperView()와 같음
        containerStackView.frame = bounds
        containerStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func createTodoLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        
        return label
    }
    
    private func createTodoSegment() -> UISegmentedControl {
        let items = ["Done", "Undone"]
        let control = UISegmentedControl(items: items)
        
        control.selectedSegmentIndex = 1
        control.isMomentary = false
        control.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        return control
    }
    
    // MARK: - Reusable Helper
    
    static func createAddTaskStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        
        return stackView
    }
}

// MARK: - Logics

extension TodoTableViewCell {
    private func setLabelProperties(textColor: UIColor, strikethrough: Bool) {
        guard todoLabel.text != nil else { return }
        todoLabel.applyTextProperties(textColor: textColor, strikethrough: strikethrough)
    }
    
    func configureTodoLabel(with text: String) {
        todoLabel.text = text
    }
    
    @objc private func segmentedControlValueChanged() {
        let selectedIndex = todoSegment.selectedSegmentIndex
        
        if selectedIndex == 0 {
            setLabelProperties(textColor: .black, strikethrough: false)
        } else {
            setLabelProperties(textColor: .gray, strikethrough: true)
        }
    }
}
