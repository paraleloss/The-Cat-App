//
//  CatDetailViewController.swift
//  The-Cat-App
//
//  Created by Saúl Pérez on 30/04/26.
//

import UIKit

class CatDetailViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let breedCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let breedNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperamentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let originLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lifeSpanLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let catImage: CatImage
    private let breed: CatBreed?
    private var loadedImage: UIImage?
    
    init(catImage: CatImage, breed: CatBreed?, image: UIImage?) {
        self.catImage = catImage
        self.breed = breed
        self.loadedImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        displayCatInfo()
        loadImageIfNeeded()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray4
        title = "Más información"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(breedCardView)

        breedCardView.addSubview(breedNameLabel)
        breedCardView.addSubview(temperamentLabel)
        breedCardView.addSubview(originLabel)
        breedCardView.addSubview(lifeSpanLabel)
        breedCardView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),

            breedCardView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            breedCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            breedCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            breedCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            breedNameLabel.topAnchor.constraint(equalTo: breedCardView.topAnchor, constant: 12),
            breedNameLabel.leadingAnchor.constraint(equalTo: breedCardView.leadingAnchor, constant: 16),
            breedNameLabel.trailingAnchor.constraint(equalTo: breedCardView.trailingAnchor, constant: -16),
            
            temperamentLabel.topAnchor.constraint(equalTo: breedNameLabel.bottomAnchor, constant: 8),
            temperamentLabel.leadingAnchor.constraint(equalTo: breedCardView.leadingAnchor, constant: 16),
            temperamentLabel.trailingAnchor.constraint(equalTo: breedCardView.trailingAnchor, constant: -16),
            
            originLabel.topAnchor.constraint(equalTo: temperamentLabel.bottomAnchor, constant: 8),
            originLabel.leadingAnchor.constraint(equalTo: breedCardView.leadingAnchor, constant: 16),
            originLabel.trailingAnchor.constraint(equalTo: breedCardView.trailingAnchor, constant: -16),
            
            lifeSpanLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 8),
            lifeSpanLabel.leadingAnchor.constraint(equalTo: breedCardView.leadingAnchor, constant: 16),
            lifeSpanLabel.trailingAnchor.constraint(equalTo: breedCardView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: lifeSpanLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: breedCardView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: breedCardView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: breedCardView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
        navigationItem.rightBarButtonItem = shareButton
    }
    
    private func displayCatInfo() {
        
        if let breed = breed {
            breedNameLabel.text = "🐈 \(breed.name)"
            
            if let temperament = breed.temperament {
                temperamentLabel.text = "🎭 Temperamento: \(temperament)"
            }
            
            if let origin = breed.origin {
                originLabel.text = "🌍 Origen: \(origin)"
            }
            
            if let lifeSpan = breed.lifeSpan {
                lifeSpanLabel.text = "⏱️ Esperanza de vida: \(lifeSpan) años"
            }
            
            if let description = breed.description {
                descriptionLabel.text = "📝 Acerca de esta raza: \(description)"
            }
        } else {
            breedNameLabel.text = "No hay información de la raza"
            temperamentLabel.text = ""
            originLabel.text = ""
            lifeSpanLabel.text = ""
            descriptionLabel.text = "Aún no se encuentra información de este gato en la raza."
        }
    }
    
    private func loadImageIfNeeded() {
        if let image = loadedImage {
            imageView.image = image
        } else {
            activityIndicator.startAnimating()
            guard let url = URL(string: catImage.url) else {
                activityIndicator.stopAnimating()
                return
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    if let data = data, let image = UIImage(data: data) {
                        self?.imageView.image = image
                        self?.loadedImage = image
                    } else {
                        self?.imageView.image = UIImage(systemName: "photo.fill")
                        self?.imageView.tintColor = .gray
                    }
                }
            }.resume()
        }
    }

    @objc private func shareImage() {
        guard let image = imageView.image else {
            let alert = UIAlertController(title: "No Image", message: "Wait for the image to load first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let activityVC = UIActivityViewController(activityItems: [image, "Hey, mira este gato! 🐱"], applicationActivities: nil)
        present(activityVC, animated: true)
    }
}
