//
//  DetailView.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/5/15.
//

import UIKit
import SnapKit

class DetailView: UIView {

    //MARK: - UIs
    var detailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let idDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    let titleDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        addSubview(detailImageView)
        detailImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(400)
        }
        
        addSubview(idDetailLabel)
        idDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(detailImageView.snp.bottom).offset(40)
            make.leading.equalTo(20)
        }
        
        addSubview(titleDetailLabel)
        titleDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(idDetailLabel.snp.bottom).offset(40)
            make.leading.equalTo(10)
        }
    }

}
