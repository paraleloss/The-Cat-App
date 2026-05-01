//
//  BreedSelectionViewController.swift
//  The-Cat-App
//
//  Created by Saúl Pérez on 30/04/26.
//

import UIKit

class BreedSelectionViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cat Gallery"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let breedLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecciona una raza:"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let breedPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let limitLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of Images (1-100):"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let limitTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter limit (1-100)"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search Cats", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        return ai
    }()
    
    private var breeds: [CatBreed] = []
    private var selectedBreed: CatBreed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        setupActions()
        fetchBreeds()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(breedLabel)
        view.addSubview(breedPicker)
        view.addSubview(limitLabel)
        view.addSubview(limitTextField)
        view.addSubview(searchButton)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            breedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            breedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            breedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            breedPicker.topAnchor.constraint(equalTo: breedLabel.bottomAnchor, constant: 8),
            breedPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            breedPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            breedPicker.heightAnchor.constraint(equalToConstant: 200),
            
            limitLabel.topAnchor.constraint(equalTo: breedPicker.bottomAnchor, constant: 20),
            limitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            limitLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            limitTextField.topAnchor.constraint(equalTo: limitLabel.bottomAnchor, constant: 8),
            limitTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            limitTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            limitTextField.heightAnchor.constraint(equalToConstant: 44),
            
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupDelegates() {
        breedPicker.dataSource = self
        breedPicker.delegate = self
        limitTextField.delegate = self
    }
    
    private func setupActions() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func fetchBreeds() {
        activityIndicator.startAnimating()
        
        CatAPIService.shared.fetchBreeds { [weak self] breeds, error in
            self?.activityIndicator.stopAnimating()
            
            if let error = error {
                self?.showError(message: "Failed to load breeds: \(error.localizedDescription)")
                return
            }
            
            if let breeds = breeds {
                self?.breeds = breeds
                self?.breedPicker.reloadAllComponents()
                if !breeds.isEmpty {
                    self?.selectedBreed = breeds[0]
                }
            }
        }
    }
    
    @objc private func searchButtonTapped() {
        guard let selectedBreed = selectedBreed else {
            showError(message: "Please select a breed")
            return
        }
        
        guard let limitText = limitTextField.text, let limit = Int(limitText), limit >= 1, limit <= 100 else {
            showError(message: "Please enter a valid limit between 1 and 100")
            return
        }
        
        let galleryVC = ImageGalleryViewController(breed: selectedBreed, limit: limit)
        navigationController?.pushViewController(galleryVC, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension BreedSelectionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedBreed = breeds[row]
    }
}

extension BreedSelectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
