//
//  TheaterBuilder.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import UIKit

class TheaterBuilder {
    public static func createViewSelectSeat() -> UIViewController {
        let view = TheaterViewController()
        let presenter = TheaterPresenter()
        let interactor = TheaterInteractor(bookingManager: BookingManager(api: APIClient.shared))
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = SelectSeatWireframe()
        interactor.presenter = presenter
        return view
    }
    
    public static func createViewUpdateInformation(positions: [SeatPosition]) -> UIViewController {
        let view = UpdateInfoViewController()
        let presenter = UpdateInfoPresenter(positions: positions)
        let interactor = UpdateInfoInteractor(bookingManager: BookingManager(api: APIClient.shared))
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
}
