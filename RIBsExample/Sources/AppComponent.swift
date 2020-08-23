//
//  AppComponent.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/20.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
  init() {
    super.init(dependency: EmptyComponent())
  }
}
