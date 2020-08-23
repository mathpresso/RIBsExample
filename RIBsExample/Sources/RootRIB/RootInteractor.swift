//
//  RootInteractor.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol RootRouting: ViewableRouting {
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
  
  // MARK: - Con(De)structor
  
  override init(presenter: RootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
}
