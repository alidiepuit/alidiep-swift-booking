//
//  SelectSeatPresenter.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

class SelectSeatPresenter: SelectSeatPresenterInputProtocol {
    weak var view: SelectSeatPresenterOutputProtocol?
    weak var interactor: SelectSeatInteractorInputProtocol?
    
    func viewDidLoad() {
        self.interactor?.loadSeats()
    }
}

extension SelectSeatPresenter: SelectSeatInteractorOutputProtocol {
    func didLoadSeats(theater: TheaterModel?) {
        self.view?.didLoadSeats(theater: theater)
    }
}
