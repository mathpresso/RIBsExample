//
//  ImageViewController.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs
import RxCocoa
import SnapKit

protocol ImagePresentableListener: class {
}

final class ImageViewController:
  UIViewController,
  ImagePresentable,
  ImageViewControllable
{
  // MARK: - RootPresentable
  
  weak var listener: ImagePresentableListener?
  
  lazy var detailButtonClicked: ControlEvent<Void> = detailButton.rx.tap
  
  // MARK: - Properties
  
  private let image: UIImage
  
  // MARK: - UIComponents
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private var detailButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Show detail image", for: .normal)
    return button
  }()
  
  // MARK: - Con(De)structor
  
  init(image: UIImage) {
    self.image = image
    super.init(nibName: nil, bundle: nil)
    
    imageView.image = image
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Overridden: UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  // MARK: - ImageViewControllable
  
  func present(viewController: ViewControllable, animated: Bool) {
    present(viewController.uiviewController, animated: animated, completion: nil)
  }
}

// MARK: - SetupUI
extension ImageViewController {
  private func setupUI() {
    view.backgroundColor = .white
    
    view.addSubview(imageView)
    view.addSubview(detailButton)
    
    layout()
  }
  
  private func layout() {
    imageView.snp.makeConstraints {
      $0.centerX.equalTo(view.snp.centerX)
      $0.centerY.equalTo(view.snp.centerY)
      $0.width.equalToSuperview().multipliedBy(0.5)
      $0.height.equalTo(view.snp.width).multipliedBy(0.5)
    }

    detailButton.snp.makeConstraints {
      $0.centerX.equalTo(imageView.snp.centerX)
      $0.top.equalTo(imageView.snp.bottom).offset(8)
    }
  }
}
