//
//  UIView++.swift
//  Pokedex11.15.22
//
//  Created by Consultant on 11/18/22.
//

import UIKit

extension UIView {
    
    func bindToSuperView(inset: CGFloat = 8) {
        guard let superSafeArea = self.superview?.safeAreaLayoutGuide else {
            fatalError("You forgot to add the view to the view hieararchy. Check again.")
        }
        
        self.topAnchor.constraint(equalTo: superSafeArea.topAnchor, constant: inset).isActive = true
        self.leadingAnchor.constraint(equalTo: superSafeArea.leadingAnchor, constant: inset).isActive = true
        self.trailingAnchor.constraint(equalTo: superSafeArea.trailingAnchor, constant: -inset).isActive = true
        self.bottomAnchor.constraint(equalTo: superSafeArea.bottomAnchor, constant: -inset).isActive = true
        
    }
    
    
    static func createBufferView() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return view
    }
    
}
