//
//  UsersRepository.swift
//  combine_demo
//
//  Created by New Danish on 18/07/2024.
//

import Foundation
import Combine

class UserRepository: IUserRepository {
    
    func fetchUsers() -> AnyPublisher<[DTOUser], APIError> {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/usersabc") else {
            return Fail(error: APIError.wrongUrl).eraseToAnyPublisher()
        }
            
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [CodableUser].self, decoder: JSONDecoder())
            .map({ codableUsers -> [DTOUser] in
                codableUsers.map { codableUser in
                    CodableUser.toDTO(input: codableUser)
                }
            })
            .mapError({ error -> APIError in
                return APIError.parseError(error)
            })
            .eraseToAnyPublisher()
    }
    
    struct CodableUser: Decodable {
        var id: Int
        var name: String
        var username: String
        var email: String
        
        static func toDTO(input: Self) -> DTOUser {
            DTOUser(id: input.id, name: input.name, username: input.username, email: input.email)
        }
    }
}

enum APIError: Error {
    case wrongUrl
    case responseError(Error)
    case parseError(Error)
}
