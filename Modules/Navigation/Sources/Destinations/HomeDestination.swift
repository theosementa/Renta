//
//  HomeDestination.swift
//  Navigation
//
//  Created by Theo Sementa on 15/06/2026.
//

import PharosNav

public enum HomeDestination: DestinationItem {
    case list
    case detail(id: String)
    case addItem
}
