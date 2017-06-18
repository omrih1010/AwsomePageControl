//
//  APCManager.swift
//  AwesomePageControl
//
//  Created by omri on 05/06/2017.
//  Copyright © 2017 omri. All rights reserved.
//

import UIKit

class APCView: UIView {
    
    var imageName = ""
    open static var sharedAPCView = APCView()
    var continerView = UIView()
    var mViews = [APCView]()
    var index = 0
    var isFirst = true
    
    convenience init() {
        
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(imageName : String , backgroundColor : UIColor) {
        
        super.init(frame: CGRect.zero)

        self.backgroundColor = backgroundColor
        self.imageName = imageName
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension APCView {

    public func  addAPCView(views : [APCView] , view : UIView , y : CGFloat) -> Void {
     
        let width = CGFloat(Int(60) *  Int(views.count))
      
        self.continerView = UIView(frame: CGRect(x: view.frame.size.width / 2 - width / 2, y: y, width: width, height: 100))
        self.mViews  = views
        
        for i in 0...self.mViews.count - 1{
            
            if i == 0 {
                
                self.mViews[i].frame = CGRect(x: 45, y: 45, width: 10, height: 10)
                
            }else{
                
                self.mViews[i].frame = CGRect(x: self.mViews[i - 1].frame.origin.x + 50, y: 45, width: 10, height: 10)

            }
            
            addImage(view: self.mViews[i], imageName: self.mViews[i].imageName)
            self.mViews[i].layer.cornerRadius = self.mViews[i].frame.size.width/2
            self.mViews[i].clipsToBounds = true
            continerView.addSubview(views[i])
        
        }
        
       view.addSubview(continerView)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            
            self.makeTransformScaleBig(view: self.mViews[self.index] , finishTransform: {})
            
        }
        
    }
    
    public func setCurrentIndex(index : Int) -> Void {
        
        if index != self.index && index != self.mViews.count && index >= 0{
            
            viewSelected(showView : self.mViews[index] , hideView : self.mViews[self.index])
            self.index  = index
        }

    }
    
    public func viewSelected(showView : APCView , hideView : APCView){
        
        
        self.makeTransformScaleSmall(view: hideView) {

            self.makeTransformScaleBig(view: showView, finishTransform: {
            
                
            })
            
        }
        
    }
    
    public static func addAPCView(views : [APCView] , view : UIView  , y : CGFloat){
        
        self.sharedAPCView.addAPCView(views: views, view: view  , y:  y)
    
    }
    
    public static func setCurrentIndex(index : Int){
        
        self.sharedAPCView.setCurrentIndex(index : index)
        
    }
    
    public func addImage(view : UIView , imageName : String){
        
        let image = UIImageView(image: UIImage(named: imageName))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.contentMode = .scaleToFill
        image.isHidden = true
        view.addSubview(image)
        
        view.addConstraints(addConstraint(view: view, image: image))
        view.layoutIfNeeded()
    }
    
    public func addConstraint(view : UIView , image : UIImageView) -> [NSLayoutConstraint]{
        
        
        let centerX  = NSLayoutConstraint(item: image,
                                          attribute: .centerX,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: view,
                                          attribute: .centerX,
                                          multiplier: 1.0,
                                          constant: 0.0)
        
        let centerY  = NSLayoutConstraint(item: image,
                                          attribute: .centerY,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: view,
                                          attribute: .centerY,
                                          multiplier: 1.0,
                                          constant: 0.0)
        
        let left  =    NSLayoutConstraint(item: image,
                                          attribute: .leftMargin,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: view,
                                          attribute: .leftMargin,
                                          multiplier: 1.0,
                                          constant: 2.0)
        
        let top  =    NSLayoutConstraint(item: image,
                                         attribute: .topMargin,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: view,
                                         attribute: .topMargin,
                                         multiplier: 1.0,
                                         constant: 2.0)

        
        return [centerX , centerY , left  , top ]
        
    }
    
    public func makeTransformScaleBig(view : UIView,  finishTransform:@escaping () -> Void){
        

        for image in view.subviews{
            
            if image is UIImageView{
                
                image.isHidden = false
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            view.transform = CGAffineTransform(scaleX: 7.0, y: 7.0)
            
        }) { (finish) in
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                view.transform = CGAffineTransform(scaleX: 6.0, y: 6.0)

                finishTransform()
                
            }) { (finish) in
                
                
            }
            
        }
        
    }
    
    public func makeTransformScaleSmall(view : UIView , finishTransform:@escaping () -> Void){
        
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            
            
        }) { (finish) in
            
            UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                view.transform = CGAffineTransform(scaleX: 1.0 , y: 1.0)
                
                finishTransform()
                
                for image in view.subviews{
                    
                    if image is UIImageView{
                        
                        image.isHidden = true
                    }
                    
                }
                
            }) { (finish) in
                
            }
            
        }
        
    }

}
