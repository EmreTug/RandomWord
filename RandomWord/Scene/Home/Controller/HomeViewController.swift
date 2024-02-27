//
//  HomeViewController.swift
//  RandomWord
//
//  Created by Emre Tuğ on 22.02.2024.
//

import UIKit
import SnapKit




class HomeViewController : UIViewController{
    
    let manager = WordManager()
    var animator: UIDynamicAnimator!
    var wordofday: WordOfDayComponent!
    var tempview : UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        let homeView = HomeView()
        
        manager.fetchWord(size: 10) { data in
            
            homeView.words = data
        }
        homeView.isWordofDayActive = false
        
        
        
        homeView.detailButtonClosure =  {[weak self] word in
            let vc = WordDetailViewController()
            vc.word = word
            self?.present(vc, animated: true)
        }
        //        manager.fetchWordofDay { model, error in
        //
        //            if var model = model{
        //                self.manager.fetchPronunciations(word: model.word) { proModel, error in
        //                    homeView.proModel = proModel?.first
        //                }
        //            }
        //
        //        }
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeView)
        view.addSubview(tempview)
        wordofday = WordOfDayComponent(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0.1))
        
        tempview.addSubview(wordofday)
        homeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.edges.equalToSuperview()
            
        }
        tempview.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.centerY)
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        // Kırmızı kare görünümünü oluştur
        wordofday.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        // UIDynamicAnimator oluştur
        animator = UIDynamicAnimator(referenceView: tempview)
        
        // Yerçekimi davranışını oluştur ve kırmızı kareyi ekleyin
        let gravityBehavior = UIGravityBehavior(items: [wordofday])
        animator.addBehavior(gravityBehavior)
        
        // Çarpışma davranışını oluştur ve kırmızı kareyi ekleyin
        let collisionBehavior = UICollisionBehavior(items: [wordofday])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)
        
        // Esneklik davranışını oluştur ve kırmızı kareyi ekleyin
        let elasticityBehavior = UIDynamicItemBehavior(items: [wordofday])
        elasticityBehavior.elasticity = 0.4
        animator.addBehavior(elasticityBehavior)
    }
}
#Preview{
    HomeViewController()
}
