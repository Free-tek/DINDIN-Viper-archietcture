//
//  DrinksContainerViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import UIKit
import RxSwift
import RxCocoa


protocol DrinksView: class {
    
    func setUpElements() -> (Void)
    func setUpTableView() -> (Void)
    func initViewModel(drinksViewModelController: DrinksViewModelController) -> (Void)

   

}


class DrinksContainerViewController: UIViewController {

    
    @IBOutlet weak var drinksTableView: UITableView!
    @IBOutlet weak var drinksTableViewHeightConsttraint: NSLayoutConstraint!
    
    var presenter: DrinksPresentation!
    var drinksViewModelController: DrinksViewModelController = DrinksViewModelController()
    
    var disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let interactor = DrinksInteractor()
        let router = DrinksRouter(viewController: self)
        let sushiPresenter = DrinksPresenter(view: self, interactor: interactor, router: router)
        presenter = sushiPresenter
        
        
       self.presenter.viewDidLoad()
        
    }
    

}

extension DrinksContainerViewController: DrinksView{
    
    func setUpElements(){
        drinksTableView.alpha = 0
        drinksTableView.tableFooterView = UIView()
        drinksTableView.backgroundColor = UIColor.clear
        
        drinksTableView.delegate = self
        drinksTableView.dataSource = self
        drinksTableView.register(DrinksTableViewCell.nib(), forCellReuseIdentifier: DrinksTableViewCell.cellIdentifier)
        
        let screenSize = UIScreen.main.bounds
        let ScreenHeight = screenSize.height
        
        drinksTableViewHeightConsttraint.constant = ScreenHeight
        drinksTableView.layoutIfNeeded()
        
        
        
    }
    
    func setUpTableView(){
        drinksTableView.alpha = 1
        drinksTableView.reloadData()
        
    }
    
    func initViewModel(drinksViewModelController: DrinksViewModelController){
        self.drinksViewModelController =  drinksViewModelController
    }
    
    
}

extension DrinksContainerViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return drinksViewModelController.viewModelsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = drinksTableView.dequeueReusableCell(withIdentifier: DrinksTableViewCell.cellIdentifier, for: indexPath) as! DrinksTableViewCell

        
        if let viewModel = drinksViewModelController.viewModel(at: indexPath.row) {
            cell.configure(with: viewModel)
            
            
            cell.buyDrink.rx.tap
                .bind {
                    
                    self.takeOrder_Animate(viewModel: viewModel, sender: cell.buyDrink)
                    
                }
                .disposed(by: cell.disposeBag)
            
            
           
            
        
        }
        
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func takeOrder_Animate(viewModel: DrinksViewModel, sender: UIButton){
        
        let order = OrderModel(orderName: viewModel.drinksName, orderImage: viewModel.drinksImage, orderStoreId: viewModel.drinksStoreId, orderPrice: viewModel.drinksPrice)
        let newValue =  CartOrdersModel.seeOrders.orders.value + [order]
        CartOrdersModel.seeOrders.orders.accept(newValue)
        
        sender.backgroundColor = UIColor.green
        sender.setTitle("added + 1", for: .normal)
        
        Observable<Int>.interval(.milliseconds(25), scheduler: MainScheduler.instance)
            .map { 25 - $0 }
            .takeUntil(.inclusive, predicate: { $0 == 0 })
            .subscribe(onNext: { value in
            }, onCompleted: {
                sender.backgroundColor = UIColor.black
                sender.setTitle("\(viewModel.drinksPrice!) USD", for: .normal)
            }).disposed(by: self.disposeBag)
        
    }
    
}


