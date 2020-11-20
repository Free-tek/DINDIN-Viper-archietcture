//
//  PizzaContainerViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import UIKit
import RxSwift
import RxCocoa

protocol PizzaView: class {
    
    func setUpElements() -> (Void)
    func setUpTableView() -> (Void)
    func initViewModel(pizzaViewModelController: PizzaViewModelController) -> (Void)
    
    
}


class PizzaContainerViewController: UIViewController {

    @IBOutlet weak var pizzaTableView: UITableView!
    @IBOutlet weak var pizzaTableViewViewConstraint: NSLayoutConstraint!

    var presenter: PizzaPresentation!
    var pizzaViewModelController: PizzaViewModelController = PizzaViewModelController()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let interactor = PizzaInteractor()
        let router = PizzaRouter(viewController: self)
        let pizzaPresenter = PizzaPresenter(view: self, interactor: interactor, router: router)
       presenter = pizzaPresenter
        
       self.presenter.viewDidLoad()
    
    }
    
    

}

extension PizzaContainerViewController: PizzaView{
    
    func setUpElements(){
        pizzaTableView.alpha = 0
        pizzaTableView.tableFooterView = UIView()
        pizzaTableView.backgroundColor = UIColor.clear
        
        pizzaTableView.delegate = self
        pizzaTableView.dataSource = self
        pizzaTableView.register(PizzaTableViewCell.nib(), forCellReuseIdentifier: PizzaTableViewCell.cellIdentifier)
        
        let screenSize = UIScreen.main.bounds
        let ScreenHeight = screenSize.height
        
        pizzaTableViewViewConstraint.constant = ScreenHeight
        pizzaTableView.layoutIfNeeded()
        
    }
    
    func setUpTableView(){
        pizzaTableView.alpha = 1
        pizzaTableView.reloadData()
        
    }
    
    func initViewModel(pizzaViewModelController: PizzaViewModelController){
        self.pizzaViewModelController =  pizzaViewModelController
    }
    
}

extension PizzaContainerViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaViewModelController.viewModelsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pizzaTableView.dequeueReusableCell(withIdentifier: PizzaTableViewCell.cellIdentifier, for: indexPath) as! PizzaTableViewCell

        
        if let viewModel = pizzaViewModelController.viewModel(at: indexPath.row) {
            cell.configure(with: viewModel)
            
            cell.buyPizza.rx.tap
                .bind {
                    
                    self.takeOrder_Animate(viewModel: viewModel, sender: cell.buyPizza)
                    
                }
                .disposed(by: cell.disposeBag)
        }
        
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        
        return cell
    }

    func takeOrder_Animate(viewModel: PizzaViewModel, sender: UIButton){
        
        let order = OrderModel(orderName: viewModel.pizzaName, orderImage: viewModel.pizzaImage, orderStoreId: viewModel.pizzaStoreId, orderPrice: viewModel.pizzaPrice)
        let newValue =  CartOrdersModel.seeOrders.orders.value + [order]
        CartOrdersModel.seeOrders.orders.accept(newValue)
        
        sender.backgroundColor = UIColor.green
        sender.setTitle("added + 1", for: .normal)
        
        Observable<Int>.interval(.milliseconds(30), scheduler: MainScheduler.instance)
            .map { 30 - $0 }
            .takeUntil(.inclusive, predicate: { $0 == 0 })
            .subscribe(onNext: { value in
            }, onCompleted: {
                sender.backgroundColor = UIColor.black
                sender.setTitle("\(viewModel.pizzaPrice!) USD", for: .normal)
            }).disposed(by: self.disposeBag)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }


    
}
