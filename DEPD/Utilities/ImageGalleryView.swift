//
//  ImageGalleryView.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 09/11/2024.
//

import UIKit
import Kingfisher

class ImageScrollView: UIView {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    var imageURLs: [String] = [] {
        didSet {
            configureStackView()
        }
    }
    var linksURLs: [String] = []
    var isLink: Bool = false
    
    var isEditable: Bool = false
    
    var viewController: UIViewController? // Reference to the parent view controller
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
        setupStackView()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.axis = .horizontal // For horizontal scrolling
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    // Configure stack view with image views from URLs
    private func configureStackView() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, urlString) in imageURLs.enumerated() {
            
            if isEditable {
                let container = UIView()
                container.backgroundColor = .appLightBG
                container.translatesAutoresizingMaskIntoConstraints = true
                container.heightAnchor.constraint(equalToConstant: 80).isActive = true
                container.widthAnchor.constraint(equalToConstant: 80).isActive = true
                
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
                if let url = URL(string: urlString) {
                    imageView.kf.setImage(with: url)
                }
                imageView.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                imageView.tag = index
                imageView.backgroundColor = .appLightBG
                imageView.addGestureRecognizer(tapGesture)
                imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
                container.addSubview(imageView)
                
                let deleteImageView = UIImageView(frame: CGRect(x: 54, y: 6, width: 20, height: 20))
                deleteImageView.isUserInteractionEnabled = true
                deleteImageView.image = UIImage(systemName: "trash.fill")
                let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(deleteImage(_:)))
                deleteImageView.tag = index
                deleteImageView.tintColor = .appOrange
                deleteImageView.addGestureRecognizer(tapGesture2)
                container.addSubview(deleteImageView)
                
                stackView.addArrangedSubview(container)
            } else {
                let imageView = createImageView()
                if let url = URL(string: urlString) {
                    imageView.kf.setImage(with: url)
                }
                imageView.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                imageView.tag = index
                imageView.backgroundColor = .appLightBG
                imageView.addGestureRecognizer(tapGesture)
                imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
                stackView.addArrangedSubview(imageView)
            }
        }
    }
    
    // Handle tap on image
    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        
        if isLink {
            guard let url = URL(string: linksURLs[index]) else {
                return //be safe
            }
            UIApplication.shared.open(url)
            return
        }
        
        // Present the image carousel on tap
        let carouselVC = ImageCarouselViewController()
        carouselVC.configure(with: imageURLs, startIndex: index)
        
        viewController?.present(carouselVC, animated: true, completion: nil)
    }
    
    // Closure to notify about changes
    var onDeleteToggle: ((Int) -> Void)?
    @objc private func deleteImage(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        onDeleteToggle?(index)
    }
    
    // Create and configure an image view
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }
}


class ImageCarouselViewController: UIViewController {
    
    private var imageURLs: [String] = []
    private var selectedIndex: Int = 0
    private let carouselView = ImageCarouselView()
    
    // Configure the view controller with image URLs and starting index
    func configure(with imageURLs: [String], startIndex: Int = 0) {
        self.imageURLs = imageURLs
        self.selectedIndex = startIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupCarouselView()
    }
    
    // Setup the carousel view inside the view controller
    private func setupCarouselView() {
        view.addSubview(carouselView)
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carouselView.topAnchor.constraint(equalTo: view.topAnchor),
            carouselView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            carouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        carouselView.configure(with: imageURLs, startIndex: selectedIndex)
        
        let button = UIButton(frame: CGRect(x: 20, y: 6, width: 44, height: 44))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.addTapGestureRecognizer {[weak self] in
            self?.dismiss(animated: true)
        }
        button.tintColor = .appLight
        
        view.addSubview(button)
    }
}

class ImageCarouselView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var imageURLs: [String] = []
    private var selectedIndex: Int = 0
    private var collectionView: UICollectionView!
    
    // Configure the carousel with image URLs and starting index
    func configure(with imageURLs: [String], startIndex: Int = 0) {
        self.imageURLs = imageURLs
        self.selectedIndex = startIndex
        setupCollectionView()
        collectionView.reloadData()
        
        // Scroll to the selected image
        let initialIndexPath = IndexPath(item: selectedIndex, section: 0)
        collectionView.scrollToItem(at: initialIndexPath, at: .centeredHorizontally, animated: false)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    // Setup collection view
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        collectionView.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.identifier)
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.identifier, for: indexPath) as! ImageCarouselCell
        let urlString = imageURLs[indexPath.item]
        cell.configure(with: urlString)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

// MARK: - ImageCarouselCell

private class ImageCarouselCell: UICollectionViewCell {
    
    static let identifier = "ImageCarouselCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with urlString: String) {
        
        if let url = URL(string: ensureImageExtension(urlString: urlString)) {
            imageView.kf.setImage(with: url)
        }
    }
    
    private func ensureImageExtension(urlString: String) -> String {
        // Define a list of common image extensions
        let imageExtensions = [".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff", ".webp", ".heic", ".heif"]
        
        // Trim any whitespace or newlines
        let trimmedURL = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check if the URL ends with any of the extensions (case insensitive)
        for ext in imageExtensions {
            if trimmedURL.lowercased().hasSuffix(ext) {
                return trimmedURL
            }
        }
        
        // If no valid image extension is found, append ".jpg"
        return "\(trimmedURL).jpg"
    }
}
