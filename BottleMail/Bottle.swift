//
//  Bottle.swift
//  BottleMail
//
//  Created by Tomomi Hori on 2022/03/16.
//

import Foundation
import RealmSwift

class BottleContents: Object{
    @objc dynamic var title: String? = nil
    @objc dynamic var content: String? = nil
    @objc dynamic var createDate: String? = nil
    @objc dynamic var receiveDate = Date()
}
