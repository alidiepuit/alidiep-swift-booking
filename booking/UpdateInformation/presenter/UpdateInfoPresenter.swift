//
//  UpdateInfoPresenter.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 06/09/2021.
//

import Foundation

class UpdateInfoPresenter: UpdateInfoPresenterInputProtocol {
    var interactor: UpdateInfoInteractorInputProtocol?
    weak var view: UpdateInfoPresenterOutputProtocol?
    
    private var positions: [SeatPosition]
    
    init(positions: [SeatPosition]) {
        self.positions = positions
    }
    
    func viewDidLoad() {
        
    }
    
    func didTapSubmit(userInfo: UserInfoModel) {
        self.interactor?.booking(positions: positions, userInfo: userInfo.convertToEntity())
    }
}

extension UpdateInfoPresenter: UpdateInfoInteractorOutputProtocol {
    func didBookingSuccess() {
        self.view?.didBookingSuccess()
    }
    
    func didBookingFail(message: String) {
        self.view?.didBookingFail(message: message)
    }
}
