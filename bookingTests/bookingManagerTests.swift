//
//  bookingTests.swift
//  bookingTests
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import XCTest
@testable import booking

class Mock_APIClientSuccess: APIClientProtocol {
    func setDefaultHeader(params: [String : String]?) {
        
    }
    
    func getTheater(success: @escaping (TheaterEntity?) -> Void, failure: @escaping (Error) -> Void) {
        success(TheaterEntity(seats: [], cols: 5, rows: 5))
    }
    
    func checkAvailableSeat(position: SeatPosition, isSelected: Bool, success: @escaping (SeatEntity?, Bool) -> Void, failure: @escaping (Error) -> Void) {
        success((SeatEntity(type: SeatType.standard, enable: true, position: SeatPosition(x: 1, y: 1), price: 10)), true)
    }
    
    func booking(positions: [SeatPosition], userInfo: UserInfoEntity, success: @escaping (Booking?) -> Void, failure: @escaping (Booking?) -> Void) {
        success(Booking(isSuccess: true, message: ""))
    }
}

class Mock_APIClientFail: APIClientProtocol {
    func setDefaultHeader(params: [String : String]?) {
        
    }
    
    func getTheater(success: @escaping (TheaterEntity?) -> Void, failure: @escaping (Error) -> Void) {
        success(TheaterEntity(seats: [], cols: 5, rows: 5))
    }
    
    func checkAvailableSeat(position: SeatPosition, isSelected: Bool, success: @escaping (SeatEntity?, Bool) -> Void, failure: @escaping (Error) -> Void) {
        success((SeatEntity(type: SeatType.standard, enable: true, position: SeatPosition(x: 1, y: 1), price: 10)), true)
    }
    
    func booking(positions: [SeatPosition], userInfo: UserInfoEntity, success: @escaping (Booking?) -> Void, failure: @escaping (Booking?) -> Void) {
        failure(Booking(isSuccess: false, message: "Your seats is not available"))
    }
}

class bookingManagerTests: XCTestCase {

    let apiClientSuccess = Mock_APIClientSuccess()
    let apiClientFail = Mock_APIClientFail()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetTheaterSuccess() throws {
        let bookingManager = BookingManager(api: self.apiClientSuccess)
        
        // 1. Define an expectation
        let expectation = expectation(description: "BookingManager does getTheater and runs the callback closure")

        bookingManager.getTheater { (theater) in
            XCTAssertTrue(theater?.rows == 5 && theater?.cols == 5)

            expectation.fulfill()
        } failure: { _ in
            
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
    }
    
    func testCheckAvailableSeatSuccess() throws {
        let bookingManager = BookingManager(api: self.apiClientSuccess)
        
        // 1. Define an expectation
        let expectation = expectation(description: "BookingManager does checkAvailableSeat and runs the callback closure")

        let positionTest = SeatPosition(x: 1, y: 1)
        let isSelected = true
        
        bookingManager.checkAvailableSeat(position: positionTest, isSelected: isSelected, success: { seat, isSelected in
            guard let seat = seat else {
                XCTAssertFalse(true, "Can not check from server")
                return
            }
            XCTAssertTrue(seat.position.x == positionTest.x && seat.position.y == positionTest.y)

            expectation.fulfill()
        }, failure: { _ in
            
        })
           
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
    }

    func testBookingSuccess() throws {
        let bookingManager = BookingManager(api: self.apiClientSuccess)
        
        // 1. Define an expectation
        let expectation = expectation(description: "BookingManager does booking and runs the callback closure")

        let positionTest = SeatPosition(x: 1, y: 1)
        let userInfo = UserInfoEntity(name: "diep", email: "diep@gmail.com")
        
        bookingManager.booking(positions: [positionTest], userInfo: userInfo) { (success) in
            XCTAssertTrue(success)
            
            expectation.fulfill()
        } failure: { _ in
            
        }

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
    }
    
    func testBookingFail() throws {
        let bookingManager = BookingManager(api: self.apiClientFail)
        
        // 1. Define an expectation
        let expectation = expectation(description: "BookingManager does booking and runs the callback closure")

        let positionTest = SeatPosition(x: 1, y: 1)
        let userInfo = UserInfoEntity(name: "diep", email: "diep@gmail.com")
        
        bookingManager.booking(positions: [positionTest], userInfo: userInfo) { (success) in
            XCTAssertFalse(success)
            
            expectation.fulfill()
        } failure: { message in
            XCTAssertTrue(message == "Your seats is not available")
            
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
    }
}
