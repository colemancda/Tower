//
//  GraphQLController.swift
//  TowerAPI
//
//  Created by muukii on 5/19/18.
//

import Foundation

import Graphiti
import Vapor

// https://github.com/GraphQLSwift/Graphiti/blob/master/Tests/GraphitiTests/StarWarsTests/StarWarsSchema.swift

struct QueryContainer : Content {

  let query: String
  let variable: String?
}

struct Session : OutputType {
  let id: String
  let name: String
  let remote: String
}

struct Task : OutputType {

}

final class GraphQLController {

  enum Error : Swift.Error {
    case something
  }

  private let schema: Schema<Void, NoContext>

  init() {

    do {
      self.schema = try Schema<Void, NoContext> { schema in

        try schema.object(
          type: Session.self,
          build: { (builder) in
            try builder.exportFields()
        })

        try schema.query { query in

          try query.field(name: "allSessions", type: [Session].self) { _, _, _, _ in
            return [

            ]
          }

          struct TasksArguments : Arguments {
            let sessionIdentifier: String
          }

          try query.field(name: "allTasks", type: [Task].self) { (_, args: TasksArguments, _, _) in
            return []
          }

        }

      }
    } catch {
      fatalError("\(error)")
    }

    print(schema)
  }

  func execute(request: Request) throws -> Future<Response> {

    print(request.http.body)

    return try request.content
      .decode(QueryContainer.self)
      .map({ (queryContainer) -> (Response) in
        let r = try self.schema.execute(request: queryContainer.query)
        return request.makeResponse(r.description, as: .json)
      })

  }
}
