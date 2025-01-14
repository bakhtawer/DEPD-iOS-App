//
//  MyApplicationsViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 29/12/2024.
//

import UIKit


class MyApplicationsViewController: BaseViewController  {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    var data = [MyApplicationsModel]()
    var dataSource: UICollectionViewDiffableDataSource<PoitsSection, MyApplicationsModel>?
    
    @IBOutlet weak var viewBottom: BottomView!
    
    @IBOutlet weak var labelNoRecord: UILabel!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewBottom.setLanguage()
        
        setView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        setUpCollectionView()
        
        self.showLoadingIndicator(withDimView: true)
        USM.shared.getApplications {[weak self]  data in
            self?.data = data ?? []
            DispatchQueue.main.async {[weak self] in
                self?.hideLoader()
                self?.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setView()
        
        collectionView.setNeedsDisplay()
        collectionView.reloadData()
    }
    
    private func setView() {}
    
    private func setUpCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .appBG
        
        collectionView.register(UINib(nibName: "MyApplicationsCell", bundle: nil), forCellWithReuseIdentifier: MyApplicationsCell.reuseIdentifier)
        
        // Update the semantic content attribute based on the selected language
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            collectionView.semanticContentAttribute = .forceRightToLeft
        } else {
            collectionView.semanticContentAttribute = .forceLeftToRight
        }
        
        createDataSource()
    }
}

extension MyApplicationsViewController {
    func setupNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.setTitle("my_applications".localized())
        self.setNavBarColor(.appBG)
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension MyApplicationsViewController: JobSeekerVM {
    func fetchedJobs() {
        DispatchQueue.main.async {[weak self] in
            self?.reloadData()
        }
    }
    
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
}

extension MyApplicationsViewController { // Create Compositional Layout
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
extension MyApplicationsViewController { // Make Search Section
    func createInstituteSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .absolute(127)
            )
          )
          item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(127))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                      
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}

extension MyApplicationsViewController {
    func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<PoitsSection,
                                                        MyApplicationsModel>(collectionView: self.collectionView) { _, indexPath, app in
                                                            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: MyApplicationsCell.reuseIdentifier, for: indexPath) as? MyApplicationsCell
                                                            else {
                                                                return UICollectionViewCell()
                                                            }
                cell.configure(with: app)
            return cell
        }
    }
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<PoitsSection, MyApplicationsModel>()
        snapshot.appendSections([.all])
        snapshot.appendItems(data, toSection: .all)
        dataSource?.apply(snapshot, animatingDifferences: false)
        labelNoRecord.isHidden = !data.isEmpty
        constraintHeight.constant = collectionView.contentSize.height + 30
        collectionView.layoutIfNeeded()
    }
}

extension MyApplicationsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}
