//
//  ProfileFilterView.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 9/30/21.
//

import UIKit

private let reuseIdentifier = "ProfileFilter"

protocol ProfileFilterViewDelegate: class {
    func filterView( view: ProfileFilterView, didSelect indexPath: IndexPath)
}

class ProfileFilterView: UIView {
    
    //MARK: Properties
    
    weak var delegate: ProfileFilterViewDelegate?
    
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionview.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        
        collectionview.register(ProfileFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        addSubview(collectionview)
        collectionview.topAnchor.constraint(equalTo: topAnchor) .isActive = true
        collectionview.leftAnchor.constraint(equalTo: leftAnchor) .isActive = true
        collectionview.rightAnchor.constraint(equalTo: rightAnchor) .isActive = true
        collectionview.heightAnchor.constraint(equalTo: heightAnchor) .isActive = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileFitlerOptions.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileFilterCell
        
        let option = ProfileFitlerOptions(rawValue: indexPath.row)
        cell.option = option
        return cell
    }
}

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3 , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ProfileFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterView(view: self, didSelect: indexPath)
    }
}
