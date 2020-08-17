//
//  RootViewController.swift
//  RIBsExample
//
//  Created by Mathpresso on 2020/08/10.
//  Copyright © 2020 Mathpresso. All rights reserved.
//

import RIBs

protocol RootPresentableListener: class {
  func showImageRIB()
}

final class RootViewController:
  UIViewController,
  RootPresentable,
  RootViewControllable
{
  // MARK: - RootPresentable
  
  weak var listener: RootPresentableListener?
  
  // MARK: - Overridden: UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    listener?.showImageRIB()
  }
}
