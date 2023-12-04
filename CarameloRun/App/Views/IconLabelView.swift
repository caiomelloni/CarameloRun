//
//  IconLabelView.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 30/11/23.
//

import Foundation
import UIKit

class IconLabelView: UIView {
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    let label: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupSubviews()
        }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupSubviews()
        }
    
    private func setupSubviews() {
            addSubview(imageView)
            addSubview(label)
            
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
                label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
                label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
                
            ])
        
            label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)

        }
        
        func configure(with image: UIImage?, text: String) {
            imageView.image = image
            label.text = text
          
        }
}
