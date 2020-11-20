//
//  DrinksTableViewCell.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import UIKit

class DrinksTableViewCell: UITableViewCell {

    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkDescription: UILabel!
    @IBOutlet weak var drinkPrice: UILabel!
    @IBOutlet weak var buyDrink: UIButton!
    
    static let cellIdentifier = "DrinksTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpElements()
        setOpaqueBackground()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
                
    }
    
    func setUpElements(){
        
        buyDrink.layer.cornerRadius = 10
        buyDrink.layer.masksToBounds = true
        
    
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DrinksTableViewCell", bundle: nil)
    }

    public func configure(with viewModel: DrinksViewModel) {
        
        drinkImage.setImage(with: viewModel.drinksImage!)
        
        
        drinkImage.layer.cornerRadius = 10
        drinkImage.layer.masksToBounds = true
        
        drinkName.text = viewModel.drinksName!
        drinkDescription.text = viewModel.drinksDescription!
        drinkPrice.text = "\(viewModel.drinksStoreId!)"
        buyDrink.setTitle(" $\(viewModel.drinksPrice!)", for: .normal)
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        contentView.frame = contentView.frame.inset(by: margins)
        
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
    
    
}

private extension DrinksTableViewCell {
    static let defaultBackgroundColor = UIColor.groupTableViewBackground

    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = DrinksTableViewCell.defaultBackgroundColor
    }
}


