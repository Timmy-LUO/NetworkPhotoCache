//
//  ColorCollectionViewCell.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/5/15.
//

import UIKit
import SnapKit
import Kingfisher
import RxGesture
import RxSwift

class ColorCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ColorCollectionViewCell"
    
    // MARK: - Properties
    weak var cellDelegate: CollectionViewCellDelegate?
    private var disposeBag = DisposeBag()
    
    
    // MARK: - UIs
    private let colorImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 5)
        label.numberOfLines = 0
        label.textColor = .textColor
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // MARK: - bind
    func bind(data: ColorData) {
        idLabel.text = data.id.description
        titleLabel.text = data.title
        colorImageView.kf.indicatorType = .activity
        colorImageView.kf.setImage(with: data.thumbnailUrl)
        
        colorImageView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.cellDelegate?.pushViewController(data: data)
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(colorImageView)
        colorImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        colorImageView.addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.centerX.equalTo(colorImageView.snp.centerX)
            make.top.equalTo(5)
            make.leading.equalTo(colorImageView.snp.leading).offset(10)
            make.trailing.equalTo(colorImageView.snp.trailing).offset(-10)
            make.height.equalTo(25)
            
        }
        
        colorImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.leading.equalTo(5)
            make.trailing.bottom.equalTo(-5)
        }
    }
}
