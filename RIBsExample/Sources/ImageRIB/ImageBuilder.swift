//
//  ImageBuilder.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol ImageDependency: Dependency {
  var image: UIImage { get }
}

final class ImageComponent: Component<ImageDependency> {
  var image: UIImage {
    dependency.image
  }
}

protocol ImageBuildable: Buildable {
  func build(withListener listener: ImageListener) -> ImageRouting
}

final class ImageBuilder:
  Builder<ImageDependency>,
  ImageBuildable
{
  override init(dependency: ImageDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: ImageListener) -> ImageRouting {
    let component = ImageComponent(dependency: dependency)
    let viewController = ImageViewController(image: component.image)
    let interactor = ImageInteractor(presenter: viewController)
    interactor.listener = listener
    
    let imageDetailBuilder = ImageDetailBuilder(dependency: component)
    return ImageRouter(
      imageDetailBuilder: imageDetailBuilder,
      interactor: interactor,
      viewController: viewController
    )
  }
}
