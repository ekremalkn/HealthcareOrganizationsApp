//
//  LoadingView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 4.05.2023.
//

import UIKit
import Lottie

enum AnimationType {
    case splashAnimation
    case loadingAnimation
}

public final class AnimationView: UIView {

    var animationView: LottieAnimationView?
    var animationView2: LottieAnimationView?
    
    //MARK: - Init Methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(animationType: AnimationType) {
        self.init(frame: .zero)
        set(animationType: animationType)
    }
    
    func set(animationType: AnimationType) {
        switch animationType {
        case .splashAnimation:
            self.animationView = .init(name: "SplashAnimation")
            self.animationView2 = .init(name: "LoadingAnimation")
            setupAnimationView(animationType: animationType)
        case .loadingAnimation:
            self.animationView = .init(name: "LoadingAnimation")
            setupAnimationView(animationType: animationType)
        }
    }

    private func setupAnimationView(animationType: AnimationType) {
        guard let animationView else { return}
        switch animationType {
        case .splashAnimation:
            guard let animationView2 else { return }
            self.setupSplashAnimationView(animationView: animationView, animationView2: animationView2)
        case .loadingAnimation:
            self.setupLoadingAnimationView(animationView: animationView)
        }
        
    }
    
    private func setupSplashAnimationView(animationView: LottieAnimationView, animationView2: LottieAnimationView) {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
        
        animationView2.contentMode = .scaleAspectFit
        animationView2.loopMode = .loop
        animationView2.animationSpeed = 1
        animationView2.play()
        
        self.addSubview(animationView)
        self.addSubview(animationView2)
        
        animationView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.height.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        animationView2.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).offset(30)
            make.centerX.equalTo(animationView.snp.centerX)
            make.height.width.equalTo(64)
        }
    }
    
    private func setupLoadingAnimationView(animationView: LottieAnimationView) {
        self.addSubview(animationView)
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
        
        animationView.snp.makeConstraints { make in
            make.height.width.equalTo(64)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.centerY)
        }
    }
}
