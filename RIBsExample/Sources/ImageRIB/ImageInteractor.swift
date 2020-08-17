//
//  ImageInteractor.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs
import RxCocoa

protocol ImageRouting: ViewableRouting {
  func attachImageDetailRIB()
  func detachImageDetailRIB()
}

protocol ImagePresentable: Presentable {
  var listener: ImagePresentableListener? { get set }
  var detailButtonClicked: ControlEvent<Void> { get }
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
  
  // MARK: - Con(De)structor
  
  override init(presenter: ImagePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - Overridden: PresentableInteractor
  
  override func didBecomeActive() {
    super.didBecomeActive()
    
    bindPresenter()
  }
  
  // MARK: - Binding
  
  private func bindPresenter() {
    presenter.detailButtonClicked
      .bind { [weak self] _ in
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
