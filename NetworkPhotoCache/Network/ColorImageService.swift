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
