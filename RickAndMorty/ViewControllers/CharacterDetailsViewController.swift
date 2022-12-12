//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Pavel Kuzovlev on 12.12.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView! {
        didSet {
            characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
        }
    }
    
    // MARK: - Public properties
    var character: Character!
    
    private var spinnerView = UIActivityIndicatorView()
        
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        showSpinner(in: view)
        title = character.name
        descriptionLabel.text = character.description
        NetworkManager.shared.fetchImage(from: character.image) { imageData in
            self.characterImageView.image = UIImage(data: imageData)
            self.spinnerView.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let episodesVC = navigationController.topViewController as! EpisodesViewController
        episodesVC.character = character
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .white
        spinnerView.startAnimating()
        spinnerView.center = characterImageView.center
        spinnerView.hidesWhenStopped = true
        
        view.addSubview(spinnerView)
    }
}
