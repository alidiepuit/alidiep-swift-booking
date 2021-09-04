//
//  SelectSeatViewController.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import UIKit
import SnapKit

class TheaterViewController: UIViewController, SelectSeatPresenterOutputProtocol {
    var presenter: SelectSeatPresenterInputProtocol?
    
    private let imageScreen: UIImageView = {
        let image = UIImageView(image: UIImage(named: "screen"))
        return image
    }()
    
    private let titleScreen = UILabel()
    
    private let containerSeat = UIView()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private let seatingKey: UILabel = {
        let label = UILabel()
        label.text = "SEATING KEY"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initTheaterView()
    }
    
    func initTheaterView() {
        self.imageScreen.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.lessThanOrEqualToSuperview()
        }
        self.containerSeat.snp.remakeConstraints { make in
            make.top.equalTo(self.imageScreen.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(20*26)
        }
        self.line.snp.remakeConstraints { make in
            make.top.equalTo(self.containerSeat.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        self.seatingKey.snp.remakeConstraints { make in
            make.top.equalTo(self.line.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
    }
    
    func didLoadSeats(theater: TheaterModel?) {
        
    }
}
