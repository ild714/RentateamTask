//
//  PhotoTableViewController.swift
//  RentateamApp
//
//  Created by Ildar on 2/15/21.
//

import UIKit
import CoreData

class PhotoTableViewController: UIViewController {
    
    var safeArea: UILayoutGuide!
    var presenter: PhotoViewPresenterProtocol!
    private let cellIdentifier = String(describing: PhotoTableViewCell.self)
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
//        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    var errorPhoto = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        safeArea = view.layoutMarginsGuide
        
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDelegate
extension PhotoTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if errorPhoto {
            guard let photo = presenter.photosCoreData?[indexPath.row] else { return }
            presenter.tapOnThePhotoCore(photo: photo)
        } else {
            guard let photo = presenter.photos?[indexPath.row] else { return }
            presenter.tapOnThePhoto(photo: photo)
        }
    }
}

// MARK: - UITableViewDelegate
extension PhotoTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if errorPhoto {
            return presenter.photosCoreData?.count ?? 0
        } else {
            return presenter.photos?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        
        if errorPhoto {
            let photo = presenter.photosCoreData?[indexPath.row]
            cell.configureCore(text: photo?.title ?? "No title", data: photo?.data ?? Data())
            
            return cell
        } else {
            let photo = presenter.photos?[indexPath.row]
            
            cell.configure(text: photo?.title ?? "No title", url: photo?.url ?? "No url")
            return cell
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.tableView.deselectSelectedRow(animated: true)
    }
}

// MARK: - ImageViewProtocol
extension PhotoTableViewController: PhotoViewProtocol {
    func succes() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        errorPhoto = true
        if let photos = presenter.fetchData() {
            presenter.setPhotos(photos: photos)
            tableView.reloadData()
        }
        
        
        print(error.localizedDescription)
    }
}

// MARK: - Extension UITableView
extension UITableView {

    func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }

}
