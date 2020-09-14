//
//  ImageViewController.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import SnapKit

protocol ImagePresentableListener: class {
  var viewModel: Observable<UIImage> { get }
}

final class ImageViewController:
  UIViewController,
  ImagePresentable,
  ImageViewControllable
{
  // MARK: - ImagePresentable
  
  weak var listener: ImagePresentableListener?
  
  lazy var detailButtonClickObservable: Observable<Void> = detailButton.rx.tap.asObservable()
  
  // MARK: - Properties
  
  private let disposeBag: DisposeBag = .init()
  
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
  
  init() {
    super.init(nibName: nil, bundle: nil)
    modalPresentationStyle = .fullScreen
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("deinit: \(type(of: self))")
  }
  
  // MARK: - Overridden: UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    bind(to: listener)
  }
}

// MARK: - SetupUI
private extension ImageViewController {
  func setupUI() {
    view.backgroundColor = .white
    
    view.addSubview(imageView)
    view.addSubview(detailButton)
    
    layout()
  }
  
  func layout() {
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

// MARK: - Binding
private extension ImageViewController {
  func bind(to listener: ImagePresentableListener?) {
    listener?.viewModel
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] image in
        self?.imageView.image = image
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - ImageViewControllable
extension ImageViewController {
  func present(_ viewController: ViewControllable, animated: Bool) {
    present(viewController.uiviewController, animated: animated)
  }
  
  func dismiss(_ viewController: ViewControllable, animated: Bool) {
    guard !viewController.uiviewController.isBeingDismissed else { return }
    
    viewController.uiviewController.dismiss(animated: animated)
  }
}
