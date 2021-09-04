//
//  TheaterInteractor.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

class TheaterInteractor: TheaterInteractorInputProtocol {
    weak var presenter: TheaterInteractorOutputProtocol?
    private var bookingManager: BookingManagerProtocol?
    
    init(bookingManager: BookingManagerProtocol?) {
        self.bookingManager = bookingManager
    }
    
    func loadSeats() {
        self.bookingManager?.getTheater(success: { theater in
            self.presenter?.didLoadSeats(theater: theater)
        }, failure: { _ in
            
        })
    }
    
    func checkSeatAvailable(position: SeatPosition, isSelected: Bool) {
        self.bookingManager?.checkAvailableSeat(position: position, isSelected: isSelected, success: { (entity, isSelected) in
            self.presenter?.didCheckSeatAvailable(seat: entity, isSelected: isSelected)
        }, failure: { error in
            self.presenter?.didCheckSeatAvailableFail(position: position, error: error)
        })
    }
}
