//
//  BookingManager.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

protocol BookingManagerProtocol {
    func getTheater(success: @escaping (TheaterEntity?) -> Void, failure: @escaping (Error) -> Void)
    func checkAvailableSeat(position: SeatPosition, isSelected: Bool, success: @escaping (SeatEntity?, Bool) -> Void, failure: @escaping (Error) -> Void)
    func booking(positions: [SeatPosition], userInfo: UserInfoEntity, success: @escaping (Bool) -> Void, failure: @escaping (String) -> Void)
}

class BookingManager: BookingManagerProtocol {
    private let api: APIClientProtocol
    
    init(api: APIClientProtocol) {
        self.api = api
    }
    
    func getTheater(success: @escaping (TheaterEntity?) -> Void, failure: @escaping (Error) -> Void) {
        self.api.getTheater { theater in
            success(theater)
        } failure: { (error) in
            failure(error)
        }
//        var seats: [SeatEntity] = []
//        let cols = 10
//        let rows = 8
//        for y in 0..<rows {
//            for x in 0..<cols {
//                seats.append(SeatEntity(type: .standard, enable: true, position: SeatPosition(x: x, y: y), price: 10))
//            }
//        }
//        seats[0].type = .vip
//        seats[1].type = .recliner
//        seats[2].type = .wheel
//        seats[4].type = .notBookable
//        seats[5].type = .occupied
//        let theater = TheaterEntity(seats: seats, cols: cols, rows: rows)
//        success(theater)
    }
    
    func checkAvailableSeat(position: SeatPosition, isSelected: Bool, success: @escaping (SeatEntity?, Bool) -> Void, failure: @escaping (Error) -> Void) {
        self.api.checkAvailableSeat(position: position, isSelected: isSelected, success: { (seat, isSelected) in
            success(seat, isSelected)
        }, failure: { error in
            failure(error)
        })
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            success(SeatEntity(type: .standard, enable: true, position: SeatPosition(x: position.x, y: position.y), price: 10), isSelected)
//            failure(NSError(domain: "", code: 0, userInfo: nil))
//        }
    }
    
    func booking(positions: [SeatPosition], userInfo: UserInfoEntity, success: @escaping (Bool) -> Void, failure: @escaping (String) -> Void) {
        self.api.booking(positions: positions, userInfo: userInfo) { booking in
            success(booking?.isSuccess ?? false)
        } failure: { booking in
            failure(booking?.message ?? "")
        }

    }
}
