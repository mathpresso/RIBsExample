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
}

final class RootRouter:
  LaunchRouter<RootInteractable, RootViewControllable>,
  RootRouting
{
  // MARK: - Properties
  
  private let imageBuilder: ImageBuildable
  
  private var imageRouter: ImageRouting?
  
  // MARK: - Overridden: LaunchRouter
  
  init(
    imageBuilder: ImageBuildable,
    interactor: RootInteractable,
    viewController: RootViewControllable
  ) {
    self.imageBuilder = imageBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}

// MARK: - RootRouting
extension RootRouter {
  func attachImageRIB() {
    let router = imageBuilder.build(withListener: interactor)
    attachChild(router)
    imageRouter = router
    viewController.present(router.viewControllable, animated: false)
  }
}
