//
//  ColorCollectionViewCell.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/5/15.
//

import UIKit
import SnapKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "colorCollectionViewCell"
    
    var colorData: ColorData!
    
    //MARK: - UIs
    let colorImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        contentView.addSubview(colorImageView)
        colorImageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self)
        }
        
        contentView.addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.centerX.equalTo(colorImageView.snp.centerX)
            make.top.equalTo(10)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
//            make.centerX.equalTo(colorImageView.snp.centerX)
            make.leading.equalTo(5)
            make.trailing.equalTo(-5)
            make.bottom.equalTo(-5)
        }
    }
}
