//
//  ColorViewModel.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/6/15.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift
import RxRelay

protocol ColorViewModelInputs {
    var viewDidLoad: PublishRelay<()> { get }
}

protocol ColorViewModelOutputs {
    var colorDataList: Signal<[ColorData]> { get }
}

protocol ColorViewModelType {
    var inputs: ColorViewModelInputs { get }
    var outputs: ColorViewModelOutputs { get }
}

final class ColorViewModel:
    ColorViewModelInputs,
    ColorViewModelOutputs,
    ColorViewModelType
{
    
    // MARK: - Inputs
    public var viewDidLoad: PublishRelay<()>
    
    
    // MARK: - Outputs
    public var colorDataList: Signal<[ColorData]>
    
    
    public var inputs: ColorViewModelInputs { self }
    public var outputs: ColorViewModelOutputs { self }
    
    private let disposeBag = DisposeBag()
    
    init() {
        // inputs
        let viewDidLoad = PublishRelay<()>()
        self.viewDidLoad = viewDidLoad
        
        // outputs
        let colorDataList = PublishRelay<[ColorData]>()
        self.colorDataList = colorDataList.asSignal()
        
        viewDidLoad
            .flatMap { ColorImageService.getData() }
            .subscribe(onNext: { datas in
                var colorDatas = [ColorData]()
                datas.forEach { data in
                    colorDatas.append(
                        ColorData(
                            id: data.id,
                            title: data.title,
                            thumbnailUrl: data.thumbnailUrl
                        )
                    )
                }
                colorDataList.accept(datas)
            })
            .disposed(by: disposeBag)
    }
}
