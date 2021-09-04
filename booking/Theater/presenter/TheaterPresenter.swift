//
//  TheaterPresenter.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

class TheaterPresenter: TheaterPresenterInputProtocol {
    weak var view: TheaterPresenterOutputProtocol?
    var interactor: TheaterInteractorInputProtocol?
    var wireframe: TheaterWireframeProtocol?
    
    func viewDidLoad() {
        self.interactor?.loadSeats()
    }
    
    func didTapNext(listSeat: [SeatView]) {
        let listPosition = listSeat.map { $0.position }
        if let view = self.view {
            self.wireframe?.pushUpdateInfo(root: view, positions: listPosition)
        }
    }
    
    func didTapSeat(seat: SeatView, isSelected: Bool) {
        self.interactor?.checkSeatAvailable(position: seat.position, isSelected: isSelected)
    }
}

extension TheaterPresenter: TheaterInteractorOutputProtocol {
    func didLoadSeats(theater: TheaterEntity?) {
        guard let theater = theater else {
            return
        }
        DispatchQueue.main.async {
            self.view?.didLoadSeats(theater: theater.convertToModel())
        }
    }
    
    func didCheckSeatAvailable(seat: SeatEntity?, isSelected: Bool) {
        DispatchQueue.main.async {
            if let seat = seat?.convertToSeatView() {
                self.view?.didSelectedSeatSuccess(seat, isSelected: isSelected)
            }
        }
    }
    
    func didCheckSeatAvailableFail(position: SeatPosition, error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                self.view?.didSelectedSeatFail(position: position, error: error)
            }
        }
    }
    
    func didBookingFail() {
        
    }
    
    func didBookingSuccess() {
        
    }
}
