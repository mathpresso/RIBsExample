//
//  RootComponent+Image.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/20.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol RootDependencyImage: Dependency {
}

extension RootComponent: ImageDependency {
  var image: UIImage {
    UIImage(named: "image1.jpg")!
  }
}
