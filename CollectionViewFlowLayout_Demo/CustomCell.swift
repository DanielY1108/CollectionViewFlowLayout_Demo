//
//  CollectionViewCell.swift
//  CollectionViewFlowLayout_Demo
//
//  Created by JINSEOK on 2023/04/11.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
