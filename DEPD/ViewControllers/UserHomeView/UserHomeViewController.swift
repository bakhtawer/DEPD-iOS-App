//
//  UserHomeViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/05/2024.
//

import UIKit

class UserHomeViewController: MVVMViewController<UserHomeViewModel> {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    var dataSource: UICollectionViewDiffableDataSource<PoitsSection, InstituteModel>?
    
    @IBOutlet weak var viewBottom: BottomView!
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewBottom.setLanguage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        viewModel.delegate = self
        viewModel.fetchInstitutes()
        
        setUpCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setUpCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .appLight
        
        collectionView.register(UINib(nibName: "InstituteCell", bundle: nil), forCellWithReuseIdentifier: InstituteCell.reuseIdentifier)
        
        createDataSource()
    }
    
}

extension UserHomeViewController: UserHomeVM {
    func showLoader() {
        DispatchQueue.main.async {[weak self] in
            self?.showLoadingIndicator()
        }
    }
    func hideLoader() {
        DispatchQueue.main.async {[weak self] in
            self?.hideLoadingIndicator()
        }
    }
    func fetchedInstitutes() {
        DispatchQueue.main.async {[weak self] in
            self?.reloadData()
        }
    }
}

extension UserHomeViewController {
    
    func setupNavigation() {
        self.setLogo()
        self.setNavBarColor(.appBlue)
    }
}

extension UserHomeViewController { // Create Compositional Layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createInstituteSection()
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .leastNormalMagnitude
        config.scrollDirection = .vertical
        layout.configuration = config
        return layout
    }
}
extension UserHomeViewController {
    func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<PoitsSection,
                                                        InstituteModel>(collectionView: self.collectionView) { _, indexPath, app in
            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: InstituteCell.reuseIdentifier, for: indexPath) as? InstituteCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: app)
//            cell.delegate = self
            return cell
        }
    }
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<PoitsSection, InstituteModel>()
        snapshot.appendSections([.all])
        snapshot.appendItems(viewModel.dataProds, toSection: .all)
        dataSource?.apply(snapshot, animatingDifferences: false)
        
        constraintHeight.constant = collectionView.contentSize.height + 30
        collectionView.layoutIfNeeded()
    }
}
extension UserHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.selectedProduct(product: dataProds[indexPath.row])
    }
}

extension UserHomeViewController { // Make Search Section
    func createInstituteSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .absolute(147)
            )
          )
          item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(147))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                      
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}
