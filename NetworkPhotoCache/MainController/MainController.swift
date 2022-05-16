//
//  ViewController.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/5/15.
//

import UIKit

class MainController: UIViewController {
    //MARK: - Properties
    private let mainView = MainView()
    
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.MainButton.addTarget(self, action: #selector(touch), for: .touchUpInside)
    }

    //MARK: - Methods
    @objc
    func touch() {
        let vc = ColorController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

