//
//  ColorViewController.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/5/15.
//

import UIKit
import SnapKit
import RxSwift

class ColorViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: ColorViewModelType
    private let disposeBag = DisposeBag()
    
    // MARK: - UIs
    private let colorCollectionView = ColorCollectionView()
    
    
    // MARK: - Init
    init(viewModel: ColorViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        colorCollectionView.cellDelegate = self
        setupUI()
        setupBinding()
        viewModel.inputs.viewDidLoad.accept(())
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(colorCollectionView)
        colorCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Setup Binding
    private func setupBinding() {
        viewModel.outputs
            .colorDataList
            .emit(onNext: { [weak self] list in
                self?.colorCollectionView.setColorData(list: list)
            })
            .disposed(by: disposeBag)
    }
}

extension ColorViewController: CollectionViewCellDelegate {
    func pushViewController(data: ColorData) {
        let vc = DetailViewController(data: data)
        navigationController?.pushViewController(vc, animated: true)
    }
}
