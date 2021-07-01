//
//  HomeViewController.swift
//  Imagenie
//
//  Created by Abdur Rehman on 29/06/2021.
//

import UIKit
import Kingfisher

protocol HomeDisplayLogic: class{
    func displayHomeItems(viewModel: Home.Item.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic{
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    var currentSnapshot: NSDiffableDataSourceSnapshot<HomeSection, HomeItem>! = nil
    var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>! = nil
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        addSearchController()
        configureHierarchy()
        configureDataSource()
        fetchHomeItems()
    }

    func fetchHomeItems(){
        HomeSection.allCases.forEach{(
            interactor?.fetchHomeItems(request: Home.Item.Request(type: $0))
        )}

        interactor?.fetchHomeItems(request: Home.Item.Request(type: .EdChoice))
    }

    func addSearchController(){
        let searchViewController = UIStoryboard(name: Identifier.Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: Identifier.Controller.category) as! CategoryViewController
        let searchController = UISearchController(searchResultsController: searchViewController)
        searchController.delegate = searchViewController
        searchController.searchBar.delegate = searchViewController
        searchController.searchResultsUpdater = searchViewController
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.alpha = 0.8
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func displayHomeItems(viewModel: Home.Item.ViewModel) {
        currentSnapshot = dataSource.snapshot()
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: viewModel.type))
        currentSnapshot.appendItems(viewModel.data, toSection: viewModel.type)
        dataSource.apply(currentSnapshot)
    }
}

extension HomeViewController{
    private func gridSectionLargeHorizontal() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.95))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading:4, bottom: 8, trailing: 4)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92),
                                               heightDimension: .fractionalHeight(0.30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [getSectionHeader(), getSectionFooter()]
        return section
    }

    private func gridSectionRegularHorizontal() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.95))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading:4, bottom: 8, trailing: 2)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                               heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [getSectionHeader(), getSectionFooter()]
        return section
    }

    private func getSectionHeader()->NSCollectionLayoutBoundarySupplementaryItem{
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(50.0))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                           elementKind: UICollectionView.elementKindSectionHeader,
                                                           alignment: .top)
    }

    private func getSectionFooter()->NSCollectionLayoutBoundarySupplementaryItem{
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                heightDimension: .absolute(0.5))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                           elementKind: UICollectionView.elementKindSectionFooter,
                                                           alignment: .bottom)
    }

    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            if HomeSection(rawValue: sectionNumber) == HomeSection.EdChoice{
                return self.gridSectionLargeHorizontal()
            }else{
                return self.gridSectionRegularHorizontal()
            }
        }
    }

    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self

        collectionView.register(UINib(nibName: Identifier.Cell.grid, bundle: nil), forCellWithReuseIdentifier: Identifier.Cell.grid)
        collectionView.register(UINib(nibName: Identifier.Cell.header, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Identifier.Cell.header)
        collectionView.register(UINib(nibName: Identifier.Cell.footer, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Identifier.Cell.footer)

        view.addSubview(collectionView)
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<HomeSection, HomeItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: HomeItem) -> UICollectionViewCell? in

            let sectionIdentifier = self.currentSnapshot.sectionIdentifiers[indexPath.section]
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Identifier.Cell.grid,
                for: indexPath) as! GridCollectionViewCell

            cell.imgView.kf.setImage(with: URL(string: sectionIdentifier == .EdChoice ? (identifier.largeImageURL!) : (identifier.previewURL!)))

            return cell
        }

        dataSource.supplementaryViewProvider = { [self]
            (collectionView: UICollectionView,kind: String,indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == "UICollectionElementKindSectionHeader"{
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                 withReuseIdentifier: Identifier.Cell.header,
                                                                                 for: indexPath) as! HeaderCollectionReusableView

                let sectionIdentifier = self.currentSnapshot.sectionIdentifiers[indexPath.section]
                headerView.headerLbl.text = HomeSectionHeader[sectionIdentifier]
                headerView.seeMoreBtn.isHidden = sectionIdentifier == .EdChoice
                headerView.seeMoreTapped = {
                    router?.navigateToCategoryView(forCategory: HomeSectionHeader[sectionIdentifier]!)
                }
                
                return headerView
            }else{
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: Identifier.Cell.footer,
                                                                       for: indexPath) as! FooterCollectionReusableView
            }
        }

        currentSnapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
        currentSnapshot.appendSections(HomeSection.allCases)
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

extension HomeViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.navigateToDetailsView(forCategory: currentSnapshot.sectionIdentifiers[indexPath.section], itemAt: indexPath.item)
    }
}
