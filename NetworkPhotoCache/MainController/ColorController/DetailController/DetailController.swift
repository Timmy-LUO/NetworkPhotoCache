//
//  DetailController.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/5/15.
//

import UIKit
import Alamofire
import Kingfisher

class DetailController: UIViewController {
    //MARK: - Properties
    private let detailView = DetailView()
    private let data: ColorData
    var colorDatas = [ColorData]()
    
    
    //MARK: - Init
    init(data: ColorData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        detailView.detailImageView.kf.indicatorType = .activity
        detailView.detailImageView.kf.setImage(with: data.thumbnailUrl)
        detailView.idDetailLabel.text = String(data.id)
        detailView.titleDetailLabel.text = data.title
    }
    
    //MARK: Fetch Data
    func fetchData() {
        let url: String = "https://jsonplaceholder.typicode.com/photos"
        AF.request(url).response { response in
            debugPrint("Status: \(String(describing: response.response?.statusCode))")
            if let data = response.data {
                print("data: \(data)")
                do {
                    let decoder = JSONDecoder()
                    let colorDatas = try decoder.decode([ColorData].self, from: data)
                    self.colorDatas = colorDatas
                } catch {
                    print("\(error)")
                }
            }
        }
    }
}
