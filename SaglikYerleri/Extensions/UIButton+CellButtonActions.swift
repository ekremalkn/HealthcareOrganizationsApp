//
//  UIButton+MakeCall.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 19.05.2023.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

extension Reactive where Base: UIButton {
    
    // Make Phone Call
    func makePhoneCall(phoneObservable: PublishSubject<(String ,String ,String ,String, MKMapItem)>, disposeBag: DisposeBag) {
        phoneObservable.subscribe(onNext: { [weak base] _, _, _, phoneNumber, _ in
            base?.rx.tap.subscribe(onNext: { _ in
                if !phoneNumber.isEmpty {
                    self.callPhoneNumber(with: phoneNumber)
                } else {
                    // Toast alert ile numaranın olmadığını söyle
                    findViewcontroller { viewController in
                        if let viewController {
                            viewController.showToast(message: "Telefon Numarası bulunamadı.")
                        }
                    }
                }
            }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
    }
    
    private func callPhoneNumber(with phoneNumber: String) {
        guard let phoneURL = URL(string: "tel:\(phoneNumber)") else { return }
        if UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL)
        }
    }
    
    // Share Content
    func shareContent(contentObservable: PublishSubject<(String ,String ,String ,String, MKMapItem)>, disposeBag: DisposeBag) {
        contentObservable.subscribe(onNext: { [weak base] name, address, directions, phoneNumber, mapItem in
            base?.rx.tap.subscribe(onNext: { _ in
                // Create content
                let nameItem = "Adı: \(name)"
                let addressItem = "Adresi: \(address)"
                let directionsItem = directions
                let phoneNumberItem = "Telefon: \(phoneNumber)"
                
                let activityItems: [Any] = [nameItem, "\n", addressItem, "\n", directionsItem, "\n", phoneNumberItem, "\n\n", mapItem]
                
                let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
                
                activityViewController.excludedActivityTypes = [.postToTwitter, .postToFacebook]
                
                findViewcontroller { viewController in
                    if let viewController {
                        viewController.present(activityViewController, animated: true)
                    }
                }
                
            }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
        
    }
    
    // Finding ViewController According To Button
    private func findViewcontroller(completion: @escaping (UIViewController?) -> Void) {
        var responder: UIResponder? = base
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                completion(viewController)
                return
            }
            responder = nextResponder
        }
        completion(nil)
    }
    
    
}
