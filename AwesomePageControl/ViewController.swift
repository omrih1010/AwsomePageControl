//
//  ViewController.swift
//  AwesomePageControl
//
//  Created by omri on 05/06/2017.
//  Copyright © 2017 omri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {


    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        
        
        addAPCView()
        
   
    
    }
    
    override func viewWillAppear(_ animated: Bool) {

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
        
        switch indexPath.row {
        case 0:
            cell.backgroundColor = UIColor.orange
            break;
        case 1:
            cell.backgroundColor = UIColor.red
            break;
        case 2:
            cell.backgroundColor = UIColor.purple
            break;
        case 3:
            cell.backgroundColor = UIColor.blue
            break;
        case 4:
            cell.backgroundColor = UIColor.magenta
            break;
        default:
            cell.backgroundColor = UIColor.orange
        }
        
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        
        APCView.setCurrentIndex(index: visibleIndexPath.row)

    }
    
    func addAPCView() -> Void {
        
        let view1 = APCView(imageName: "1", backgroundColor: .white)
        let view2 = APCView(imageName: "2", backgroundColor: .white)
        let view3 = APCView(imageName: "3", backgroundColor: .white)
        let view4 = APCView(imageName: "4", backgroundColor: .white)
        let view5 = APCView(imageName: "5", backgroundColor: .white)
        
        APCView.addAPCView(views: [view1,view2,view3,view4,view5], view: self.view , y : self.view.frame.height - 100)
    
    }
    
}


