//
//  RoundedImageView.swift
//  Imagenie
//
//  Created by Abdur Rehman on 30/06/2021.
//

import UIKit

class RoundedImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setupView()
    }
    
    func setupView(){
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 2)
        contentMode = .scaleAspectFill
    }
}
