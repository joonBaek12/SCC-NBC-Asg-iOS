//
//  main.swift
//  SCC-NBC-Assignment
//
//  Created by Joon Baek on 2023/12/05.
//

import Foundation

class Main {
    
    // MARK: - Properties

    private var bugerCount = 0

    // Menu 객체 생성
    let menu = Menu(products: [
        Burger(name: "ShackBurger", price: 6900, description: "토마토, 양상추, 쉑소스가 토핑된 치즈버거"),
        Burger(name: "SmokeShack", price: 8900, description: "베이컨, 체리 페퍼에 쉑소스가 토핑된 치즈버거"),
        Burger(name: "Shroom Burger", price: 9400, description: "몬스터 치즈와 체다 치즈로 속을 채운 베지테리안 버거"),
        Burger(name: "Cheeseburger", price: 6900, description: "포테이토 번과 비프패티, 치즈가 토핑된 치즈버거"),
        Burger(name: "Hamburger", price: 5400, description: "비프패티를 기반으로 야채가 들어간 기본버거"),
        FrozenCustard(name: "Vanilla", price: 3500, description: "바닐라 맛 아이스크림"),
        FrozenCustard(name: "Chocolate", price: 3500, description: "초콜릿 맛 아이스크림"),
        Drink(name: "Coke", price: 2000, description: "콜라"),
        Drink(name: "Sprite", price: 2000, description: "스프라이트")
    ])
}

// MARK: - Extension

extension Main {

    func run() {
        menu.printMenu()

        repeat {
            handleUserInput()
            bugerCount += 1
        } while true
    }
    
    func handleUserInput() {
        guard let input = readLine() else { return }
        
        if let number = Int(input) {
            
            switch number {
            case 1...menu.products.count:
                if let selectedProduct = menu.selectProduct(at: number - 1) {
                    print("상세 메뉴: \(selectedProduct.name ?? "") | \(selectedProduct.price ?? 0)")
                } else {
                    print("잘못된 번호입니다.")
                }
            case 0:
                print("프로그램을 종료합니다.")
            default:
                print("잘못된 번호입니다.")
            }
        } else {
            print("숫자를 입력해주세요.")
        }
    }
}

let main = Main()
main.run()
