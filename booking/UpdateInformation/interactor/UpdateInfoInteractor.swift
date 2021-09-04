//
//  UpdateInfoInteractor.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

class UpdateInfoInteractor: UpdateInfoInteractorInputProtocol {
    weak var presenter: UpdateInfoInteractorOutputProtocol?
    private var bookingManager: BookingManagerProtocol?
    
    init(bookingManager: BookingManagerProtocol?) {
        self.bookingManager = bookingManager
    }
    
    func booking(positions: [SeatPosition], userInfo: UserInfoEntity) {
        self.bookingManager?.booking(positions: positions, userInfo: userInfo, success: { isSuccess in
            self.presenter?.didBookingSuccess()
        }, failure: { message in
            self.presenter?.didBookingFail(message: message)
        })
    }
}
