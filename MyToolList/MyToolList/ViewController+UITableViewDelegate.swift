//
//  ViewController+UITableViewDelegate.swift
//  MyToolList
//
//  Created by cmStudent on 2020/07/28.
//  Copyright © 2020 Muramoto & Co. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate {

    //  セルをタップした時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myTodo = todoList[indexPath.row]
        if myTodo.todoDone {
            // 完了済みの場合は未完了に変更
            myTodo.todoDone = false
        } else {
            // 未完了の場合は完了済みに変更
            myTodo.todoDone = true
        }
        // セルの状態を変更
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
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


