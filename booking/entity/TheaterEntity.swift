//
//  TheaterEntity.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

struct TheaterEntity: Codable {
    var seats: [SeatEntity]
    var cols: Int
    var rows: Int
    
    func convertToModel() -> TheaterModel {
        let seats: [SeatView] = self.seats.map { model -> SeatView in
            return model.convertToSeatView()
        }
        return TheaterModel(seats: seats, cols: self.cols, rows: self.rows)
    }
}
