//
//  MyTodo.swift
//  MyToolList
//
//  Created by cmStudent on 2020/07/28.
//  Copyright © 2020 Muramoto & Co. All rights reserved.
//

import Foundation


// 独自クラスをシリアライズする際には、NSObjectを継承し
    // NSSecureCodingプロトコルに準拠する必要がある
class MyTodo: NSObject, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    // ToDoのタイトル
    var todoTitle: String?
    // ToDoを完了したかどうかを表すフラグ
    var todoDone: Bool = false
    // コンストラクタ
    override init() {
    }
    
    // NSCodingプロトコルに宣言されているでシリアライズ処理。(デコード処理)
    required init?(coder: NSCoder) {
        todoTitle = coder.decodeObject(forKey: "todoTitle") as? String
        todoDone = coder.decodeBool(forKey: "todoDone")
    }
    // NSCodingプロトコルに宣言されているシリアライズ処理(エンコード処理)
    func encode(with aCoder: NSCoder) {
        aCoder.encode(todoTitle, forKey: "todoTitle")
        aCoder.encode(todoDone, forKey: "todoDone")
    }
}

