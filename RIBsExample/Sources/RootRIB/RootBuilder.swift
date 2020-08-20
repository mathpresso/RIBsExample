//
//  RootBuilder.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
  
}

final class RootComponent: Component<RootDependency> {
  
  let rootViewController: RootViewController
  
  init(dependency: RootDependency, rootViewController: RootViewController) {
    self.rootViewController = rootViewController
    super.init(dependency: dependency)
  }
}

protocol RootBuildable: Buildable {
  func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
  // MARK: - RootBuildable
  
  func build() -> LaunchRouting {
    let viewController = RootViewController()
    let component = RootComponent(
      dependency: dependency,
      rootViewController: viewController
    )
    let interactor = RootInteractor(presenter: viewController)
    
    let imageBuilder = ImageBuilder(dependency: component)
    
    return RootRouter(
      imageBuilder: imageBuilder,
      interactor: interactor,
      viewController: viewController
    )
  }
}
