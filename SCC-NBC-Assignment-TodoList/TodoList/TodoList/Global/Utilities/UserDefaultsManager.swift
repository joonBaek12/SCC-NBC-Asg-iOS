//
//  UserDefaultsManager.swift
//  TodoList
//
//  Created by Joon Baek on 2024/01/11.
//

import Foundation

final class UserDefaultsManager {
    // UserDefaults의 standard 인스턴스 선언
    // TODO: standard는 뭔데?
    private let defaults = UserDefaults.standard
    
    // 이유 설명
    private enum Keys {
        static let todos = "Todos"
        static let taskTitle = "TaskTitle"
    }
}

extension UserDefaultsManager {
    
    func setTodoTitle(with title: String) {
        defaults.set(title, forKey: Keys.taskTitle)
    }
    
    func getTodoTitle() -> String {
        return defaults.string(forKey: Keys.taskTitle) ?? ""
    }
    
    func fetchTodos() -> [String] {
        return defaults.array(forKey: Keys.todos) as? [String] ?? []
    }
    
    func saveTodos(_ todos: [String]) {
        defaults.set(todos, forKey: Keys.todos)
    }
    
    func addTodo(_ todo: String) {
        var todos = fetchTodos()
        todos.append(todo)
        saveTodos(todos)
    }
    
    func deleteTodo(at index: Int) {
        var todos = fetchTodos()
        todos.remove(at: index)
        saveTodos(todos)
    }
    
    func updateTodo(at index: Int, with todo: String) {
        var todos = fetchTodos()
        todos[index] = todo
        saveTodos(todos)
    }
}
