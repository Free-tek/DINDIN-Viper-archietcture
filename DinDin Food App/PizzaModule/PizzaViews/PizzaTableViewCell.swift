//
//  PizzaTableViewCell.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import UIKit
import RxSwift
import RxCocoa

class PizzaTableViewCell: UITableViewCell {

    @IBOutlet weak var pizzaImage: UIImageView!
    @IBOutlet weak var pizzaName: UILabel!
    @IBOutlet weak var pizzaDescriptton: UILabel!
    @IBOutlet weak var pizzaPrice: UILabel!
    @IBOutlet weak var buyPizza: UIButton!
    
    static let cellIdentifier = "PizzaTableViewCell"
    
    var disposeBag = DisposeBag()
    
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
        disposeBag = DisposeBag()
                
    }
    
    func setUpElements(){
        
        buyPizza.layer.cornerRadius = 10
        buyPizza.layer.masksToBounds = true
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PizzaTableViewCell", bundle: nil)
    }

    public func configure(with viewModel: PizzaViewModel) {
        
        pizzaImage.setImage(with: viewModel.pizzaImage!)
        
        pizzaImage.roundCornersImage([.topRight, .topLeft], radius: 10)
        
        pizzaName.text = viewModel.pizzaName!
        pizzaDescriptton.text = viewModel.pizzaDescription!
        buyPizza.setTitle("\(viewModel.pizzaPrice!) USD", for: .normal)
        pizzaPrice.text = viewModel.pizzaStoreId!

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

private extension PizzaTableViewCell {
    static let defaultBackgroundColor = UIColor.groupTableViewBackground

    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = PizzaTableViewCell.defaultBackgroundColor
    }
}
