//
//  ListTes.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit

class ListTest: BaseViewController {
    
    @IBOutlet weak var viewStackInstitutes: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
        
        testPopulateList()
    }
    
    func testPopulateList() {
        viewStackInstitutes.removeAllArrangedSubviews()
        
        let view = InstituteCollectionView()
//        view.delegate = self
//        view.labelTitle.text = cat.name
//        view.populate(prods: prods)
//                     For view ALl button
//        view.buttonnViewAll.addTapGestureRecognizer {[weak self] in
//            self?.goToViewAllWithCat(cat: cat)
//        }
        self.viewStackInstitutes.addArrangedSubview(view)
    }

}
extension ListTest {
    func setupNavigation() {
        self.setLogo()
        self.setNavBarColor(.appBlue)
    }
}

