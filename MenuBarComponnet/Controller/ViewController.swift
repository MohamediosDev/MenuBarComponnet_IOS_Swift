//
//  ViewController.swift
//  MenuBarComponnet
//
//  Created by Mohamed on 12/29/20.
//

import UIKit

class ViewController: UIViewController {

    
    //MARK: Outlets
    @IBOutlet weak var countryTaBLE: UITableView!
    @IBOutlet weak var menuCollection: UICollectionView!
    
    
    
    //MARK: Properties
    let countryArray = [["1","3","5"],["2","4","6"],["2","3","5"]]
    var selectArray = [String]()
    var selectIndex = 0
    var selectIndexPath = IndexPath(item: 0, section: 0)
    var menuTitle = ["Odd","Even","Prime"]
    var indicatorView = UIView()
    var indicatorHight = 3
    
    //MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup
        selectArray = countryArray[selectIndex]
        countryTaBLE.delegate = self
        countryTaBLE.dataSource = self
        self.countryTaBLE.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        menuCollection.selectItem(at: selectIndexPath, animated: false, scrollPosition: .centeredVertically)
        
        
        //swipe left
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeAction))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        //swipe right
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeAction))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
         //add indictor view
        indicatorView.backgroundColor = .black
        indicatorView.frame = CGRect(x: menuCollection.bounds.minX - CGFloat(indicatorHight), y: menuCollection.bounds.maxY - CGFloat(indicatorHight), width: menuCollection.bounds.width / CGFloat(menuTitle.count), height: CGFloat(indicatorHight))
        menuCollection.addSubview(indicatorView)
        
        
    }
    
    
    
    //MARK: ClassMethods
    
    func refreshContent() {
        selectArray = countryArray[selectIndex]
        countryTaBLE.reloadData()
        
        UIView.animate(withDuration: 0.2) { [self] in
            
            let disX = (self.menuCollection.bounds.width / CGFloat(self.menuTitle.count)) * CGFloat(self.selectIndex)
            self.indicatorView.frame = CGRect(x:disX, y: self.menuCollection.bounds.maxY - CGFloat(self.indicatorHight), width: self.menuCollection.bounds.width / CGFloat(menuTitle.count), height: CGFloat(self.indicatorHight))
        }
    }
    
    @objc func SwipeAction(_ sender:UISwipeGestureRecognizer) {
        
        if sender.direction == .left {
            
            if selectIndex < menuTitle.count - 1{
                selectIndex += 1

            }
            
        }else {
            
            if selectIndex > 0 {
                
                selectIndex -= 1
                
            }
        }
        
        selectIndexPath = IndexPath(item: selectIndex, section: 0)
        menuCollection.selectItem(at: selectIndexPath, animated: true, scrollPosition: .centeredVertically)
        refreshContent()
    }
    
    
    
    
    


}
//MARK: TableView Extension
extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  selectArray[indexPath.row]
        return cell 
    }
}

//MARK: Collection Extension

extension ViewController:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.setUpCell(text: menuTitle[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / CGFloat(menuTitle.count), height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndex = indexPath.item
        refreshContent()
    }
    
    
   
    
    
    
    
    
    
    
    
    
    
    
}
