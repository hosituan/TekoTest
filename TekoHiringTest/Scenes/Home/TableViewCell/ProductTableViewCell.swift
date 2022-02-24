//
//  ProductTableViewCell.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import UIKit
import SnapKit
import Then
import SDWebImage

class ProductRowViewModel: CellPresentable {
    var index: IndexPath
    
    var cellIdentifier: String = ProductTableViewCell.className
    
    var cellHeight: CGFloat = UITableView.automaticDimension
    
    var imageUrl: String?
    var productName: String
    var errorText: String
    var productCode: String
    var productColor: String
    init(product: Product, index: IndexPath) {
        self.index = index
        self.imageUrl = product.image
        self.productName = product.name ?? "Haven't set" //Have to define string
        self.errorText = product.errorDescription ?? "Haven't set"
        self.productCode = product.sku ?? "Haven't set"
        self.productColor = DataManager.shared.getColor(id: product.color) ?? "Haven't set"
    }
    
}

class ProductTableViewCell: BaseTableViewCell {
    var tapEditAction: (() -> Void)?
    lazy var editButton = UIButton().then {
        let buttonImage = UIImage(systemName: "pencil")?.withRenderingMode(.alwaysOriginal)
        $0.setImage(buttonImage, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.cornerRadius = 10
        $0.borderWidth = 1
        $0.borderColor = .lightGray
        $0.setAction { [weak self] in
            self?.tapEditAction?()
        }
    }
    lazy var containerView = UIView().then {
        $0.borderColor = .lightGray
        $0.borderWidth = 1
        $0.cornerRadius = 10
    }
    lazy var productImageView = UIImageView().then { 
        $0.contentMode = .scaleAspectFill
        $0.cornerRadius = 5
        $0.backgroundColor = .lightGray
    }
    lazy var productNameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    lazy var errorTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    lazy var productCodeLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .left
    }
    lazy var colorLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .left
    }

    
    override func prepareForReuse() {
        self.productImageView.image = nil
        self.productNameLabel.text = nil
        self.errorTitleLabel.text = nil
        self.productCodeLabel.text = nil
        self.colorLabel.text = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(4)
            make.right.bottom.equalToSuperview().inset(4)
        }
        containerView.addSubviews(productImageView, productNameLabel, errorTitleLabel, productCodeLabel, colorLabel, editButton)
        
        productImageView.snp.makeConstraints { make in
            make.height.width.equalTo(64)
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        editButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.top.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
        }
        productNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(productImageView.snp.right).offset(8)
            make.right.equalToSuperview().inset(72)
        }
        errorTitleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(productNameLabel)
            make.top.equalTo(productNameLabel.snp.bottom).offset(4)
        }
        productCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(errorTitleLabel.snp.bottom).offset(4)
            make.left.right.equalTo(productNameLabel)
        }
        colorLabel.snp.makeConstraints { make in
            make.top.equalTo(productCodeLabel.snp.bottom).offset(4)
            make.left.right.equalTo(productNameLabel)
            make.bottom.equalToSuperview().inset(16)
        }
        
    }
}

extension ProductTableViewCell: CellCofigurable {
    func setup(model: CellPresentable) {
        guard let model = model as? ProductRowViewModel else {
            return
        }
        if let url = model.imageUrl {
            self.productImageView.loadImageWithLink(url, imageHolder: nil)
        }
        self.productNameLabel.text = "Name: \(model.productName)"
        self.productCodeLabel.text = "SKU: \(model.productCode)"
        self.errorTitleLabel.text = "Error: \(model.errorText)"
        self.colorLabel.text = "Color: \(model.productColor)"
    }
}
