//
//  IUserRepository.swift
//  combine_demo
//
//  Created by New Danish on 18/07/2024.
//

import Foundation
import Combine

protocol IUserRepository {
    func fetchUsers() -> AnyPublisher<[DTOUser], APIError>
}
