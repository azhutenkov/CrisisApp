//
//  Coordinator.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 01/03/2020.
//

import Foundation

protocol CoordinatorProtocol: AnyObject {
    
    var children: [CoordinatorProtocol] { get set }
    
    func addChild(childCoordinator: CoordinatorProtocol)
    func removeChild(childCoordinator: CoordinatorProtocol)
    
    func start()
}

extension CoordinatorProtocol {
    
    func addChild(childCoordinator: CoordinatorProtocol) {
        children.append(childCoordinator)
    }
    
    func removeChild(childCoordinator: CoordinatorProtocol) {
        if let coordinatorIndex: Int = children.firstIndex(where: { $0 == childCoordinator }) {
            children.remove(at: coordinatorIndex)
        }
    }
}

func == (lhs: CoordinatorProtocol, rhs: CoordinatorProtocol) -> Bool {
     return lhs === rhs
}
