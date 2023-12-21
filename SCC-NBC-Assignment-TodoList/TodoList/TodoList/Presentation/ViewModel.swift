//
//  ViewModel.swift
//  Joon'sTodoList-iOS
//
//  Created by Joon Baek on 2023/12/15.
//

import Foundation

class ViewModel {
    private var taskTitle: String = ""
    private var isCompleted: Bool = false
    private var todos: [String] = []
}

extension ViewModel {
    func setTextTitle(with title: String) {
        taskTitle = title
    }
    
    func getTextTitle() -> String {
        return taskTitle
    }
    
    func addTodo(with todo: String) {
        todos.append(todo)
    }
    
    func getTodo(at index: Int) -> String {
        return todos[index]
    }
    
    func numberOfTodos() -> Int {
        return todos.count
    }
    
    func deleteTodo(at index: Int) {
        todos.remove(at: index)
    }
}
