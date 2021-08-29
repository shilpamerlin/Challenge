//
//  ProductCell.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-26.
//

import UIKit

class ProductCell: UITableViewCell {
    var titleLabel = UILabel()
    var productImageView = UIImageView()
    var listPriceLabel = UILabel()
    var yourPriceLabel = UILabel()
    var favouriteButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
    var bestSellerBadgeImage = UIImageView()
    weak var delegate: FavouriteProduct?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(productImageView)
        addSubview(bestSellerBadgeImage)
        addSubview(listPriceLabel)
        addSubview(yourPriceLabel)
        addSubview(favouriteButton)
        configureProductImageView()
        configureProductTitleLabel()
        configureListPriceLabel()
        configureYourPriceLabel()
        configureBadgeLabel()
        configurefavouriteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureProductImageView() {
        productImageView.clipsToBounds = true
        productImageView.layer.borderWidth = 1
        productImageView.layer.borderColor = UIColor.lightGray.cgColor
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            productImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureProductTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        NSLayoutConstraint.activate([
             titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
             titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
             titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
    }
    
    func configureListPriceLabel() {
        listPriceLabel.textColor = UIColor(red: 0.482, green: 0.557, blue: 0.618, alpha: 1)
        listPriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        listPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            listPriceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            listPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configureYourPriceLabel() {
        yourPriceLabel.textColor = UIColor(red: 0.137, green: 0.184, blue: 0.224, alpha: 1)
        yourPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        yourPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yourPriceLabel.widthAnchor.constraint(equalToConstant: 90),
            yourPriceLabel.heightAnchor.constraint(equalToConstant: 23),
            yourPriceLabel.trailingAnchor.constraint(equalTo: listPriceLabel.leadingAnchor, constant: -8),
            yourPriceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            yourPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configureBadgeLabel() {
        bestSellerBadgeImage.clipsToBounds = true
        bestSellerBadgeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bestSellerBadgeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bestSellerBadgeImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            bestSellerBadgeImage.widthAnchor.constraint(equalToConstant: 100),
            bestSellerBadgeImage.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configurefavouriteButton() {
        let image = UIImage(named: "defaultFavourite") as UIImage?
        favouriteButton.setImage(image, for: .normal)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        favouriteButton.isUserInteractionEnabled = true
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favouriteButton.widthAnchor.constraint(equalToConstant: 40),
            favouriteButton.heightAnchor.constraint(equalToConstant: 40),
            favouriteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            favouriteButton.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    func configureProductCell(cellModel: ProductCellModel) {
        titleLabel.text = cellModel.title
        productImageView.sd_setImage(with: URL(string: cellModel.productImage ?? ""),
                                     placeholderImage: UIImage(named: "defaultImage"))
        let listPrice = String(format: "%.2f", cellModel.listPrice!)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$\(listPrice)")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: 1, range: NSMakeRange(0, attributeString.length))
        listPriceLabel.attributedText = attributeString
        let yourPrice = String(format: "%.2f", cellModel.yourPrice!)
        yourPriceLabel.text = "$\(yourPrice)"
        bestSellerBadgeImage.sd_setImage(with: URL(string: cellModel.badgeImageURL ?? ""), completed: nil)
        favouriteButton.setImage(cellModel.isFavourite! ?
                    UIImage(named: "defaultFavourite")! : UIImage(named: "favouriteActive")!, for: .normal)
    }
    
    @objc func favouriteButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            favouriteButton.setImage(UIImage(named: "defaultFavourite"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "favouriteActive"), for: .normal)
        }
        delegate?.getIndexPath(cell: self)
    }
}

// MARK: - Custom Delegation for making product 'favourite'
protocol FavouriteProduct: AnyObject {
    func getIndexPath(cell: UITableViewCell)
}
