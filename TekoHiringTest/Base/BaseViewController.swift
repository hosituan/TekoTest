//
//  BaseViewController.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController {
    var onDeinit: (() -> Void)?
    let bag = DisposeBag()
    deinit {
        print("deinit \(self)")
        onDeinit?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        observe()
    }
    
    func setupView() {
        
    }
    
    func observe() {
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}

//MARK: Common extension
extension BaseViewController {
    func setPopup() {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.setAction { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
