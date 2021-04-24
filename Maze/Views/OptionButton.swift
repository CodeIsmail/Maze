//
//  OptionButton.swift
//  Maze
//
//  Created by Ismail on 16/04/2021.
//

import UIKit
import SnapKit

final class OptionButton: UIButton {

    //MARK: Properties
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.textColor  = Helper.Color.black
        label.font = UIFont(name: "ApercuPro-Bold", size: 14)
        
        label.textAlignment = .center
        return label
    }()
    private let optionAnswerLabel: UILabel = {
        let label = UILabel()
        label.textColor  = Helper.Color.black
        label.font = UIFont(name: "ApercuPro-Bold", size: 14)
        label.numberOfLines = 0
        return label
    }()
    private let optionBackgroundView: UIView = {
        let view  = UIView()
        view.backgroundColor = Helper.Color.backgroundGray
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    private let selectedOptionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: Override Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        optionBackgroundView.addSubview(optionLabel)
        addSubview(optionBackgroundView)
        addSubview(optionAnswerLabel)
        addSubview(selectedOptionImageView)
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Helper.Color.borderGray.cgColor
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        optionLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        optionBackgroundView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        optionAnswerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(optionBackgroundView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualTo(selectedOptionImageView.snp.leading)
        }
        selectedOptionImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            
        }
    }
    
    //MARK: Util functions
    func configure(with optionViewModel: OptionViewModel){
        optionLabel.text = optionViewModel.option
        optionAnswerLabel.text = optionViewModel.optionAnswer
    }
    
    func setOptionBackgroundViewColor(with color: UIColor){
        optionBackgroundView.backgroundColor = color
        layer.borderColor = color.cgColor
        optionLabel.textColor = .white
    }
    
    func setSelectedOptionVisibility(isVisible: Bool) {
        selectedOptionImageView.isHidden = isVisible
    }
    
    func setSelectedOptionImage(with image: UIImage) {
        selectedOptionImageView.image = image
    }
    
    func resetButtonState() {
        selectedOptionImageView.image = nil
        setSelectedOptionVisibility(isVisible: false)
        optionBackgroundView.backgroundColor =
            Helper.Color.backgroundGray
        layer.borderColor = Helper.Color.borderGray.cgColor
        optionLabel.textColor = Helper.Color.black
    }
}
