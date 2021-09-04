//
//  SeatEntity.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import UIKit

enum SeatType: Int, Codable {
    case standard = 0
    case vip = 1
    case recliner = 2
    case wheel = 3
    case notBookable = 4
    case occupied = 5
}

struct SeatPosition: Codable, Equatable {
    var x: Int
    var y: Int
    
    var getLetter: String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return "" + letters[self.y]
    }
    
    var getSeat: String {
        return "\(self.getLetter)\(self.x+1)"
    }
}

struct SeatEntity: Codable {
    var type: SeatType
    var enable: Bool
    var position: SeatPosition
    var price: Float
    
    func convertToSeatView() -> SeatView {
        switch self.type {
        case .standard:
            return StandardSeatView(position: self.position, enable: self.enable, price: self.price)
        case .recliner:
            return ReclinerSeatView(position: self.position, enable: self.enable, price: self.price)
        case .vip:
            return VipSeatView(position: self.position, enable: self.enable, price: self.price)
        case .wheel:
            return WheelChairSeatView(position: self.position)
        case .notBookable:
            return NotBookableSeatView(position: self.position)
        case .occupied:
            return OccupiedSeatView(position: self.position)
        }
    }
}
