//
//  MainView.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/5/15.
//

import UIKit
import SnapKit

class MainView: UIView {
    //MARK: - UIs
    let MainButton: UIButton = {
        let button = UIButton()
        button.setTitle("next page", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        return button
    }()

    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        addSubview(MainButton)
        MainButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
