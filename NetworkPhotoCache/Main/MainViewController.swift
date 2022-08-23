//
//  ViewController.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/5/15.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    
    // MARK: - UIs
    private let mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("next page", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    // MARK: - Setup Binding
    private func setupBinding() {
        mainButton.rx.tap
            .subscribe(onNext: {
                let vc = ColorViewController(viewModel: ColorViewModel())
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(mainButton)
        mainButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
}

