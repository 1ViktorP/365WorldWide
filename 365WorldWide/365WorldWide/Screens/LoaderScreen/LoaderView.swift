//
//  LoaderView.swift
//  365WorldWide
//
//  Created by MacBook on 24.07.2023.
//

import UIKit

class LoaderView: UIView {
    
    private let bgImageView = UIImageView()
    private let textimageView = UIImageView()
    let startButton = UIButton()
    let progressView = UIProgressView()
    
    init() {
        super.init(frame: .zero)
        setUp()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(bgImageView)
        addSubview(textimageView)
        addSubview(startButton)
        addSubview(progressView)
        startButton.isHidden = true
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor.mainYellowColor, for: .normal)
        startButton.layer.cornerRadius = 16
        startButton.layer.borderColor = UIColor.mainYellowColor.cgColor
        startButton.layer.borderWidth = 1
        bgImageView.image = UIImage(named: "loaderBG")
        textimageView.image = UIImage(named: "loaderText")
        progressView.trackTintColor = UIColor(red: 0.1765, green: 0.2157, blue: 0.2667, alpha: 1.0)
        progressView.progressTintColor = .mainYellowColor
    }
    
    private func setUpConstraints() {
        bgImageView.addEdgesConstraints(from: self)
        textimageView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textimageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textimageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            textimageView.heightAnchor.constraint(equalToConstant: 112),
            textimageView.widthAnchor.constraint(equalToConstant: 208),
            
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -40),
            startButton.heightAnchor.constraint(equalToConstant: 45),
            startButton.widthAnchor.constraint(equalToConstant: 243),
            
            progressView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -44),
            progressView.heightAnchor.constraint(equalToConstant: 4),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
}
