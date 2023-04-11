//
//  FooterReusableView.swift
//  CollectionViewFlowLayout_Demo
//
//  Created by JINSEOK on 2023/04/11.
//

import UIKit

class FooterReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
