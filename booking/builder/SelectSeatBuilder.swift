//
//  SelectSeatBuilder.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import UIKit

class SelectSeatBuilder {
    public static func createViewSelectSeat() -> UIViewController {
        let view = TheaterViewController()
        let presenter = SelectSeatPresenter()
        let interactor = SelectSeatInteractor(bookingManager: BookingManager.shared)
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
}
