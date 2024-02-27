//
//  WordDetailView.swift
//  RandomWord
//
//  Created by Emre Tuğ on 23.02.2024.
//



import UIKit
import SnapKit
import AVFAudio



class WordDetailView: UIView {
    var wordmodel: DictionaryModel? {
            didSet {
                updateView()
            }
        }
    func updateView(){
        guard let wordmodel = wordmodel else { return }

        DispatchQueue.main.async { [weak self] in
            self?.notetitleLabel.isHidden = true
            self?.wordofthedayLabel.text = wordmodel.word
            self?.descriptionLabel.text = wordmodel.meanings?.first?.definitions.first?.definition
            self?.pronunciationText.text = wordmodel.phonetic
            self?.partofSpeechText.text = wordmodel.meanings?.first?.partOfSpeech
            self?.definitionsLabel.text = wordmodel.meanings?.map({ mean in
                """
                \(mean.partOfSpeech)
                
                \(mean.definitions.first?.definition ?? "")
                     
                
                """
               
                  
            }).joined()
            self?.examplesLabel.text = wordmodel.meanings?.first?.definitions.map({ definition in
                if  definition.example == nil {
                  ""
                }
                else{
                  """
                  \(definition.example ?? "")
                  
                  
                  """
                }
                   
            }).joined()
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
   
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    private let wordofthedayLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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
    private let stackView : UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal // Yatay yönde yerleştirme
        stackView.alignment = .fill // Yatayda merkez hizalama
        stackView.distribution = .fillEqually // Elemanları eşit genişlikte yerleştirme
        stackView.spacing = 15 // Elemanlar arasında 2 px boşluk bırakma
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
  
    private let pronunciationArea : UIStackView = {
        let stackview = UIStackView()
        stackview.layer.borderColor = UIColor.black.cgColor
        stackview.layer.cornerRadius = 8
        stackview.layer.borderWidth = 0.6
        stackview.layer.borderColor = UIColor.gray.cgColor
        stackview.axis = .vertical // Yatay yönde yerleştirme
        stackview.alignment = .leading // Yatayda merkez hizalama
        stackview.distribution = .fillEqually // Elemanları eşit genişlikte yerleştirme
        stackview.spacing = 2 // Elemanlar arasında 2 px boşluk bırakma
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    private let pronunciationIcon : UIImageView = {
        let config = UIImage.SymbolConfiguration(
            pointSize: 16, weight: .thin, scale: .small)
        let imageView = UIImageView(image: UIImage(systemName: "speaker.wave.2",withConfiguration: config)?.withTintColor(.black, renderingMode: .alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let pronunciationLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let fontSize: CGFloat = 18.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string:"Pronunciation", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let pronunciationText : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
    private let partofSpeechArea : UIStackView = {
        let stackview = UIStackView()
        stackview.layer.borderColor = UIColor.black.cgColor
        stackview.layer.cornerRadius = 8
        stackview.layer.borderWidth = 0.6
        stackview.layer.borderColor = UIColor.gray.cgColor
        stackview.axis = .vertical // Yatay yönde yerleştirme
        stackview.alignment = .leading // Yatayda merkez hizalama
        stackview.distribution = .fillEqually // Elemanları eşit genişlikte yerleştirme
        stackview.spacing = 2 // Elemanlar arasında 2 px boşluk bırakma
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    private let partofSpeechIcon : UIImageView = {
        let config = UIImage.SymbolConfiguration(
            pointSize: 16, weight: .thin, scale: .small)
        let imageView = UIImageView(image: UIImage(systemName: "book",withConfiguration: config)?.withTintColor(.black, renderingMode: .alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    private let partofSpeechLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let fontSize: CGFloat = 18.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string:"Part of Speech", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let partofSpeechText : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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

    private let notetitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let fontSize: CGFloat = 22.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string:"Note", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let noteLabel : UILabel =  {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .left
        let fontSize: CGFloat = 15.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.gray
        ]
        let attributedText = NSAttributedString(string: "", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let definitionstitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let fontSize: CGFloat = 22.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string:"Definition", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let definitionsLabel : UILabel =  {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .left
        let fontSize: CGFloat = 15.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.gray
        ]
        let attributedText = NSAttributedString(string: "", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let examplestitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let fontSize: CGFloat = 22.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string:"Examples", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let examplesLabel : UILabel =  {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .left
        let fontSize: CGFloat = 15.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.gray
        ]
        let attributedText = NSAttributedString(string: "", attributes: attributes)
        label.attributedText = attributedText
        return label
    }()
    private let playbutton : UIButton = {
        let playImage = UIImage(systemName: "play.fill")
        let button = UIButton(type: .system)
        button.setImage(playImage?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(playbuttonaction), for: .touchUpInside)
        return button
    }()
    @objc func  playbuttonaction(){
        if let urlString = wordmodel?.phonetics?.first?.audio{
            if let url = URL(string:urlString){
                downloadFileFromURL(url:url)

            }
        }
        
    }
    func downloadFileFromURL(url: URL) {
        let downloadTask = URLSession.shared.downloadTask(with: url) { [weak self] (URL, response, error) in
            guard let url = URL, error == nil else {
                print("Download failed: \(error!)")
                return
            }
            self?.playTheSound(url: url)
        }
        downloadTask.resume()
    }
    var player: AVAudioPlayer!

    func playTheSound(url: URL) {

        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
      }
    private func setupView() {
        addSubview(scrollView)
        //        self.title = "Daily 10 Words"
        //        navigationItem.largeTitleDisplayMode = .automatic
        backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.addSubview(contentView)
        contentView.addSubview(wordofthedayLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(pronunciationArea)
        pronunciationArea.addArrangedSubview(pronunciationIcon)
        pronunciationArea.addArrangedSubview(pronunciationLabel)
        pronunciationArea.addArrangedSubview(pronunciationText)
        pronunciationArea.addSubview(playbutton)
        stackView.addArrangedSubview(partofSpeechArea)
        partofSpeechArea.addArrangedSubview(partofSpeechIcon)
        partofSpeechArea.addArrangedSubview(partofSpeechLabel)
        partofSpeechArea.addArrangedSubview(partofSpeechText)
        contentView.addSubview(notetitleLabel)
        contentView.addSubview(noteLabel)
        contentView.addSubview(definitionstitleLabel)
        contentView.addSubview(definitionsLabel)
        contentView.addSubview(examplestitleLabel)
        contentView.addSubview(examplesLabel)
        
        setupLayout()
    }
    func setupLayout(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(safeAreaLayoutGuide)
        }
     
        wordofthedayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(wordofthedayLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
        }
        notetitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(stackView.snp.bottom).offset(30)
        }
        noteLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(notetitleLabel.snp.bottom).offset(30)
        }
        definitionstitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(noteLabel.snp.bottom).offset(30)
        }
        definitionsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(definitionstitleLabel.snp.bottom).offset(30)
        }
        examplestitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(definitionsLabel.snp.bottom).offset(30)
        }
        examplesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(examplestitleLabel.snp.bottom).offset(30)
            make.bottom.equalTo(contentView)


        }
        
        
        pronunciationArea.snp.makeConstraints { make in
            make.height.equalTo(100)

        }
        partofSpeechArea.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        pronunciationIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(25)
        }
        partofSpeechIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(25)
        }
        playbutton.snp.makeConstraints { make in
            make.trailing.equalTo(pronunciationArea.snp.trailing).offset(-10)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(25)
        }
       
       
     
        
        
    }
    
}

#Preview{
    WordDetailViewController()
}



