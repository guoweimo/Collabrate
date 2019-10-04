//
//  LCHandler.swift
//  Smarock
//
//  Created by Guowei Mo on 15/02/2019.
//  Copyright © 2019 Smarock. All rights reserved.
//

import Foundation
import LeanCloud
typealias Completion<T> = (DataResult<T>) -> Void

enum DataError: Error {
  case invalidData
}

enum DataResult<T> {
  case success(T?)
  case failure(Error)
}

struct LCHandler {
  
  static let objectSaveCompletion: (LCBooleanResult, Completion<Bool>) -> Void = { result, completion in
    switch result {
    case .success:
      completion(.success(true))
    case .failure(let error):
      completion(.failure(error))
    }
  }
  
  static func addObject<Object: Codable>(_ object: Object, completion: @escaping Completion<Bool>) {
    guard let dict = object.json() else {
      completion(.failure(DataError.invalidData))
      return
    }
    let className = String(describing: Object.self)
    let obj = LCObject(className: className)
    obj.setValuesForKeys(dict)
    obj.save { result in
      objectSaveCompletion(result, completion)
    }
  }
  
  static func removeObject(type ObjectType: Any, with id: String, completion: @escaping Completion<Bool>) {
    let obj = LCObject(className: String(describing: ObjectType.self), objectId: id)
    obj.delete { result in
      objectSaveCompletion(result, completion)
    }
  }
  
  static func removeObjects(type ObjectType: Any, matching clauses: [Clause], completion: @escaping Completion<Bool>) {
    let query = LCQuery(className: String(describing: ObjectType.self))
    query.addClauses(clauses)
    query.find { result in
      switch result {
      case .success(let objects):
        LCObject.delete(objects) { result in
          objectSaveCompletion(result, completion)
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  static func updateObject(type ObjectType: Any, with id: String, and data: [String: Any], completion: @escaping Completion<Bool>) {
    let obj = LCObject(className: String(describing: ObjectType.self), objectId: id)
    obj.setValuesForKeys(data)
    obj.save(options: [.fetchWhenSave]) { result in
      objectSaveCompletion(result, completion)
    }
  }
  
  /// updateObjects matching conditions, if not found, add new object
  ///
  /// - Parameters:
  ///   - ObjectType: a codable object type
  ///   - clauses: condition clasues
  ///   - data: dictionary data to update
  ///   - completion: completion handler
  static func updateObjects(type ObjectType: Any, matching clauses: [Clause], and data: [String: Any], completion: @escaping Completion<Bool>) {
    let query = LCQuery(className: String(describing: ObjectType.self))
    query.addClauses(clauses)
    
    query.find { result in
      switch result {
      case .success(let objects):
        objects.forEach { obj in
          obj.setValuesForKeys(data)
        }
        LCObject.save(objects, options: [.fetchWhenSave]) { result in
          objectSaveCompletion(result, completion)
        }
        
      case .failure(let error):
        if error.code == 101 {
          let className = String(describing: ObjectType.self)
          let obj = LCObject(className: className)
          obj.setValuesForKeys(data)
          obj.save()
          return
        }
      }
    }
  }
  
  static func addObjects<Object: Codable>(_ objects: [Object], completion: @escaping Completion<Bool>) {
    let objs = objects.map { object -> LCObject in
      let data = object.json() ?? [:]
      let lcObj = LCObject(className: String(describing: Object.self))
      lcObj.setValuesForKeys(data)
      return lcObj
    }
    LCObject.save(objs) { result in
      objectSaveCompletion(result, completion)
    }
  }
    
  static func getObjects<Object: Codable>(with query: LCQuery, completion: @escaping Completion<[Object]>) {
    query.find { result in
      switch result {
      case .success(let objects):
        let targets = objects.map { obj -> Object? in
          guard let json = obj.dictionaryValue,
            let data = try? JSONSerialization.data(withJSONObject: json, options: []) else {
              return nil
          }
          do {
            let target =  try JSONDecoder().decode(Object.self, from: data)
            return target
          } catch {
            print(error)
            return nil
          }
        }.compactMap { $0 }
        completion(.success(targets))
      case .failure(let error):
        if error.code == 101 {
          completion(.success([]))
          return
        }
        completion(.failure(error))
      }
    }
  }
  
  static func getObjects<Object: Codable>(matchingAll clauses: [Clause], completion: @escaping Completion<[Object]>) {
    let query = LCQuery(className: String(describing: Object.self))
    query.addClauses(clauses)
    getObjects(with: query, completion: completion)
  }
}
