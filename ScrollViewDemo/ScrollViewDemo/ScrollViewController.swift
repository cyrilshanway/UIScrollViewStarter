//
//  ViewController.swift
//  ScrollViewController
//
//  Created by Joyce Echessa on 6/3/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController , UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView = UIImageView(image: UIImage(named: "image.png"))
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.contentSize = imageView.bounds.size
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        // http://www.cnblogs.com/GarveyCalvin/p/4165151.html
        // UIViewAutoresizing
        // FlexibleWidth : 自動調整view的寬度，保證左邊距離和右邊距離不變
        // FlexibleHeight: 自動調整view的高度，以保證上邊距離和下邊距離不變
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        
        // http://blog.sina.com.cn/s/blog_7b9d64af010190h7.html
        /*
        滚動視圖中，用户滚動時，滚動的是内容視圖，而contentOffset座標，指代的就是内容視圖的座標。
        
        contentOffset 的默認點为 CGPointZero
        值得注意的是：
        1.contentOffset 座標值，會隨著用戶滑動内容視圖，而改變。
        2.内容視圖的contentOffset為負數時，在滚動視圖中是看不到的。
        */
        scrollView.contentOffset = CGPoint(x: 1000, y: 450)
        
        scrollView.delegate = self
        /*
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 1.0
        */
        
        setZoomScale()
        
        setupGestureRecognizer()
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    func setZoomScale() {
        
        let imageViewSize  = imageView.bounds.size
        let scorllViewSize = scrollView.bounds.size
        let widthScale     = scorllViewSize.width  / imageViewSize.width
        let heightScale    = scorllViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        let imageViewSize  = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: "handleDropTap:")
    }
    
    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }else {
            
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
}

