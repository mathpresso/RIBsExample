//
//  ImageDetailBuilder.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol ImageDetailDependency: Dependency {
  var image: UIImage { get }
}

final class ImageDetailComponent: Component<ImageDetailDependency> {
  var image: UIImage {
    dependency.image
  }
}

protocol ImageDetailBuildable: Buildable {
  func build(withListener listener: ImageDetailListener) -> ImageDetailRouting
}

final class ImageDetailBuilder:
  Builder<ImageDetailDependency>,
  ImageDetailBuildable
{
  override init(dependency: ImageDetailDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: ImageDetailListener) -> ImageDetailRouting {
    let component = ImageDetailComponent(dependency: dependency)
    let viewController = ImageDetailViewController(image: component.image)
    let interactor = ImageDetailInteractor(presenter: viewController)
    interactor.listener = listener
    
    return ImageDetailRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
