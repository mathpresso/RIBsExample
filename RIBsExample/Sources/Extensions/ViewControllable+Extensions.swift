//
//  ViewControllable+Extensions.swift
//  RIBsExample
//
//  Created by Schofield on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

extension ViewControllable {
  func push(viewController: ViewControllable, animated: Bool = true) {
    uiviewController.navigationController?.pushViewController(
      viewController.uiviewController,
      animated: animated
    )
  }
  
  func pop(
    to viewController: ViewControllable,
    animated: Bool = true,
    needToDismissPresentedViewController: Bool = true,
    dismissAnimated: Bool = false
  ) {
    if needToDismissPresentedViewController,
      let presentedViewController = viewController.uiviewController.presentedViewController {
      presentedViewController.dismiss(animated: dismissAnimated) { [weak self] in
        self?.uiviewController.navigationController?.popToViewController(
          viewController.uiviewController,
          animated: animated
        )
      }
    } else {
      uiviewController.navigationController?.popToViewController(
        viewController.uiviewController,
        animated: animated
      )
    }
  }
  
  func pop(
    _ viewController: ViewControllable,
    animated: Bool = true,
    needToDismissPresentedViewController: Bool = true,
    dismissAnimated: Bool = false
  ) {
    guard !viewController.uiviewController.isMovingFromParent else { return }
    pop(
      to: self,
      animated: animated,
      needToDismissPresentedViewController: needToDismissPresentedViewController,
      dismissAnimated: dismissAnimated
    )
  }
  
  func popToRootViewController(
    animated: Bool = true,
    needToDismissPresentedViewController: Bool = true,
    dismissAnimated: Bool = false
  ) {
    if needToDismissPresentedViewController,
      let presentedViewController = uiviewController.presentedViewController {
      presentedViewController.dismiss(animated: dismissAnimated) { [weak self] in
        self?.uiviewController.navigationController?.popToRootViewController(animated: animated)
      }
    } else {
      uiviewController.navigationController?.popToRootViewController(animated: animated)
    }
  }
  
  func present(
    _ viewController: ViewControllable,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    uiviewController.present(
      viewController.uiviewController,
      animated: animated,
      completion: completion
    )
  }
  
  func dismiss(
    _ viewController: ViewControllable,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    guard !viewController.uiviewController.isBeingDismissed else {
      completion?()
      return
    }
    
    viewController.uiviewController.dismiss(
      animated: animated,
      completion: completion
    )
  }
  
  func dismissPresentedViewController(
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    if let presentedViewController = uiviewController.presentedViewController {
      presentedViewController.dismiss(animated: animated, completion: completion)
    } else {
      completion?()
    }
  }
}
