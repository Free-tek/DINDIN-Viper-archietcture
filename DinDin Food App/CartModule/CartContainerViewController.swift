//
//  CartContainerViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import UIKit
import RxSwift
import RxCocoa


protocol CartView: class {
    
    func setUpElements() -> (Void)
    func setUpTableView() -> (Void)
    func initViewModel(cartViewModelController: CartViewModelController) -> (Void)
    func setupTotalAmountObserver() -> (Void)
    func setupTableViewOrdersDataObserver() -> (Void)


}


class CartContainerViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var cartTableViewHeighttConstraints: NSLayoutConstraint!
    
    var presenter: CartPresentation!
    var cartViewModelController: CartViewModelController = CartViewModelController()
    
    @IBOutlet weak var totalOrder: UILabel!
    var disposeBag = DisposeBag()
    
    
    let doubleTapGesture = UITapGestureRecognizer()
    let singleTapGesture = UITapGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let interactor = CartInteractor()
        let router = CartRouter(viewController: self)
        let cartPresenter = CartPresenter(view: self, interactor: interactor, router: router)
        presenter = cartPresenter
        
        
       self.presenter.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.cartTableViewHeighttConstraints?.constant = self.cartTableView.contentSize.height
    }
    
    
    

}


extension CartContainerViewController: CartView{
    
    func setUpElements(){
        cartTableView.alpha = 0
        cartTableView.tableFooterView = UIView()
        cartTableView.backgroundColor = UIColor.clear
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(CartTableViewCell.nib(), forCellReuseIdentifier: CartTableViewCell.cellIdentifier)
        
        let screenSize = UIScreen.main.bounds
        let ScreenHeight = screenSize.height
        
        doubleTapGesture.numberOfTapsRequired = 2
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.require(toFail: doubleTapGesture)
        
       
    }
    
    func setUpTableView(){
        cartTableView.alpha = 1
        cartTableView.reloadData()
        
    }
    
    func initViewModel(cartViewModelController: CartViewModelController){
        self.cartViewModelController =  cartViewModelController
    }
    
    func setupTotalAmountObserver() {
        
        CartOrdersModel.seeOrders.orders.asObservable()
        .subscribe(onNext: {
          [unowned self] orders in
            
            totalOrder.text = "\(cartViewModelController.totalPriceOfOrders) USD"
        
        })
        .disposed(by: disposeBag)
    }
    
    
    func setupTableViewOrdersDataObserver() {
        
        cartViewModelController.viewModels.asObservable()
            .subscribe(onNext: {_ in
                if self.cartViewModelController.viewModelsCount == 0{
                    self.totalOrder.text = "0 USD"
                }else{
                    self.totalOrder.text = "\(self.cartViewModelController.totalPriceOfOrders) USD"
                }

        })
        .disposed(by: disposeBag)
    }
    
    
}

extension CartContainerViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cartViewModelController.viewModelsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.cellIdentifier, for: indexPath) as! CartTableViewCell

        
        if let viewModel = cartViewModelController.viewModel(at: indexPath.row) {
            cell.configure(with: viewModel)
            
            
           
            
            
            cell.cancelOrder.rx.tap
                .bind{
                    
                    
                    if CartOrdersModel.seeOrders.orders.value.count > 0{

                        var newValue = CartOrdersModel.seeOrders.orders.value
                        newValue.remove(at: indexPath.row)
                        CartOrdersModel.seeOrders.orders.accept(newValue)


                        var _newValue =  self.cartViewModelController.viewModels.value
                        _newValue.remove(at: indexPath.row)
                        self.cartViewModelController.viewModels.accept(_newValue)

                    
                        self.cartTableView.deleteRows(at: [indexPath], with: .fade)
                        self.cartTableView.reloadData()
                        
                        
                        self.viewWillLayoutSubviews()
                        

                    }

                    
                    
                    
                }
                .disposed(by: cell.disposeBag)
            
            
//            cell.cancelOrder.rx.tap
//                .bind {
//
//                    print("just got clicked \(self.count)")
//                    self.count = self.count + 1

//                    if CartOrdersModel.seeOrders.orders.value.count > 0{
//
////                        var newValue = CartOrdersModel.seeOrders.orders.value
////                        print("this are your orders \(newValue) :: count- \(CartOrdersModel.seeOrders.orders.value.count) :: index- \(indexPath.row)")
////
////                        newValue.remove(at: indexPath.row)
////                        CartOrdersModel.seeOrders.orders.accept(newValue)
////
//
//                        print("this are your viewmodel orders \(self.cartViewModelController.viewModels.value)")
//                        var _newValue =  self.cartViewModelController.viewModels.value
//                        _newValue.remove(at: indexPath.row)
//                        self.cartViewModelController.viewModels.accept(_newValue)
//
//                        self.cartTableView.beginUpdates()
//                        self.cartTableView.deleteRows(at: [indexPath], with: .automatic)
//                        self.cartTableView.endUpdates()



                        //cartViewModelController.viewModels.remove(at: indexPath.row)

                    //}

//                }
//                .disposed(by: disposeBag)
       
        }
        
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
  
    
}




