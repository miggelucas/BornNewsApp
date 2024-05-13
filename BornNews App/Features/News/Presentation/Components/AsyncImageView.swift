//
//  AsyncImageView.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import UIKit

class ImageDataProvider {
    static func getImageData(from url: URL?) async -> Data? {
        guard let safeUrl = url else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: safeUrl))
            print("deu bom")
            return data
    
        } catch {
            print("Failed to download image")
            return nil
        }
    }
}

class AsyncImageView: UIView {

    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
        view.alpha = 0.7
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var contentMode: UIView.ContentMode {
        get { imageView.contentMode }
        set { imageView.contentMode = newValue }
    }
    
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    var imageTintColor: UIColor {
        get { imageView.tintColor }
        set { imageView.tintColor = newValue }
    }
    
    var placeholderImage: UIImage?
    
    convenience init(placeholderImage: UIImage) {
        self.init(frame: .zero)
        
        self.placeholderImage = placeholderImage
        self.imageView.image = placeholderImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadResizedImageToFit(from imageURL: URL?, shouldShowLoadingIndicator: Bool = false) {
//        layoutIfNeeded() // This makes sure that the view has already sized itself and has valid bounds before using its size to generate a new imageURL
//        let imageSize = bounds.size
//        let resizedImageURL = imageURL?.urlForResizedImage(imageSize)
//        loadImage(from: resizedImageURL, shouldShowLoadingIndicator: shouldShowLoadingIndicator)
    }
    
    func loadImage(from imageURL: URL?, shouldShowLoadingIndicator: Bool = false) {
//        guard shouldShowLoadingIndicator else {
//            imageView.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
//            return
//        }
//
//        toggleLoading(isLoading: true)
//        imageView.sd_setImage(with: imageURL, placeholderImage: placeholderImage) { [weak self] _, _, _, _ in
//            self?.toggleLoading(isLoading: false)
//        }
        
        Task {
            toggleLoading(isLoading: true)
            guard let data = await ImageDataProvider.getImageData(from: imageURL) else { return }
           
            imageView.image = UIImage(data: data)
            toggleLoading(isLoading: false)
            
        }
    }
    
    /// Cancels any in-progress image download and resets its image back to the `placeholderImage`.
    func clearImage() {
//        imageView.sd_cancelCurrentImageLoad()
        imageView.image = placeholderImage
    }

}

extension AsyncImageView {
    private func setup() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func toggleLoading(isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
            
            blurView.alpha = 0
            blurView.isHidden = false
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1
            }
        } else {
            loadingIndicator.stopAnimating()

            UIView.animate(withDuration: 0.4, animations: {
                self.blurView.alpha = 0
            }, completion: {
                _ in
                self.blurView.alpha = 0
                self.blurView.isHidden = false
            })
        }
    }
}
