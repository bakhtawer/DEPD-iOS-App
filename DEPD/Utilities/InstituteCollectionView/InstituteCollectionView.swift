//
//  InstituteCollectionView.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit

struct InstituteModel: Codable, Hashable {
    var idMain = UUID()
    
    init() {
        idMain = UUID()
    }
    static func == (lhs: InstituteModel, rhs: InstituteModel) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}

class InstituteCollectionView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonnViewAll: UIButton!
    
    var dataProds = [InstituteModel]()
    
//    weak var delegate: PointsProductCProtocol?
    
    var dataSource: UICollectionViewDiffableDataSource<PoitsSection, InstituteModel>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("deinit InstituteCollectionView")
    }
    
    private func setUpView() {
        
        Bundle.main.loadNibNamed("InstituteCollectionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.frame = bounds
        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .appLight
        
        collectionView.register(UINib(nibName: "InstituteCell", bundle: nil), forCellWithReuseIdentifier: InstituteCell.reuseIdentifier)
        
        dataProds = [InstituteModel(), InstituteModel(), InstituteModel(),InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel(),InstituteModel(), InstituteModel(), InstituteModel(),InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel()]
        
//        AppTheme.shared.setLabelTheme(labelTitle, .blacktext)
        
        createDataSource()
        reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func populate(prods: [InstituteModel]) {
        DispatchQueue.main.async {[weak self] in
            self?.dataProds = prods
            self?.reloadData()
        }
    }
}

extension InstituteCollectionView { // Create Compositional Layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createCarsSection()
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .leastNormalMagnitude
        config.scrollDirection = .vertical
        layout.configuration = config
        return layout
    }
}
extension InstituteCollectionView {
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
        snapshot.appendItems(dataProds, toSection: .all)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
extension InstituteCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.selectedProduct(product: dataProds[indexPath.row])
    }
}

extension InstituteCollectionView { // Make Search Section
    func createCarsSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .absolute(92)
            )
          )
          item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(110))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
                      
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
        
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .fractionalHeight(1))
//        
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0,
//                                                           leading: 20,
//                                                           bottom: 0,
//                                                           trailing: 0)
//        
//        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
//                                                     heightDimension: .estimated(220))
//        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
//                                                             subitems: [layoutItem])
//        layoutGroup.interItemSpacing = .flexible(0)
//        
//        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
//        layoutSection.orthogonalScrollingBehavior = .continuous
//        
//        
//        return layoutSection
    }
}
