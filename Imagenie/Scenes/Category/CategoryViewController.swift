//
//  CategoryViewController.swift
//  Imagenie
//
//  Created by Abdur Rehman on 30/06/2021.
//

import UIKit

protocol CategoryDisplayLogic: class{
    func displayCategoryItems(viewModel: Category.Item.ViewModel)
}

class CategoryViewController: UIViewController, CategoryDisplayLogic{
    var interactor: CategoryBusinessLogic?
    var router: (NSObjectProtocol & CategoryRoutingLogic & CategoryDataPassing)?

    var currentSnapshot: NSDiffableDataSourceSnapshot<Int, CategoryItem>! = nil
    var dataSource: UICollectionViewDiffableDataSource<Int, CategoryItem>! = nil
    var collectionView: UICollectionView! = nil

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }

    private func setup(){
        let viewController = self
        let interactor = CategoryInteractor()
        let presenter = CategoryPresenter()
        let router = CategoryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad(){
        super.viewDidLoad()

        configureHierarchy()
        configureDataSource()
        setupNavigationTitle()
        fetchCategoryItems()
    }

    func setupNavigationTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        title = router?.dataStore?.category
    }

    func fetchCategoryItems(){
        guard let dataStore = router?.dataStore?.category else{
            self.dismiss(animated: true)
            return
        }

        if !dataStore.isEmpty{
            interactor?.fetchCategoryItems(request: Category.Item.Request())
        }
    }

    func displayCategoryItems(viewModel: Category.Item.ViewModel) {
        currentSnapshot = dataSource.snapshot()
        currentSnapshot.appendItems(viewModel.data, toSection: 0)
        dataSource.apply(currentSnapshot)
    }

    func clearSearchItems(){
        currentSnapshot = dataSource.snapshot()
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: 0))
        dataSource.apply(currentSnapshot)
    }
}

extension CategoryViewController{
    private func gridSectionVertical() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return section
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout =  UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            return self.gridSectionVertical()
        }
        return layout
    }

    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self

        collectionView.register(UINib(nibName: Identifier.Cell.grid, bundle: nil), forCellWithReuseIdentifier: Identifier.Cell.grid)

        view.addSubview(collectionView)
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, CategoryItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: CategoryItem) -> UICollectionViewCell? in

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Identifier.Cell.grid,
                for: indexPath) as! GridCollectionViewCell

            cell.imgView.kf.setImage(with: URL(string: identifier.previewURL!))
            return cell
        }

        currentSnapshot = NSDiffableDataSourceSnapshot<Int, CategoryItem>()
        currentSnapshot.appendSections([0])
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

extension CategoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.navigateToDetailsView(item: indexPath.item)
    }
}

extension CategoryViewController:UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            clearSearchItems()
        }else{
            interactor?.fetchSearchItems(request: Category.Item.Request(q: searchText))
        }
    }

    func didPresentSearchController(_ searchController: UISearchController) {
        router?.dataStore?.isSearchControllerActive = true
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        router?.dataStore?.isSearchControllerActive = false
    }
}
