//
//  InfoVC.swift
//  HouseParti
//
//  Created by Developer on 16/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class InfoVC:NewPostBaseVC, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate{


    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var loactionAction: UIButton!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var btnTab5: UIButton!
    @IBOutlet weak var btnTab4: UIButton!
    @IBOutlet weak var btnTab3: UIButton!
    @IBOutlet weak var btnTab2: UIButton!
    @IBOutlet weak var btnTab1: UIButton!
    
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var viewLeftConstraint: NSLayoutConstraint!
    private var pageController: UIPageViewController!
    private var arrVC:[UIViewController] = []
    private var currentPage: Int!
    var tab1VC:Tab1VC! = nil
    var tab2VC:Tab2VC! = nil
    var tab3VC:Tab3VC! = nil
    var tab4VC:Tab4VC! = nil
    var tab5VC:Tab5VC! = nil
    var getParamter :[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        self.btnNext.isEnabled = true
        self.btnNext.alpha = 1.0
        currentPage = 0
        createPageViewController()
        self.navigationItem.title = "Host a party"
         print(self.getParamter)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Custom Methods
    
    private func selectedButton(btn: UIButton) {
        
        btn.setTitleColor(UIColor.black, for: .normal)
        viewLeftConstraint.constant = btn.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    private func unSelectedButton(btn: UIButton) {
        btn.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
    }
    //Mark:UIbutton Action
    @IBAction func nextAction(_ sender: Any) {
        let cont = self.storyboard?.instantiateViewController(withIdentifier: "TimeVC")as! TimeVC
        self.navigationController?.pushViewController(cont, animated: true)
    }
    @IBAction func detailAction(_ sender: Any) {
        
    }
    @IBAction func timeAction(_ sender: Any) {
        
    }
    @IBAction func finishAction(_ sender: Any) {
        
    }
    //MARK: - IBaction Methods
    @IBAction func btnOptionClicked(_ btn: UIButton) {
        pageController.setViewControllers([arrVC[btn.tag-1]], direction: UIPageViewControllerNavigationDirection.reverse, animated: false, completion: {(Bool) -> Void in
        })
        
        resetTabBarForTag(tag: btn.tag-1)
    }
    //MARK: - CreatePagination
    
    private func createPageViewController() {
        
        pageController = UIPageViewController.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        
        pageController.view.backgroundColor = UIColor.clear
        pageController.delegate = self
        pageController.dataSource = self
        
        for svScroll in pageController.view.subviews as! [UIScrollView] {
            svScroll.delegate = self
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.pageController.view.frame = CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height-164)
        }
        
        let homeStoryboard = UIStoryboard(name: "Main", bundle: nil)
        tab1VC = homeStoryboard.instantiateViewController(withIdentifier: "Tab1VC") as! Tab1VC
        tab2VC = homeStoryboard.instantiateViewController(withIdentifier: "Tab2VC") as! Tab2VC
        tab3VC = homeStoryboard.instantiateViewController(withIdentifier: "Tab3VC") as! Tab3VC
        tab4VC = homeStoryboard.instantiateViewController(withIdentifier: "Tab4VC") as! Tab4VC
        tab5VC = homeStoryboard.instantiateViewController(withIdentifier: "Tab5VC") as! Tab5VC
        
        arrVC = [tab1VC, tab2VC, tab3VC,tab4VC,tab5VC]
        
        pageController.setViewControllers([tab1VC], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        self.addChildViewController(pageController)
        self.view.addSubview(pageController.view)
        pageController.didMove(toParentViewController: self)
    }
    
    
    private func indexofviewController(viewCOntroller: UIViewController) -> Int {
        if(arrVC .contains(viewCOntroller)) {
            return arrVC.index(of: viewCOntroller)!
        }
        
        return -1
    }
    
    //MARK: - Pagination Delegate Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index - 1
        }
        
        if(index < 0) {
            return nil
        }
        else {
            return arrVC[index]
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index + 1
        }
        if(index >= arrVC.count) {
            return nil
        }
        else {
            return arrVC[index]
        }
        
    }
    func pageViewController(_ pageViewController1: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if(completed) {
            currentPage = arrVC.index(of: (pageViewController1.viewControllers?.last)!)
            resetTabBarForTag(tag: currentPage)
        }
    }
    //MARK: - Set Top bar after selecting Option from Top Tabbar
    private func resetTabBarForTag(tag: Int) {
        
        var sender: UIButton!
        if(tag == 0) {
            sender = btnTab1
             btnTab1.setImage(#imageLiteral(resourceName: "info_icon"), for: .normal)
             btnTab2.setImage(#imageLiteral(resourceName: "music_note_icon"), for: .normal)
             btnTab3.setImage(#imageLiteral(resourceName: "ic_glass"), for: .normal)
             btnTab5.setImage(#imageLiteral(resourceName: "dollar_icon"), for: .normal)
        }
        else if(tag == 1) {
            sender = btnTab2
            btnTab2.setImage(#imageLiteral(resourceName: "ic_music"), for: .normal)
            btnTab1.setImage(#imageLiteral(resourceName: "ic_infoGray"), for: .normal)
            btnTab3.setImage(#imageLiteral(resourceName: "ic_glass"), for: .normal)
            btnTab5.setImage(#imageLiteral(resourceName: "dollar_icon"), for: .normal)

        }
        else if(tag == 2) {
            sender = btnTab3
            btnTab3.setImage(#imageLiteral(resourceName: "glass-folk-icon-black"), for: .normal)
            btnTab1.setImage(#imageLiteral(resourceName: "ic_infoGray"), for: .normal)
            btnTab2.setImage(#imageLiteral(resourceName: "music_note_icon"), for: .normal)
          
            btnTab5.setImage(#imageLiteral(resourceName: "dollar_icon"), for: .normal)

        }
       
        else if(tag == 4) {
            sender = btnTab5
            btnTab5.setImage(#imageLiteral(resourceName: "dollar_icon_black"), for: .normal)
            btnTab1.setImage(#imageLiteral(resourceName: "ic_infoGray"), for: .normal)
            btnTab2.setImage(#imageLiteral(resourceName: "music_note_icon"), for: .normal)
          
            btnTab3.setImage(#imageLiteral(resourceName: "ic_glass"), for: .normal)
        }
        currentPage = tag
        unSelectedButton(btn: btnTab1)
        unSelectedButton(btn: btnTab2)
        unSelectedButton(btn: btnTab3)
        unSelectedButton(btn: btnTab5)
        selectedButton(btn: sender)
    }
    //MARK: - UIScrollView Delegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let xFromCenter: CGFloat = self.view.frame.size.width-scrollView.contentOffset.x
        let xCoor: CGFloat = CGFloat(viewLine.frame.size.width) * CGFloat(currentPage)
        let xPosition: CGFloat = xCoor - xFromCenter/CGFloat(arrVC.count)
        viewLeftConstraint.constant = xPosition
    }
}

