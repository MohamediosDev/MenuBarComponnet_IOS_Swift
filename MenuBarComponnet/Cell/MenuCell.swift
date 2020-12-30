//
//  MenuCell.swift
//  MenuBarComponnet
//
//  Created by Mohamed on 12/29/20.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.alpha = 0.6
    }
    
    func setUpCell(text:String) {
        
        
        titleLabel.text = text
    }
    
    override var isSelected: Bool {
        
        didSet{
            
            titleLabel.alpha = isSelected ? 1.0:0.6
            
        }
        
        
        
    }
    
}
