//
//  Logger.swift
//  Microblog
//
//  Created by Victor on 25/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import XCGLogger

let log: XCGLogger = {
    let logger = XCGLogger.default
    let emojiLogFormatter = PrePostFixLogFormatter()
    emojiLogFormatter.apply(prefix: "🗯 ", postfix: " 🗯", to: .verbose)
    emojiLogFormatter.apply(prefix: "🔹 ", postfix: " 🔹", to: .debug)
    emojiLogFormatter.apply(prefix: "ℹ️ ", postfix: " ℹ️", to: .info)
    emojiLogFormatter.apply(prefix: "⚠️ ", postfix: " ⚠️", to: .warning)
    emojiLogFormatter.apply(prefix: "‼️ ", postfix: " ‼️", to: .error)
    emojiLogFormatter.apply(prefix: "💣 ", postfix: " 💣", to: .severe)
    logger.formatters = [emojiLogFormatter]
    return logger
}()
