//
//  SeatModel.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

enum SeatStatus: Int, Codable {
    case available = 0
    case occupied = 1
    case notBookable = 2
}

enum SeatType: Int, Codable {
    case standard = 0
    case vip = 1
    case recliner = 2
    case wheel = 3
}

struct SeatPosition: Codable {
    var x: Int
    var y: Int
    
    var getLetter: String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return "" + letters[self.x]
    }
}

struct SeatModel: Codable {
    var status: SeatStatus
    var type: SeatType
    var selected: Bool
    var position: SeatPosition
    
    var isBookable: Bool {
        return self.status == SeatStatus.available
    }
}
