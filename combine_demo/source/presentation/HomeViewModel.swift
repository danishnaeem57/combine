//
//  ViewModel.swift
//  combine_demo
//
//  Created by New Danish on 18/07/2024.
//

import Foundation
import Combine

class HomeViewModel {
    
    private let fetchUsersUsecase: FetchUsersUsecase!
    @Published var users: [DTOUser]
    private var fetchUsersCancellable: AnyCancellable? = nil
    
    init(fetchUsersUsecase: FetchUsersUsecase) {
        self.fetchUsersUsecase = fetchUsersUsecase
        self.users = []
    }
    
    func fetchUsers() {
        let result = self.fetchUsersUsecase.execute(abc: false)
        fetchUsersCancellable = result.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Fetched Users")
            case .failure(let error):
                print("Found Error \(error)")
            }
        }, receiveValue: { value in
            self.users = value
        })
    }
    
}
