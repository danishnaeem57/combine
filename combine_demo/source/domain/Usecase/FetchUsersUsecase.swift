//
//  FetchUsersUsecase.swift
//  combine_demo
//
//  Created by New Danish on 18/07/2024.
//

import Foundation
import Combine
class FetchUsersUsecase {
    
    private var repository: IUserRepository!
    
    init(repository: IUserRepository) {
        self.repository = repository
    }
    
    func execute(abc: Bool) -> AnyPublisher<[DTOUser], APIError> {
        if abc {
            print("\(abc) code coverarge")
            print("\(abc) code coverarge")
            print("\(abc) code coverarge")
            print("\(abc) code coverarge")
            print("\(abc) code coverarge")
            print("\(abc) code coverarge")
            print("\(abc) code coverarge")
            print("\(abc) code coverarge")
        }
        return self.repository.fetchUsers()
    }
    
}
