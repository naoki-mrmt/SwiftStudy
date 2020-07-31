//
//  UITableView+UITableViewDataSource.swift
//  MyToolList
//
//  Created by cmStudent on 2020/07/28.
//  Copyright © 2020 Muramoto & Co. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource {
    
       // テーブルの行数を返却する
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // ToDoの配列の長さを返却する
           return todoList.count
       }
       
       //テーブルの行ごとのセルを返却する
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // Storyboardで指定したtodoCell識別子を利用して再利用可能なセルを取得する
           let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
           // 行番号に合ったToDoの情報を取得
           let myTodo = todoList[indexPath.row]
           // セルのラベルにToDoのタイトルをセット
           cell.textLabel?.text = myTodo.todoTitle
           // セルのチェックマーク状態をセット
           if myTodo.todoDone {
               // チェックあり
               cell.accessoryType = UITableViewCell.AccessoryType.checkmark
           } else {
               // チェックなし
               cell.accessoryType = UITableViewCell.AccessoryType.none
           }
           return cell
       }
       
       // セルを削除した時の処理
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           // 削除可能かどうか
           if editingStyle == UITableViewCell.EditingStyle.delete {
               // ToDoリストから削除
               todoList.remove(at: indexPath.row)
               // セルを削除
               tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
               // データ保存。Data型にシリアライズする
               do {
                   let data: Data = try NSKeyedArchiver.archivedData(withRootObject: todoList, requiringSecureCoding: true)
                   // UserDefaultsに保存
                   let userDefaults = UserDefaults.standard
                   userDefaults.set(data, forKey: "todoList")
                   userDefaults.synchronize()
               } catch {
                   // エラー処理なし
               }
           }
       
       }
    
}
