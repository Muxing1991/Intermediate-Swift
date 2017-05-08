//
//  DeluxeButton.swift
//  DeluxeProject
//
//  Created by 杨威 on 2017/5/8.
//  Copyright © 2017年 MuXing. All rights reserved.
//

import UIKit

@IBDesignable
public class DeluxeButton: UIControl {
  
  //MARK: - Components
  fileprivate var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  fileprivate var label: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightHeavy)
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  fileprivate lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [self.imageView, self.label])
    stackView.axis = .vertical
    stackView.isUserInteractionEnabled = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  //MARK: - API 
  @IBInspectable
  var pressedBackgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  
  @IBInspectable
  var unpressedBackgroundColor: UIColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) {
    didSet {
      backgroundColor = unpressedBackgroundColor
    }
  }
  
  
  //MARK: - Config
  
  fileprivate func config() {
    backgroundColor = unpressedBackgroundColor
    label.backgroundColor = tintColor
    layer.borderColor = tintColor.cgColor
    layer.cornerRadius = 20
    clipsToBounds = true
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      stackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      stackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor)
      ])
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    config()
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    config()
  }
  
  public override func tintColorDidChange() {
    label.backgroundColor = tintColor
    layer.borderColor = tintColor.cgColor
  }
  

}

//MARK: - Interation
extension DeluxeButton {
  
  fileprivate func animatedLabel(isHidden: Bool) {
    let (duration, btnBackgroundColor, labelIsHidden) = {
      isHidden ? (0.05, self.pressedBackgroundColor, true) : (0.1, self.unpressedBackgroundColor, false)
    }()
    
    UIView.animate(withDuration: duration) { 
      self.backgroundColor = btnBackgroundColor
      self.label.isHidden = labelIsHidden
    }
  }
  
  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    animatedLabel(isHidden: true)
    //添加触觉反馈
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    feedbackGenerator.impactOccurred()  
  }
  
  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    animatedLabel(isHidden: false)
  }
  
  public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    animatedLabel(isHidden: false)
  }
}

//MARK: - API

public extension DeluxeButton {
  
  @IBInspectable
  var image: UIImage? {
    get {
      return imageView.image
    }
    set {
      imageView.image = newValue?.withRenderingMode(.alwaysTemplate)
    }
  }
  
  @IBInspectable
  var text: String? {
    get {
      return label.text
    }
    set {
      label.text = newValue
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      //border width 的变化 内容的也要跟着变化 否则会被遮挡 或者 出现gap
      layoutMargins = UIEdgeInsetsMake(newValue, newValue, newValue, newValue)
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  var imagePadding: CGFloat {
    get {
      return image?.alignmentRectInsets.top ?? 0
    }
    set {
      image = image?.withAlignmentRectInsets(UIEdgeInsetsMake(-newValue, -newValue, -newValue, -newValue))
    }
  }
  

  
  
}











