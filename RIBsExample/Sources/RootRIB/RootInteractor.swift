//
//  RootInteractor.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol RootRouting: ViewableRouting {
  func attachImageRIB()
}

protocol RootPresentable: Presentable {
  var listener: RootPresentableListener? { get set }
}

protocol RootListener: class {
}

final class RootInteractor:
  PresentableInteractor<RootPresentable>,
  RootInteractable,
  RootPresentableListener
{
  // MARK: - RootInteractable
  
  weak var router: RootRouting?
  
  weak var listener: RootListener?
  
  // MARK: - Overridden: PresentableInteractor
  
  override init(presenter: RootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: - RootPresentableListener
extension RootInteractor {
  func showImageRIB() {
    router?.attachImageRIB()
  }
}
