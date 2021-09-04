//
//  SelectSeatWireframe.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 06/09/2021.
//

import UIKit

class SelectSeatWireframe: TheaterWireframeProtocol {
    func pushUpdateInfo(root: TheaterPresenterOutputProtocol, positions: [SeatPosition]) {
        let vc = TheaterBuilder.createViewUpdateInformation(positions: positions)
        root.navigationController?.pushViewController(vc, animated: true)
    }
}
