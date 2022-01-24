//
//  Types.swift
//  Redux
//
//  Created by Ihor Yarovyi on 8/15/21.
//

import ReduxStore
import Core

public typealias Action = Core.Action
public typealias AppState = Core.AppState
public typealias Graph = Core.Graph
public typealias Store = ReduxStore.Store<AppState, Action>
public typealias Observer = ReduxStore.Observer<AppState>
public typealias Command = () -> Void
