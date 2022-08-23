//
//  rr.swift
//  NetworkPhotoCache
//
//  Created by 羅承志 on 2022/6/15.
//

import Foundation
import Alamofire
import RxSwift

class ColorImageService {

    // RxSwift Alamofire
    static func getData() -> Observable<[ColorData]> {
        return Observable<[ColorData]>.create { emitter in
            let url: String = "https://jsonplaceholder.typicode.com/photos"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
                .response { response in
                    debugPrint("Status: \(String(describing: response.response?.statusCode))")
                    guard let responseData = response.data else {
                        return
                    }
                    
                    do {
                        let data = try JSONDecoder().decode(
                            [ColorData].self,
                            from: responseData
                        )
                        emitter.onNext(data)
                    } catch {
                        print("Error: \(error)")
                    }
                }
            return Disposables.create()
        }
    }
}
    
//    func fetchData() {
//        let url: String = "https://jsonplaceholder.typicode.com/photos"
//        AF.request(url).response { response in
//            debugPrint("Status: \(String(describing: response.response?.statusCode))")
//            if let error = response.error {
//                print("Response Error = \(error)")
//                self.onError?(error)
//                return
//            }
//
//            guard let data = response.data else { return }
//            print("Data: \(data)")
//            do {
//                let decoder = JSONDecoder()
//                let colorDatas = try decoder.decode([ColorData].self, from: data)
//                self.colorDatas = colorDatas
//                self.collectionView.reloadData()
//            } catch {
//                print("Data Error: \(error)")
//                self.onError?(error)
//            }
//        }
//    }
