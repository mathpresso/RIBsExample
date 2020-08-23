//
//  ImageDetailRouter.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol ImageDetailInteractable: Interactable {
  var router: ImageDetailRouting? { get set }
  var listener: ImageDetailListener? { get set }
}

protocol ImageDetailViewControllable: ViewControllable {
}

final class ImageDetailRouter:
  ViewableRouter<ImageDetailInteractable, ImageDetailViewControllable>,
  ImageDetailRouting
{
  override init(interactor: ImageDetailInteractable, viewController: ImageDetailViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
