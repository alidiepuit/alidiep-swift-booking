//
//  SelectSeatInteractor.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

class SelectSeatInteractor: SelectSeatInteractorInputProtocol {
    var presenter: SelectSeatInteractorOutputProtocol?
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
    
    
}
