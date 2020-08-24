//
//  RootRouter.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol RootInteractable:
  Interactable,
  ImageListener
{
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
  func present(_ viewController: ViewControllable, animated: Bool)
}

final class RootRouter:
  LaunchRouter<RootInteractable, RootViewControllable>,
  RootRouting
{
  // MARK: - Properties
  
  private let imageBuilder: ImageBuildable
  
  // MARK: - Con(De)structor
  
  init(
    imageBuilder: ImageBuildable,
    interactor: RootInteractable,
    viewController: RootViewControllable
  ) {
    self.imageBuilder = imageBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: - Overridden: LaunchRouter
  
  override func didLoad() {
    super.didLoad()
    
    attachImageRIB()
  }
  
  // MARK: - Private methods
  
  private func attachImageRIB() {
    let router = imageBuilder.build(withListener: interactor)
    attachChild(router)
    viewController.present(router.viewControllable, animated: false)
  }
}
