//
//  SushiContainerViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import UIKit

protocol SushiView: class {
    
    func setUpElements() -> (Void)
    func setUpTableView() -> (Void)
    func initViewModel(sushiViewModelController: SushiViewModelController) -> (Void)
    
}

class SushiContainerViewController: UIViewController {

    @IBOutlet weak var susshiTableView: UITableView!
    @IBOutlet weak var sushiTableViewHeightConstraint: NSLayoutConstraint!
    
    
    var presenter: SushiPresentation!
    var sushiViewModelController: SushiViewModelController = SushiViewModelController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let interactor = SushiInteractor()
        let router = SushiRouter(viewController: self)
        let sushiPresenter = SushiPresenter(view: self, interactor: interactor, router: router)
        presenter = sushiPresenter
        
        
       self.presenter.viewDidLoad()
    
    }
    


}

extension SushiContainerViewController: SushiView{
    
    func setUpElements(){
        susshiTableView.alpha = 0
        susshiTableView.tableFooterView = UIView()
        susshiTableView.backgroundColor = UIColor.clear
        
        susshiTableView.delegate = self
        susshiTableView.dataSource = self
        susshiTableView.register(SushiTableViewCell.nib(), forCellReuseIdentifier: SushiTableViewCell.cellIdentifier)
        
        let screenSize = UIScreen.main.bounds
        let ScreenHeight = screenSize.height
        
        sushiTableViewHeightConstraint.constant = ScreenHeight
        susshiTableView.layoutIfNeeded()
        
    }
    
    func setUpTableView(){
        susshiTableView.alpha = 1
        susshiTableView.reloadData()
        
    }
    
    func initViewModel(sushiViewModelController: SushiViewModelController){
        self.sushiViewModelController =  sushiViewModelController
    }
    
}

extension SushiContainerViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sushiViewModelController.viewModelsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = susshiTableView.dequeueReusableCell(withIdentifier: SushiTableViewCell.cellIdentifier, for: indexPath) as! SushiTableViewCell

        
        if let viewModel = sushiViewModelController.viewModel(at: indexPath.row) {
            cell.configure(with: viewModel)
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


    
}

