//
//  ImageInteractor.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa

protocol ImageRouting: ViewableRouting {
  func attachImageDetailRIB()
  func detachImageDetailRIB()
}

protocol ImagePresentable: Presentable {
  var listener: ImagePresentableListener? { get set }
  var detailButtonClickObservable: Observable<Void> { get }
}

protocol ImageListener: class {
}

final class ImageInteractor:
  PresentableInteractor<ImagePresentable>,
  ImageInteractable,
  ImagePresentableListener
{
  // MARK: - ImageInteractable
  
  weak var router: ImageRouting?
  
  weak var listener: ImageListener?
  
  // MARK: - ImageDetailPresentableListener
  
  var viewModel: Observable<UIImage> {
    viewModelRelay.asObservable()
  }
  
  private let viewModelRelay: BehaviorRelay<UIImage>
  
  // MARK: - Con(De)structor
  
  init(image: UIImage, presenter: ImagePresentable) {
    viewModelRelay = .init(value: image)
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  deinit {
    print("deinit: \(type(of: self))")
  }
  
  // MARK: - Overridden: PresentableInteractor
  
  override func didBecomeActive() {
    super.didBecomeActive()
    
    bindPresenter()
  }
  
  // MARK: - Binding
  
  private func bindPresenter() {
    presenter.detailButtonClickObservable
      .bind { [weak self] in
        self?.router?.attachImageDetailRIB()
    }
    .disposeOnDeactivate(interactor: self)
  }
}

// MARK: - ImageDetailListener
extension ImageInteractor {
  func detachImageDetailRIB() {
    router?.detachImageDetailRIB()
  }
}
