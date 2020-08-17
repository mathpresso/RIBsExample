//
//  ImageBuilder.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol ImageDependency: Dependency {
}

final class ImageComponent: Component<ImageDependency> {
  let image: UIImage
  
  init(
    image: UIImage,
    dependency: ImageDependency
  ) {
    self.image = image
    super.init(dependency: dependency)
  }
}

extension EmptyComponent: ImageDependency { }

protocol ImageBuildable: Buildable {
  func build(image: UIImage, withListener listener: ImageListener) -> ImageRouting
}

final class ImageBuilder:
  Builder<ImageDependency>,
  ImageBuildable
{
  override init(dependency: ImageDependency = EmptyComponent()) {
    super.init(dependency: dependency)
  }
  
  func build(image: UIImage, withListener listener: ImageListener) -> ImageRouting {
    let component = ImageComponent(image: image, dependency: dependency)
    let viewController = ImageViewController(image: image)
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
