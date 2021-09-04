//
//  TheaterModel.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

struct TheaterModel: Codable {
    var seats: [SeatModel]
    var cols: Int
    var rows: Int
}
