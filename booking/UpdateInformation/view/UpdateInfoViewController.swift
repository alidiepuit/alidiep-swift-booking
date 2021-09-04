//
//  UpdateInfoViewController.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 06/09/2021.
//

import UIKit
import SnapKit
import ReactiveSwift
import ReactiveCocoa

class UpdateInfoViewController: UIViewController {
    var presenter: UpdateInfoPresenterInputProtocol?
    
    var userInfo = UserInfoModel()
    
    private let loadingView = UIActivityIndicatorView()
    
    private let name: UITextField = {
        let field = UITextField(frame: CGRect.zero)
        field.borderStyle = UITextField.BorderStyle.line
        return field
    }()
    
    private let email: UITextField = {
        let field = UITextField(frame: CGRect.zero)
        field.borderStyle = UITextField.BorderStyle.line
        return field
    }()
    
    private let lblName: UILabel = {
        let field = UILabel(frame: CGRect.zero)
        field.text = "Name:"
        return field
    }()
    
    private let lblEmail: UILabel = {
        let field = UILabel(frame: CGRect.zero)
        field.text = "Email:"
        return field
    }()
    
    private let buyBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Buy", for: .normal)
        button.backgroundColor = UIColor.gray
        button.titleLabel?.textColor = UIColor.white
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupView() {
        self.view.addSubview(self.buyBtn)
        self.title = "Update Information"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.loadingView)
        self.loadingView.isHidden = true
        self.buyBtn.addTarget(self, action: #selector(self.didTapBuyBtn), for: .touchUpInside)
        
        self.userInfo.name <~ self.name.reactive.continuousTextValues
        self.userInfo.email <~ self.email.reactive.continuousTextValues
        
        self.buyBtn.reactive.isEnabled <~ self.userInfo.valid
        self.userInfo.valid.signal.observeValues { isValid in
            if isValid {
                self.buyBtn.backgroundColor = UIColor.black
            } else {
                self.buyBtn.backgroundColor = UIColor.gray
            }
        }
    }
    
    func setupLayout() {
        let view1 = UIStackView(arrangedSubviews: [self.lblName, self.name])
        self.lblName.setContentHuggingPriority(.required, for: .horizontal)
        view1.alignment = UIStackView.Alignment.fill
        view1.distribution = UIStackView.Distribution.fill
        view1.spacing = 10
        view1.axis = .horizontal
        self.view.addSubview(view1)
        view1.snp.remakeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        let view2 = UIStackView(arrangedSubviews: [self.lblEmail, self.email])
        view2.alignment = UIStackView.Alignment.fill
        view2.distribution = UIStackView.Distribution.fill
        view2.axis = .horizontal
        self.view.addSubview(view2)
        view2.snp.remakeConstraints { make in
            make.top.equalTo(view1.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        self.name.snp.makeConstraints { make in
            make.width.equalTo(self.email)
        }
        
        self.buyBtn.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(50)
        }
    }
    
    @objc func didTapBuyBtn() {
        self.loadingView.startAnimating()
        self.loadingView.isHidden = false
        self.presenter?.didTapSubmit(userInfo: self.userInfo)
    }
}

extension UpdateInfoViewController: UpdateInfoPresenterOutputProtocol {
    func didBookingSuccess() {
        self.loadingView.stopAnimating()
        self.loadingView.isHidden = true
        
        let alertView = UIAlertController(title: nil, message: "Your seats are booked successfully.", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func didBookingFail(message: String) {
        self.loadingView.stopAnimating()
        self.loadingView.isHidden = true
        
        let alertView = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        self.present(alertView, animated: true, completion: nil)
    }
}
