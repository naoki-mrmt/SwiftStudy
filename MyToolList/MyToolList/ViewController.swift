//
//  ViewController.swift
//  MyToolList
//
//  Created by cmStudent on 2020/07/24.
//  Copyright © 2020 Muramoto & Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    // ToDOoを格納した配列
    var todoList = [MyTodo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 保存しているToDo読み込み処理
        let userDefaults = UserDefaults.standard
        if let storedToDoList = userDefaults.object(forKey: "todoList") as? Data {
            do {
                if let unarchiveTodoList = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, MyTodo.self], from: storedToDoList) as? [MyTodo] {
                    todoList.append(contentsOf: unarchiveTodoList)
                }
            }catch {
                // エラー処理なし
            }
        }
    }
    
    // +ボタンをタップした時に呼ばれる処理
    @IBAction func tapAddButton(_ sender: Any) {
        // アラートダイアログを作成
        let alertController = UIAlertController(title: "ToDo追加", message: "ToDoを入力してください", preferredStyle: UIAlertController.Style.alert)
        
        // テキストエリアを追加
        alertController.addTextField(configurationHandler: nil)
        // OKボタンを追加
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
            // OKボタンがタップされた時の処理
            if let textField = alertController.textFields?.first {
                // ToDoの配列の入力値を挿入。先頭に挿入する
                let myTodo = MyTodo()
                myTodo.todoTitle = textField.text!
                self.todoList.insert(myTodo, at: 0)
                // テーブルに行が追加されたことをテーブルに通知
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
                
                // ToDoの保存処理
                let userDefaults = UserDefaults.standard
                // Data型にシリアライズする
                do{
                    let data = try NSKeyedArchiver.archivedData(withRootObject: self.todoList, requiringSecureCoding: true)
                    userDefaults.set(data, forKey: "todoList")
                    userDefaults.synchronize()
                } catch {
                    // エラー処理なし
                }
            }
        }
        // OKボタンがタップされた時の処理
        alertController.addAction(okAction)
        // CANCELボタンがタップされた時の処理
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil)
        // CANCELボタンを追加
        alertController.addAction(cancelButton)
        // アラートダイアログの表示
        present(alertController, animated: true, completion: nil)
    }
   
}
