//
//  DetailController.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/5/15.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController {
    // MARK: - Properties
    private let data: ColorData
//    var colorDatas = [ColorData]()
    
    // MARK: - UIs
    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let idDetailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        return label
    }()
    
    private let titleDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .textColor
        return label
    }()
    
    // MARK: - Init
    init(data: ColorData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dataBind()
    }
    
    // MARK: - Data Bind
    private func dataBind() {
        detailImageView.kf.indicatorType = .activity
        detailImageView.kf.setImage(with: data.thumbnailUrl)
        idDetailLabel.text = String(data.id)
        titleDetailLabel.text = data.title
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(detailImageView)
        detailImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        
        view.addSubview(idDetailLabel)
        idDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(detailImageView.snp.bottom).offset(40)
            make.leading.equalTo(20)
        }
        
        view.addSubview(titleDetailLabel)
        titleDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(idDetailLabel.snp.bottom).offset(40)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
    }
    
}
