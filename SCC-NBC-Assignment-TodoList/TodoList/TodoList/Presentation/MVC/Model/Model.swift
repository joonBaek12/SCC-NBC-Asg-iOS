//
//  Model.swift
//  Joon'sTodoList-iOS
//
//  Created by Joon Baek on 2023/12/15.
//

import Foundation

final class Model {
    private let manager = UserDefaultsManager()
    
    private var todos: [String] {
        get { manager.fetchTodos()}
        set { manager.saveTodos(newValue)}
    }
}

extension Model {
    
    func setTaskTitle(with title: String) {
        manager.setTodoTitle(with: title)
    }
    
    func getTaskTitle() -> String {
        manager.getTodoTitle()
    }
    
    func getTodo(at index: Int) -> String {
        return todos[index]
    }
    
    func numberOfTodos() -> Int {
        return todos.count
    }
    
    func addTask(_ task: String) {
        manager.addTodo(task)
    }
    
    func deleteTask(at index: Int) {
        manager.deleteTodo(at: index)
    }
    
    func updateTask(at index: Int, with task: String) {
        manager.updateTodo(at: index, with: task)
    }
    
    func clearAllTodo() {
        todos = []
    }
}


//
//    func addTodo(with todo: String) {
//        todos.append(todo)
//    }
//
//
//    func deleteTodo(at index: Int) {
//        todos.remove(at: index)
//    }
