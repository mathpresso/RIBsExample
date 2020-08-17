//
//  RootBuilder.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol RootBuildable: Buildable {
  func build() -> LaunchRouting
}

final class RootBuilder: RootBuildable {
  // MARK: - RootBuildable
  
  func build() -> LaunchRouting {
    let viewController = RootViewController()
    let interactor = RootInteractor(presenter: viewController)
    
    let imageBuilder = ImageBuilder()
    
    return RootRouter(
      imageBuilder: imageBuilder,
      interactor: interactor,
      viewController: viewController
    )
  }
}
