//
//  SearchHelper.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 6.01.2022.
//

import Foundation

final class SearchHelper {

    typealias SearchHandler = (String) -> Void
    private let interval: TimeInterval
    private let searchHandler: SearchHandler

    private var workItem: DispatchWorkItem?

    init(interval: TimeInterval = 1.0, handler: @escaping SearchHandler) {
        self.interval = interval
        self.searchHandler = handler
    }

    func handleTyping(text: String) {
        workItem?.cancel()
        workItem = DispatchWorkItem { [weak self] in
            self?.searchHandler(text)
        }

        if let workItem = self.workItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: workItem)
        }
    }
}
