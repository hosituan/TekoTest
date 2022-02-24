//
//  ProductDetailViewController.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import UIKit
import SnapKit
import Then
import PlaceholderTextField

protocol ProductDetailDelegate: AnyObject {
    func updateProduct(at index: IndexPath, to product: Product)
}
class ProductDetailViewController: BaseViewController {
    var viewModel: ProductDetailViewModel!
    weak var delegate: ProductDetailDelegate?
    
    lazy var submitButton = UIButton().then {
        $0.setTitle("Submit", for: .normal)
        $0.cornerRadius = 4
        $0.borderColor = .lightGray
        $0.setTitleColor(.blue, for: .normal)
        $0.borderWidth = 1
        $0.setAction { [weak self] in
            self?.view.endEditing(true)
            guard let self = self,
                  let name = self.nameTextField.text?.trimmed(),
                  !name.isEmpty,
                  let code = self.productCodeTextField.text?.trimmed(),
                  !code.isEmpty
            else { return }
            self.viewModel.product.name = name
            self.viewModel.product.sku = code
            self.viewModel.updateProduct() //Need to implement update API. completionHandler here
            self.delegate?.updateProduct(at: self.viewModel.index, to: self.viewModel.product)
            self.dismiss(animated: true, completion: nil)
        }
    }
    lazy var containerView = UIView().then {
        $0.setAction(action: nil) //Pervent dismiss
        $0.backgroundColor = .white
        $0.isUserInteractionEnabled = true
        $0.cornerRadius = 24
    }
    lazy var productImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.cornerRadius = 5
        $0.backgroundColor = .lightGray
    }
    lazy var productIdLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .left
    }
    lazy var productErrorLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .red
    }
    lazy var productColorLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    
    lazy var nameTextField = PlaceholderTextField().then {
        $0.isRequired = true
        $0.placeholder = "Product name"
    }
    lazy var productCodeTextField = PlaceholderTextField().then {
        $0.isRequired = true
        $0.placeholder = "Product code"
    }
    lazy var colorPickerView = UIPickerView().then {
        $0.delegate = self
        $0.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
            make.centerX.centerY.equalToSuperview()
        }
        containerView.addSubviews(productImageView, nameTextField, productCodeTextField, productIdLabel, productErrorLabel, submitButton, colorPickerView)
        productImageView.snp.makeConstraints { make in
            make.height.width.equalTo(64)
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
        }
        productIdLabel.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp.right).offset(8)
            make.top.equalTo(productImageView)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        productErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(productIdLabel.snp.bottom).offset(4)
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(productIdLabel)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(16)
            make.height.equalTo(56)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        productCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(4)
            make.left.right.height.equalTo(nameTextField)
        }
        colorPickerView.snp.makeConstraints { make in
            make.top.equalTo(productCodeTextField.snp.bottom).offset(4)
            make.left.right.equalTo(productCodeTextField)
            make.height.equalTo(200)
        }
        submitButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(240)
            make.centerX.equalToSuperview()
            make.top.equalTo(colorPickerView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        setData()
    }
    
    func setData() {
        if let url = viewModel.product.image {
            productImageView.loadImageWithLink(url, imageHolder: nil)
        }
        if let id = viewModel.product.id {
            productIdLabel.text = "ID: \(id)"
        }
        self.nameTextField.text = viewModel.product.name ?? ""
        self.productCodeTextField.text = viewModel.product.sku ?? ""
        self.productErrorLabel.text = "Error: \(viewModel.product.errorDescription ?? "None")"
        self.productColorLabel.text = "Color: \(DataManager.shared.getColor(id: viewModel.product.id) ?? "")"
        self.colorPickerView.selectRow(DataManager.shared.getColorIndex(id: viewModel.product.id ?? 0), inComponent: 0, animated: true)
    }
    
}

extension ProductDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataManager.shared.colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row < DataManager.shared.colors.count else { return nil }
        return DataManager.shared.colors[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < DataManager.shared.colors.count else { return }
        self.viewModel.product.color = DataManager.shared.colors[row].id
    }
}
