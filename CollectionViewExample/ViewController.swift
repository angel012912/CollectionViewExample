//
//  ViewController.swift
//  CollectionViewExample
//
//  Created by Angel Garcia on 27/06/23.
//

import UIKit

struct Device: Hashable {
    let title: String
    let imageName: String
    let id: UUID = UUID()
}

let house = [
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Appple TV", imageName: "appletv"),
]

let office = [
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Appple TV", imageName: "appletv")
]

class ViewController: UIViewController {
    // Instancia de la vista collection view en una propiedad
    private let mainCollectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // Version mas moderna para definir el datasource al collection view
    lazy var dataSource: UICollectionViewDiffableDataSource<Int, Device> = {
        let deviceCell = UICollectionView.CellRegistration<UICollectionViewListCell, Device> { cell, indexPath, model in
            var listContentConfiguration = UIListContentConfiguration.cell()
            listContentConfiguration.text = model.title
            listContentConfiguration.image = UIImage(systemName: model.imageName)
            cell.contentConfiguration = listContentConfiguration
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Int, Device>(collectionView: mainCollectionView) { collectionView, indexPath, model in
            return collectionView.dequeueConfiguredReusableCell(using: deviceCell, for: indexPath, item: model)
        }
        
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.backgroundColor = .green
//        mainCollectionView.dataSource = self
//        mainCollectionView.delegate = self
//        mainCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        view.addSubview(mainCollectionView)

        configureConstraints()
        
        // Forma moderna para añadir el data source al collection view
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(house, toSection: 0)
        dataSource.apply(snapshot)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            snapshot.appendItems(office, toSection: 1)
            self.dataSource.apply(snapshot)
        }
    }

    private func configureConstraints(){
        let mainCollectionViewConstraints = [
            mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        let constraints = [ mainCollectionViewConstraints ]
        constraints.forEach { constraint in
            NSLayoutConstraint.activate(constraint)
        }
    }
}
//
//extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return house.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
//
//        let model = house[indexPath.row]
//        cell.configure(model: model)
//        cell.backgroundColor = .red
//        return cell
//    }
//
//
//}
