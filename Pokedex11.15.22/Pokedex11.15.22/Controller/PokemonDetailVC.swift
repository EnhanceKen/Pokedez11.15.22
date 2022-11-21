//
//  PokemonDetailVC.swift
//  Pokedex11.15.22
//
//  Created by Consultant on 11/18/22.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    lazy var pokeNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.text = "pika"
        label.textAlignment = .center
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        return label
        
        
    }()
    
    lazy var pokeImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "chlorophyll" )
        imageView.layer.cornerRadius = 293
        return imageView
    }()
        //    let poke: Sprite
    init(){
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.pokeImageView)

        
//                guard let imageData = ImageCache.shared.get(id: sprites.frontDefault) else { return }
//                self.pokeImageView.image = UIImage(data: Data imageData)
        
        
        
        
        
        
        
        self.view.backgroundColor = .systemYellow
        self.view.addSubview(self.pokeNameLabel)
        self.view.addSubview(self.pokeImageView)
        
        
        self.pokeImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.pokeImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.pokeImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.pokeImageView.widthAnchor.constraint(equalToConstant: 325).isActive = true
        
        
        
        self.pokeNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        self.pokeNameLabel.topAnchor.constraint(equalTo: self.pokeImageView.bottomAnchor, constant: 8).isActive = true
        self.pokeNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        self.pokeNameLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        
    }
    
    
    
}
    
    

    
