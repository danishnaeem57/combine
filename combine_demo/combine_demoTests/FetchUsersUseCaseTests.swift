//
//  FetchUsersUseCaseTests.swift
//  combine_demoUITests
//
//  Created by New Danish on 19/07/2024.
//

import XCTest
@testable import combine_demo

import Combine

final class FetchUsersUseCaseTests: XCTestCase {
    
    var usecase: FetchUsersUsecase!
    var mockRepository: MockUserRepository!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockUserRepository()
        usecase = FetchUsersUsecase(repository: mockRepository)
        cancellables = []
    }
    
    override func tearDown() {
        usecase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testFetchUsersSuccess() {
        // Given
        let expectedUsers: [DTOUser] = []//[DTOUser(id: 1, name: "danish", username: "danishnaeem57", email: "danishnaeem57@gmail.com")]
        mockRepository.users = expectedUsers
        
        // When
        var receivedUsers: [DTOUser]?
        var receivedError: APIError?
        let expectation = self.expectation(description: "FetchUsers")
        
        usecase.execute(abc: false)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error
                }
                expectation.fulfill()
            }, receiveValue: { users in
                receivedUsers = users
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)
        
        // Then
        XCTAssertNotNil(receivedUsers)
        XCTAssertNil(receivedError)
        XCTAssertEqual(expectedUsers, receivedUsers, "equalitty")
    }
    
    func testFetchUsersSuccess2() {
        // Given
        let expectedUsers: [DTOUser] = []//[DTOUser(id: 1, name: "danish", username: "danishnaeem57", email: "danishnaeem57@gmail.com")]
        mockRepository.users = expectedUsers
        
        // When
        var receivedUsers: [DTOUser]?
        var receivedError: APIError?
        let expectation = self.expectation(description: "FetchUsers")
        
        usecase.execute(abc: true)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error
                }
                expectation.fulfill()
            }, receiveValue: { users in
                receivedUsers = users
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)

        // Then
        XCTAssertNotNil(receivedUsers)
        XCTAssertNil(receivedError)
        XCTAssertEqual(expectedUsers, receivedUsers, "equalitty")
    }

//    func testFetchUsersFailure() {
//        // Given
//        mockRepository.shouldReturnError = true
//        
//        // When
//        var actualUsers: [User]?
//        var actualError: Error?
//        let expectation = self.expectation(description: "FetchUsers")
//        
//        useCase.execute { result in
//            switch result {
//            case .success(let users):
//                actualUsers = users
//            case .failure(let error):
//                actualError = error
//            }
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 1, handler: nil)
//        
//        // Then
//        XCTAssertNil(actualUsers)
//        XCTAssertNotNil(actualError)
//    }
}
