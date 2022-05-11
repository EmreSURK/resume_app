//
//  BaseViewModelProtocol.swift
//  ResumeApp
//
//  Created by Emre on 10.05.2022.
//

import Foundation


protocol BaseViewModelProtocol {
    var isInitialDataReady: Bool { get }
    func onUIReady()
}
