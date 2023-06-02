//
//  SelectionPopUpView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.06.2023.
//

import UIKit
import RxSwift

final class SelectionPopUpView: UIView {
    deinit {
        print("SelectionPopUpView deinit")
    }
    //MARK: - Creating UI Elements
    lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: "FBFCFE")
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var optionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SelectionPopUpCell.self, forCellWithReuseIdentifier: SelectionPopUpCell.identifier)
        collection.clipsToBounds = true
        collection.layer.cornerRadius = 12
        collection.layer.masksToBounds = true
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
        return collection
    }()
    
    lazy var buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var disMissButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "multiply"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .init(hex: "6279E0")
        
        return button
    }()
    
    lazy var openMapButton: UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.setImage(.init(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .init(hex: "6279E0")
        return button
    }()

    let emptyViewTapGesture = UITapGestureRecognizer()
    
    let contentViewTapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()

    //MARK: - Variables
    private var buttonIsHidden: Bool = true

    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        disMissButton.layer.cornerRadius = 40
        disMissButton.clipsToBounds = true
        
        openMapButton.layer.cornerRadius = 40
        openMapButton.clipsToBounds = true
    }
    
    func showButtons(buttonIsHidden: Bool) {
        if self.buttonIsHidden {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    guard let self else { return }
                    disMissButton.transform = CGAffineTransform(translationX: 15, y: 0)
                } completion: { [weak self] _ in
                    guard let self else { return }
                    UIView.animate(withDuration: 0.3) { [weak self] in
                        guard let self else { return }
                        openMapButton.alpha = 1
                        disMissButton.transform = CGAffineTransform(translationX: (-openMapButton.frame.origin.x / 2) + 10, y: 0)
                    }
                }
            }
        
        self.buttonIsHidden = buttonIsHidden

    }
    
    func animateContentViewAndDismissParent(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2) { [weak self ] in
            guard let self else { return }
            contentView.transform = CGAffineTransform(translationX: 0, y: -15)
        } completion: { [weak self ] _ in
            guard let self else { return }
            UIView.animate(withDuration: 0.5) {  [weak self ] in
                guard let self else { return }
                contentView.transform = CGAffineTransform(translationX: 0, y: 800)
                buttonView.transform = CGAffineTransform(translationX: 0, y: 500)
            } completion: { _ in
                completion()
            }
        }
    }
}

extension SelectionPopUpView: ViewProtocol {
    func configureView() {
        backgroundColor = .clear
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(emptyView)
        emptyView.addSubview(buttonView)
        buttonView.addSubview(disMissButton)
        buttonView.addSubview(openMapButton)
        emptyView.addGestureRecognizer(emptyViewTapGesture)
        emptyView.addSubview(contentView)
        contentView.addSubview(optionsCollectionView)
        optionsCollectionView.addGestureRecognizer(contentViewTapGesture)
    }
    
    func setupConstraints() {
        buttonConstraints()
        emptyViewConstraints()
        contentViewConstraints()
        optionsCollectionViewConstraints()
    }
    
    private func buttonConstraints() {
            buttonView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom)
            make.bottom.equalTo(emptyView.snp.bottom)
            make.leading.trailing.equalTo(emptyView)
        }
        
        disMissButton.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.center.equalTo(buttonView.snp.center)
        }
        
        openMapButton.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.trailing.equalTo(buttonView.snp.trailing).offset(-20)
            make.centerY.equalTo(buttonView.snp.centerY)
        }
    }
    
    private func emptyViewConstraints() {
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func contentViewConstraints() {
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-12)
            make.height.equalTo(self.snp.height).multipliedBy(0.65)
            make.center.equalTo(self.snp.center)
        }
    }
    
    private func optionsCollectionViewConstraints() {
        optionsCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.center.equalTo(contentView)
        }
    }
    
    
}
