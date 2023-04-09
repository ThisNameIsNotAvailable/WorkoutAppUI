//
//  SectionHeader.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

final class SectionHeaderView: UICollectionReusableView {
    
    static let identifier = "SectionHeaderView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.helveticaRegular(with: 13)
        label.textAlignment = .center
        label.textColor = Resources.Colors.inactive
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addView(titleLabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with title: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "EN")
        dateFormatter.dateFormat = "EEEE, MMMM dd"
        
        titleLabel.text = dateFormatter.string(from: title).uppercased()
    }
}
