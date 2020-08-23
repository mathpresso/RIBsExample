//
//  ImageRouter.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol ImageInteractable:
  Interactable,
  ImageDetailListener
{
  var router: ImageRouting? { get set }
  var listener: ImageListener? { get set }
}

protocol ImageViewControllable: ViewControllable {
}

final class ImageRouter:
  ViewableRouter<ImageInteractable, ImageViewControllable>,
  ImageRouting
{
  private let imageDetailBuilder: ImageDetailBuildable
  
  private var imageDetailRouter: ImageDetailRouting?
  
  init(
    imageDetailBuilder: ImageDetailBuildable,
    interactor: ImageInteractable,
    viewController: ImageViewControllable
  ) {
    self.imageDetailBuilder = imageDetailBuilder
    super.init(
      interactor: interactor,
      viewController: viewController
    )
    interactor.router = self
  }
}

// MARK: - ImageRouting
extension ImageRouter {
  func attachImageDetailRIB() {
    let router = imageDetailBuilder.build(withListener: interactor)
    imageDetailRouter = router
    attachChild(router)
    viewControllable.present(router.viewControllable)
  }
  
  func detachImageDetailRIB() {
    guard let router = imageDetailRouter else { return }
    viewControllable.dismiss(router.viewControllable)
    detachChild(router)
    imageDetailRouter = nil
  }
}
