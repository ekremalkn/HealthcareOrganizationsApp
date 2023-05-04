//
//  LoadingView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 4.05.2023.
//

import UIKit
import Lottie

public final class LoadingView: UIView {

    var animationView: LottieAnimationView?
    
    //MARK: - Init Methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        self.animationView = .init(name: "LoadingView")
        setupAnimationView()
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1.5
    }

    private func setupAnimationView() {
        guard let animationView else { return}
        self.addSubview(animationView)
        
        animationView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
