//
//  ColorViewController.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/5/15.
//

import UIKit
import Alamofire
import Kingfisher

class ColorController: UIViewController {
    //MARK: - Properties
    private let colorView = ColorView()
    var colorDatas = [ColorData]()
    
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = colorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
    }
    
    //MARK: - Setup CollectionView
    private func setupCollectionView() {
        colorView.colorCollectionView.dataSource = self
        colorView.colorCollectionView.delegate = self
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
                    self.colorView.colorCollectionView.reloadData()
                } catch {
                    print("\(error)")
                }
            }
        }
    }
}

//MARK: - CollectionViewDataSource
extension ColorController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath) as! ColorCollectionViewCell
        let colorData = colorDatas[indexPath.row]
        cell.colorImageView.image = nil
        cell.colorImageView.kf.indicatorType = .activity
        cell.colorImageView.kf.setImage(with: colorData.thumbnailUrl)
        cell.idLabel.text = colorData.id.description
        cell.titleLabel.text = colorData.title

        return cell
    }
}

//MARK: - CollectionViewDelegate
extension ColorController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = colorDatas[indexPath.row]
        let vc = DetailController(data: data)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CollectionViewDelegateFlowLayout
extension ColorController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //(collectionView.邊界.寬 - 間距大小 * cell有幾幾個間距) / 想要幾個cell
        let width = (collectionView.bounds.width - 5 * 3) / 4
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
