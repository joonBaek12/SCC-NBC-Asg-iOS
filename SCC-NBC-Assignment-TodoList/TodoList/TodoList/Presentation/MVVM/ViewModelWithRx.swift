//
//  ViewModelWithRx.swift
//  TodoList
//
//  Created by Joon Baek on 2023/12/19.
//

import Foundation

import RxSwift
import RxCocoa

final class ViewModelWithRx {
    private var taskTitle: String = ""
    private var isCompleted: Bool = false
    private var todos: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    var todoObservable: Observable<[String]> {
        return todos.asObservable()
    }
}

extension ViewModelWithRx {
    func setTextTitle(with title: String) {
        taskTitle = title
    }
    
    func addTodo(with todo: String) {
        var currentTodos = todos.value
        currentTodos.append(todo)
        todos.accept(currentTodos)
    }
    
    func deleteTodo(at index: Int) {
        var currentTodos = todos.value
        currentTodos.remove(at: index)
        todos.accept(currentTodos)
    }
}
