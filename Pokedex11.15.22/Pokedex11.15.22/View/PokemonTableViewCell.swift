//
//  PokemonTableViewCell.swift
//  Pokedex11.15.22
//
//  Created by Consultant on 11/18/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    lazy var pokeImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "chlorophyll" )
        imageView.layer.cornerRadius = 93
        return imageView
    }()
    
    lazy var pokeNamelabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints =  false
        label.backgroundColor = .systemRed
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 38).isActive = true
//        label.setTextAlignment:UITextAlignmentCenter]
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.text = "Nike Hot Step Air Terra Drake"
   

        return label
    }()
    
    lazy var pokeTypeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
//        label.lineBreakMode = .byTruncatingTail
        label.backgroundColor = .systemTeal
        label.heightAnchor.constraint(equalToConstant: 28).isActive = true
        label.textColor = .black
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.text = "Nike Hot Step Air Terra Drake"
     

        return label
    }()
    
    
        override init(style: UITableViewCell.CellStyle,
                      reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: "PokemonCell")
            self.setUpUI()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setUpUI() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.pokeImageView)
        self.contentView.addSubview(self.pokeNamelabel)
        self.contentView.addSubview(self.pokeTypeLabel)
        
        
        //MARK: TEST
        
//        let bufferTop = UIView.createBufferView()
//        let bufferBottom = UIView.createBufferView()
        

        self.pokeImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.pokeImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        self.pokeImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        self.pokeImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.pokeImageView.widthAnchor.constraint(equalToConstant: 125).isActive = true

        self.pokeNamelabel.leadingAnchor.constraint(equalTo: self.pokeImageView.trailingAnchor, constant: 8).isActive = true
        self.pokeNamelabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        self.pokeNamelabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -25).isActive = true
        
        self.pokeTypeLabel.leadingAnchor.constraint(equalTo: self.pokeImageView.trailingAnchor, constant: 8).isActive = true
        self.pokeTypeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        self.pokeTypeLabel.topAnchor.constraint(equalTo: self.pokeNamelabel.bottomAnchor, constant: 8).isActive = true
    }
    
    
    
    
}
