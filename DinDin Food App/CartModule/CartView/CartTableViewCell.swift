//
//  CartTableViewCell.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import UIKit
import RxSwift
import RxCocoa

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var orderThumbnail: UIImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var cancelOrder: UIButton!
    
    
    static let cellIdentifier = "CartTableViewCell"
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        setOpaqueBackground()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
                
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CartTableViewCell", bundle: nil)
    }

    public func configure(with viewModel: CartViewModel) {
        
        orderThumbnail.setImage(with: viewModel.orderImage!)
        
        
        orderThumbnail.layer.cornerRadius = 5
        orderThumbnail.layer.masksToBounds = true
        
        orderName.text = viewModel.orderName!
        orderPrice.text = "\(viewModel.orderPrice!) USD"
        

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

private extension CartTableViewCell {
    static let defaultBackgroundColor = UIColor.groupTableViewBackground

    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = CartTableViewCell.defaultBackgroundColor
    }
}


