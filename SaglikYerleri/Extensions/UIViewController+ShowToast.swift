//
//  UIViewController+ShowToast.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 19.05.2023.
//

import UIKit

extension UIViewController {
    func showToast(message: String, delay: TimeInterval = 2.0) {
        guard let scene = UIApplication.shared.connectedScenes.first, let windowScene = scene as? UIWindowScene, let window = windowScene.windows.first else { return }
        
        let toastView = UIView()
        toastView.backgroundColor = .black.withAlphaComponent(0.3)
        toastView.layer.cornerRadius = 10
        
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = message
        
        toastView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(toastView.snp.leading).offset(8)
            make.trailing.equalTo(toastView.snp.trailing).offset(-8)
            make.top.equalTo(toastView.snp.top).offset(8)
            make.bottom.equalTo(toastView.snp.bottom).offset(-8)
        }
        
        window.addSubview(toastView)
        toastView.snp.makeConstraints { make in
            make.centerX.equalTo(window.snp.centerX)
            make.height.equalTo(65)
            make.bottom.equalTo(window.safeAreaLayoutGuide.snp.bottom).offset(100)
            make.leading.greaterThanOrEqualTo(window.snp.leading).offset(20)
            make.trailing.lessThanOrEqualTo(window.snp.trailing).offset(-20)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            toastView.transform = CGAffineTransform(translationX: 0, y: -150)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: delay) {
                toastView.transform = .identity
            } completion: { _ in
                toastView.removeFromSuperview()
            }
            
        }
    }}
