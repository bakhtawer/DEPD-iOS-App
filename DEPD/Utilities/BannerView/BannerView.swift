//
//  BannerView.swift
//  Points
//
//  Created by Shahzaib Iqbal Bhatti on 6/22/21.
//

import UIKit

struct BannerModel: Codable, Hashable {
    var idMain = UUID()
    
    init() {
        idMain = UUID()
    }
    static func == (lhs: BannerModel, rhs: BannerModel) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}

enum PoitsSection {
   case all
}
protocol PointsBanerProtocol: AnyObject {
    func selectedBanner(banner: BannerModel)
}
class BannerView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var dataDeals = [BannerModel]()
    
    weak var delegate: PointsBanerProtocol?
    
    var dataSource: UICollectionViewDiffableDataSource<PoitsSection, BannerModel>?
    
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
        print("deinit BannerView")
    }
    
    private func setUpView() {
        
        Bundle.main.loadNibNamed("BannerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        pageControl.numberOfPages = 0
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.appLight

        collectionView.register(UINib(nibName: "BannerCCell", bundle: nil), forCellWithReuseIdentifier: BannerCCell.reuseIdentifier)
        
        dataDeals = [BannerModel(), BannerModel(), BannerModel()]
        pageControl.numberOfPages = dataDeals.count
        
        createDataSource()
        reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    func populate(banners: [BannerModel]) {
        DispatchQueue.main.async {[weak self] in
            self?.dataDeals = banners
            self?.pageControl.numberOfPages = banners.count
            self?.reloadData()
        }
    }
}
extension BannerView { // Create Compositional Layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createCarsSection()
        }
 
        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
}
extension BannerView {
    func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<PoitsSection,
                                                        BannerModel>(collectionView: self.collectionView) { _, indexPath, app in
            
            return self.configure(BannerCCell.self, with: app, for: indexPath)
        }
    }
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<PoitsSection, BannerModel>()
        snapshot.appendSections([.all])
        snapshot.appendItems(dataDeals, toSection: .all)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension BannerView { // Configure Cells
    func configure<T: SelfDealsConfiguringCell>(_ cellType: T.Type, with app: BannerModel, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: app)
        return cell
    }
}
extension BannerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedBanner(banner: dataDeals[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }

}
extension BannerView { // Make Search Section
    func createCarsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                           leading: 0,
                                                           bottom: 0,
                                                           trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        layoutGroup.interItemSpacing = .flexible(1)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
//        let layoutSectionHeader = createSectionHeader()
//        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
}
protocol SelfDealsConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with app: BannerModel)
}
