//
//  ImageDetailViewController.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs
import RxCocoa
import RxSwift
import SnapKit

protocol ImageDetailPresentableListener: class {
}

final class ImageDetailViewController:
  UIViewController,
  ImageDetailPresentable,
  ImageDetailViewControllable
{
  // MARK: - ImageDetailPresentable
  
  weak var listener: ImageDetailPresentableListener?
  
  lazy var detachObservable: Observable<Void> = detachRelay.asObservable()
  
  // MARK: - Properties
  
  private let detachRelay: PublishRelay<Void> = .init()
  
  private let disposeBag: DisposeBag = .init()
  
  // MARK: - UIComponents
  
  private let closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Close detail image", for: .normal)
    return button
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  // MARK: - Con(De)structor
  
  init(image: UIImage) {
    super.init(nibName: nil, bundle: nil)

    self.imageView.image = image
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Overridden: UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    bindView()
  }
  
  // MARK: - Binding
  
  private func bindView() {
    closeButton.rx.tap
      .bind(to: detachRelay)
      .disposed(by: disposeBag)
  }
}

// MARK: - SetupUI
extension ImageDetailViewController {
  private func setupUI() {
    view.backgroundColor = .white
    presentationController?.delegate = self
    
    view.addSubview(closeButton)
    view.addSubview(imageView)
    
    layout()
  }
  
  private func layout() {
    closeButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(16)
      $0.centerX.equalToSuperview()
    }

    imageView.snp.makeConstraints {
      $0.top.equalTo(closeButton.snp.bottom).offset(16)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension ImageDetailViewController: UIAdaptivePresentationControllerDelegate {
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    detachRelay.accept(())
  }
}
