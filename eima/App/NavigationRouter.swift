//
//  NavigationRouter.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import SwiftUI

public protocol NavigationRouter {
    
    associatedtype V: View

    var transition: NavigationTransitionStyle { get }
    
    /// Creates and returns a view of assosiated type
    ///
    @ViewBuilder
    func view() -> V
}

