//
//  Flow.swift
//
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public typealias Flow = () -> Void
public typealias FlowBuilderWith<Dependency> = (Dependency) -> Flow

public typealias ViewControllerBuilder = () -> UIViewController
public typealias ViewControllerBuilderWith<Dependency> = (Dependency) -> UIViewController
