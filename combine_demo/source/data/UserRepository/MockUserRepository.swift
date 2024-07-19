//
//  MockUserRepository.swift
//  combine_demoUITests
//
//  Created by New Danish on 19/07/2024.
//

import Foundation
import Combine

class MockUserRepository: IUserRepository {
    
    var shouldReturnError = false
    var users = [DTOUser]()
    
    func fetchUsers() -> AnyPublisher<[DTOUser], APIError> {
        if shouldReturnError {
            return Fail(error: APIError.wrongUrl)
                .eraseToAnyPublisher()
        } else {
            return Just(users)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }
    }
    
    
}
