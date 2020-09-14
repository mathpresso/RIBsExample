//
//  ImageDetailInteractor.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs
import RxCocoa
import RxSwift

protocol ImageDetailRouting: ViewableRouting {
}

protocol ImageDetailPresentable: Presentable {
  var listener: ImageDetailPresentableListener? { get set }
  
  var detachObservable: Observable<Void> { get }
}

protocol ImageDetailListener: class {
  func detachImageDetailRIB()
}

final class ImageDetailInteractor:
  PresentableInteractor<ImageDetailPresentable>,
  ImageDetailInteractable,
  ImageDetailPresentableListener
{
  // MARK: - ImageDetailInteractable
  
  weak var router: ImageDetailRouting?
  
  weak var listener: ImageDetailListener?
  
  // MARK: - ImageDetailPresentableListener
  
  var viewModel: Observable<UIImage> {
    viewModelRelay.asObservable()
  }
  
  private let viewModelRelay: BehaviorRelay<UIImage>
  
  // MARK: - Con(De)structor
  
  init(image: UIImage, presenter: ImageDetailPresentable) {
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
}

// MARK: - Binding
private extension ImageDetailInteractor {
  func bindPresenter() {
    presenter.detachObservable
      .bind { [weak self] _ in
        self?.listener?.detachImageDetailRIB()
    }
    .disposeOnDeactivate(interactor: self)
  }
}
