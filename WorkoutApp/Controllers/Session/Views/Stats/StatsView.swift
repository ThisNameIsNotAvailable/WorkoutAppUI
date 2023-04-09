//
//  StatsView.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

final class StatsView: BaseInfoView {
    
    private let statsCell = StatsCellView()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    override func addViews() {
        super.addViews()
        
        addView(stackView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    override func configure() {
        super.configure()
    }
    
    func configure(with items: [StatsItem]) {
        items.forEach { el in
            let itemView = StatsCellView()
            itemView.configure(with: el)
            stackView.addArrangedSubview(itemView)
        }
    }
}
