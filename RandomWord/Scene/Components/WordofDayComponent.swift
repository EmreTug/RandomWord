//
//  WordofDayComponent.swift
//  RandomWord
//
//  Created by Emre Tuğ on 24.02.2024.
//

import UIKit
class WordOfDayComponent: UIView {
    var word: WordOfDayModel? {
            didSet {
                updateView()
            }
        }
    var wordofDayButtonClosure: ((String) -> Void)?
    func updateView(){
        guard let word = word else { return }

        DispatchQueue.main.async { [weak self] in
           
            self?.wordofthedayWordLabel.text = word.word
            self?.descriptionLabel.text = word.definitions.first?.text
           
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
   

  
    private let wordofDayButton : GradientButton = {
       let button = GradientButton()
   
        button.addTarget(self, action: #selector(wordofDayButtonAction), for: .touchUpInside)
        return button
    }()
    @objc func wordofDayButtonAction (){
        if let closure = wordofDayButtonClosure{
            if let word = word{
                closure(word.word)
            }
           
        }
    }
    @objc func wordofDayButtonAction1 (){
        isHidden = true
    }
    private let wordofthedayTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let fontSize: CGFloat = 18.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.gray
        ]
        let attributedText = NSAttributedString(string:"Word of the day", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let wordofthedayWordLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let fontSize: CGFloat = 35.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string:"Natural", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let wordofthedayIcon : UIImageView = {
        let config = UIImage.SymbolConfiguration(
            pointSize: 25, weight: .thin, scale: .small)
        let imageView = UIImageView(image: UIImage(systemName: "info.circle",withConfiguration: config)?.withTintColor(.black, renderingMode: .alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    private let wordofthedayCloseIcon : UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
            pointSize: 25, weight: .medium, scale: .small)
        button.addTarget(self, action:  #selector(wordofDayButtonAction1), for: .touchUpInside)
        button.setBackgroundImage( UIImage(systemName: "xmark",withConfiguration: config)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
   
    private let wordofthedayLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let fontSize: CGFloat = 22.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string:"Word", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let descriptionLabel : UILabel =  {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .left
        let fontSize: CGFloat = 15.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.gray
        ]
        let attributedText = NSAttributedString(string:"", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
   
  
    
    private func setupView() {
        backgroundColor = .white
        addSubview(wordofDayButton)
        wordofDayButton.addSubview(wordofthedayTitleLabel)
        wordofDayButton.addSubview(wordofthedayWordLabel)
        wordofDayButton.addSubview(wordofthedayIcon)
        wordofDayButton.addSubview(wordofthedayCloseIcon)

        
        setupLayout()
    }
    func setupLayout(){
     
        
        wordofDayButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.center.equalToSuperview()
            make.height.equalTo(150)
        }
       
        wordofthedayTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        wordofthedayWordLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        wordofthedayIcon.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
        wordofthedayCloseIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
       
        
        
    }
    
}
