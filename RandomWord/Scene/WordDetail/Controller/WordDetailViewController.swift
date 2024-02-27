//
//  WordDetailController.swift
//  RandomWord
//
//  Created by Emre Tuğ on 24.02.2024.
//



import UIKit
import SnapKit

class WordDetailViewController : UIViewController{
   
    let manager = WordManager()
    var word : [String:String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        let wordDetailView = WordDetailView()
        if let word = word.first {
            self.manager.fetchDefinitions(word: word.key) { dict, error in
                wordDetailView.wordmodel = dict?.first

            }
        }
        
//        manager.fetchWordofDay { model, error in
//           
//            if let model = model{
//                self.manager.fetchPronunciations(word: model.word) { proModel, error in
//                    wordDetailView.proModel = proModel?.first
//                    wordDetailView.word = model
//                }
//            }
//            wordDetailView.word = model
//        }
       
        wordDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wordDetailView)
        
        wordDetailView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.edges.equalToSuperview()
            
        }
        
    }
}
#Preview{
    HomeViewController()
}
