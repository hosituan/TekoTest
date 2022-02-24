//
//  ViewController.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import UIKit
import Alamofire
import Then
import SnapKit
import ESPullToRefresh
import SVProgressHUD

class HomeViewController: BaseViewController {
    let viewModel = HomeViewModel()
    lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.registerCells(ProductTableViewCell.self)
        $0.delegate = self
        $0.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product Correction"
        viewModel.getProduct()
    }

    override func setupView() {
        super.setupView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setUpRefreshAndMoreData()
        
    }
    
    override func observe() {
        super.observe()
        viewModel.models
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
                // Stop pull to refresh if needed
                self.tableView.es.stopPullToRefresh()
                
                // Stop and disable loading more if needed
                self.tableView.es.stopLoadingMore()
                if self.viewModel.isLoadMore == false {
                    self.tableView.es.noticeNoMoreData()
                }
            })
            .disposed(by: bag)
        
    }
    
    
    private func setUpRefreshAndMoreData() {
        let footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
        footer.loadingDescription = "Loading.."
        footer.loadingMoreDescription = "Loading more.."
        footer.noMoreDataDescription = "No more data"
        tableView.es.addInfiniteScrolling(animator: footer) { [weak self] in
            guard let self = self else { return }
            self.viewModel.getProduct(withProcessing: false)
        }
    }
    
    func showEditProduct(at index: IndexPath) {
        guard let product = viewModel.productAt(indexPath: index) else { return }
        let detailViewController = ProductDetailViewController()
        detailViewController.viewModel = ProductDetailViewModel(index: index, product: product)
        detailViewController.delegate = self
        detailViewController.setPopup()
        visibleViewController()?.present(detailViewController, animated: true, completion: nil)
    }

}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeight(at: indexPath)
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel.modelAt(at: indexPath) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath)
        if let cell = cell as? CellCofigurable {
            cell.setup(model: model)
        }
        if let cell = cell as? ProductTableViewCell {
            cell.tapEditAction = { [weak self] in
                self?.showEditProduct(at: indexPath)
            }
        }
        return cell
    }
}

extension HomeViewController: ProductDetailDelegate {
    func updateProduct(at index: IndexPath, to product: Product) {
        viewModel.updateProduct(at: index, to: product)
    }

}

