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
    @objc dynamic var receiveDate: String? = nil
    //Realmは配列使えないので、realmから持ってきたデータをMailBoxViewController内で配列にぶち込んで使う方法検討
}


