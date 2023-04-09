//
//  ViewController.swift
//  WorkoutApp
//
//  Created by Alex on 04/04/2023.
//

import UIKit

struct TrainingData {
    struct Data {
        let title: String
        let subtitle: String
        let isDone: Bool
    }
    let date: Date
    let dataSource: [TrainingData.Data]
}

class OverviewController: BaseController {
    
    private let navBar = OverviewNavBar()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TrainingCellView.self, forCellWithReuseIdentifier: TrainingCellView.identifier)
        collection.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = false
        collection.backgroundColor = .clear
        return collection
    }()
    private var dataSource = [TrainingData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension OverviewController {
    override func addViews() {
        super.addViews()
        
        view.addView(navBar)
        view.addView(collectionView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configure() {
        super.configure()
        
        navigationController?.navigationBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        dataSource = [
            .init(date: Date(), dataSource: [
                .init(title: "Warm Up Cardio", subtitle: "Stair Climber • 10 minutes", isDone: true),
                .init(title: "High Intensity Cardio", subtitle: "Treadmill • 50 minutes", isDone: false)
            ]),
            .init(date: Date().addingTimeInterval(86400), dataSource: [
                .init(title: "Warm Up Cardio", subtitle: "Stair Climber • 10 minutes", isDone: false),
                .init(title: "Chest Workout", subtitle: "Bench Press • 3 sets • 10 reps", isDone: false),
                .init(title: "Tricep Workout", subtitle: "Overhead Extension • 5 sets • 8 reps", isDone: false)
            ]),
            .init(date: Date().addingTimeInterval(86400*2), dataSource: [
                .init(title: "Cardio Interval Workout", subtitle: "Treadmill • 60 minutes", isDone: false)
            ])
        ]
        collectionView.reloadData()
    }
}

extension OverviewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingCellView.identifier, for: indexPath) as? TrainingCellView else {
            return UICollectionViewCell()
        }
        let model = dataSource[indexPath.section].dataSource[indexPath.row]
        let roundedType: CellRoundedType
        if indexPath.row == 0 && indexPath.row == dataSource[indexPath.section].dataSource.count - 1 {
            roundedType = .all
        } else if indexPath.row == 0 {
            roundedType = .top
        } else if indexPath.row == dataSource[indexPath.section].dataSource.count - 1 {
            roundedType = .bottom
        } else {
            roundedType = .notRounded
        }
        
        cell.configure(with: model.title, and: model.subtitle, isDone: model.isDone, roundedType: roundedType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        let model = dataSource[indexPath.section]
        header.configure(with: model.date)
        return header
    }
}

extension OverviewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 32)
    }
}
