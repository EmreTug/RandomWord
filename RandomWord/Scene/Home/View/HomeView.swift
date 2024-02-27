
//
//  HomeView.swift
//  RandomWord
//
//  Created by Emre Tuğ on 23.02.2024.
//



import UIKit
import SnapKit

class HomeView: UIView {
    var words: [String:String]? {
        didSet {
            wordLabel.text = words?.first?.key
            definitionLabel.text  = words?.first?.value
            index = 0
        }
    }
    var isWordofDayActive : Bool? {
        didSet{
            if isWordofDayActive == true {
                detailButton.isEnabled = false
                nextButton.isEnabled = false
            }
        }
    }
    var wordofDayButtonClosure: ((String) -> Void)?

    var index : Int = 0 {
        didSet{
            countertitleLabel.text = "Word \(index + 1) of 10"
        }
    }
    var detailButtonClosure: (([String:String]) -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let wordofday : WordOfDayComponent = {
        let view = WordOfDayComponent()
        return view
    }()
  
    private let progressBar : UIProgressView = {
        let progressView = UIProgressView()
        progressView.trackTintColor = .progressBG
        return progressView
    }()
    private let countertitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let fontSize: CGFloat = 26.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string:"Word", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let wordLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let fontSize: CGFloat = 32.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string:"Word", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let definitionLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let fontSize: CGFloat = 16.0
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string:"Definition", attributes: attributes)
        label.attributedText = attributedText
        label.numberOfLines = .zero
        return label
    }()
    private let buttonStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    private let nextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .button
        button.addTarget(self, action: #selector(nextbuttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()

    func tabAnimation() {

       }
    @objc func nextbuttonAction(){
        

//        if index < 9 {
//            index += 1
//            if let dictionary = words{
//                let keys = Array(dictionary.keys)
//                let element = dictionary[keys[index]]
//                wordLabel.text = keys[index]
//                definitionLabel.text = element
//            }
//            
//        }
//        
//        
//        progressBar.setProgress(progressBar.progress + 1/9, animated: true)
    }
    private let detailButton : UIButton = {
        let button = UIButton()
        button.setTitle("Detail", for: .normal)
        button.backgroundColor = .button
        button.addTarget(self, action: #selector(detailbuttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    @objc func detailbuttonAction(){
        if let closure = detailButtonClosure{
            if let dictionary = words{
                let keys = Array(dictionary.keys)
                guard let element = dictionary[keys[index]] else {return}
                closure([keys[index]:element])
            }
          
        }
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(contentView)
        contentView.insertSubview(progressBar, at: 1)
        contentView.insertSubview(countertitleLabel, at: 1)
        contentView.insertSubview(wordLabel, at: 1)
        contentView.insertSubview(buttonStack, at: 1)
        buttonStack.addArrangedSubview(detailButton)
        buttonStack.addArrangedSubview(nextButton)
        contentView.insertSubview(definitionLabel, at: 1)
        contentView.insertSubview(wordofday, at: 3)
        
        setupLayout()
    }
    func setupLayout(){
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
            
        }
        progressBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(8)
        }
        countertitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(progressBar.snp.bottom).offset(40)
        }
        wordLabel.snp.makeConstraints { make in
            make.top.equalTo(countertitleLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        definitionLabel.snp.makeConstraints { make in
            make.top.equalTo(wordLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            
        }
        buttonStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(definitionLabel.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        wordofday.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-300)
        }
       
        
        
        
    }
    
}

#Preview{
    ViewController()
}

class GravityViewController: UIViewController {
    
    var dynamicAnimator: UIDynamicAnimator!
    var squareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a square view
        squareView = UIView()
        squareView.backgroundColor = .blue
        view.addSubview(squareView)
        
        // Set up SnapKit constraints for squareView
        squareView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        // Initialize UIDynamicAnimator
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        // Apply gravity behavior to squareView
        let gravityBehavior = UIGravityBehavior(items: [squareView])
        dynamicAnimator.addBehavior(gravityBehavior)
    }
}

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var redSquare: WordOfDayComponent!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Kırmızı kare görünümünü oluştur
        redSquare = WordOfDayComponent(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        view.addSubview(redSquare)
        
        // UIDynamicAnimator oluştur
        animator = UIDynamicAnimator(referenceView: view)
        
        // Yerçekimi davranışını oluştur ve kırmızı kareyi ekleyin
        let gravityBehavior = UIGravityBehavior(items: [redSquare])
        animator.addBehavior(gravityBehavior)
        
        // Çarpışma davranışını oluştur ve kırmızı kareyi ekleyin
        let collisionBehavior = UICollisionBehavior(items: [redSquare])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)
        
        // Esneklik davranışını oluştur ve kırmızı kareyi ekleyin
        let elasticityBehavior = UIDynamicItemBehavior(items: [redSquare])
        elasticityBehavior.elasticity = 0.4
        animator.addBehavior(elasticityBehavior)
    }
}
