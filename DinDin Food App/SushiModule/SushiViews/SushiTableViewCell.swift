//
//  SushiTableViewCell.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import UIKit
import RxSwift
import RxCocoa

class SushiTableViewCell: UITableViewCell {

    
    @IBOutlet weak var sushiImage: UIImageView!
    @IBOutlet weak var sushiName: UILabel!
    @IBOutlet weak var sushiDescription: UILabel!
    @IBOutlet weak var sushiPrice: UILabel!
    @IBOutlet weak var buySushiButton: UIButton!
    
    
    static let cellIdentifier = "SushiTableViewCell"
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
        
        buySushiButton.layer.cornerRadius = 10
        buySushiButton.layer.masksToBounds = true
        
    
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SushiTableViewCell", bundle: nil)
    }

    public func configure(with viewModel: SushiViewModel) {
        
        sushiImage.setImage(with: viewModel.susshiImage!)
        
        sushiImage.roundCornersImage([.topRight, .topLeft], radius: 10)
  
        
        sushiName.text = viewModel.susshiName!
        sushiDescription.text = viewModel.susshiDescription!
        sushiPrice.text = viewModel.susshiStoreId
        buySushiButton.setTitle("\(viewModel.susshiPrice!) USD", for: .normal)

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

private extension SushiTableViewCell {
    static let defaultBackgroundColor = UIColor.groupTableViewBackground

    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = SushiTableViewCell.defaultBackgroundColor
    }
}


