/**
 Copyright 2018 eureka, Inc.

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation

import Bulk

struct TowerFormatter: Bulk.Formatter {

  public typealias FormatType = String

  public struct LevelString {
    public var verbose = "📜"
    public var debug = "📃"
    public var info = "💡"
    public var warn = "⚠️"
    public var error = "❌"
  }

  public let dateFormatter: DateFormatter

  public var levelString = LevelString()

  public init() {

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    self.dateFormatter = formatter

  }

  public func format(log: Log) -> FormatType {

    let level: String = {
      switch log.level {
      case .verbose: return levelString.verbose
      case .debug: return levelString.debug
      case .info: return levelString.info
      case .warn: return levelString.warn
      case .error: return levelString.error
      }
    }()

    let timestamp = dateFormatter.string(from: log.date)
    let string: String
    
    switch log.level {
    case .warn, .error:
      let file = URL(string: log.file.description)?.deletingPathExtension()
      string = "[\(timestamp)] \(level) \(file?.lastPathComponent ?? "???").\(log.function):\(log.line) \(log.body)"
    default:
      string = "[\(timestamp)] \(level) \(log.body)"
    }

    return string
  }
}
