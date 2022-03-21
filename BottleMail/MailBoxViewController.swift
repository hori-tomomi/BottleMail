//
//  MailBoxViewController.swift
//  BottleMail
//
//  Created by Tomomi Hori on 2022/03/07.
//

import UIKit
import RealmSwift

class MailBoxViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    var _bottleItems: Results<BottleContents>!
    var _cellNum: Int!
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMdkHms", options: 0, locale: Locale(identifier: "ja_JP"))
        print(dateFormatter.string(from: now))
        
        table.dataSource = self
        let realm = try! Realm()
        
        //recieveDateが今日より前の日付だったら表示
        self._bottleItems = realm.objects(BottleContents.self).filter("receiveDate <= %@" , now)
        table.reloadData()

        // Do any additional setup after loading the view.
    }
    
    // 画面遷移した際に、リロードして全てのリストを表示
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            table.reloadData()
    }
    
    //UITableView、numberOfRowsInSectionの追加(表示するcell数を決める)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //戻り値の設定(表示するcell数)
        return _bottleItems.count
    }
    
    //UITableView、cellForRowAtの追加(表示するcellの中身を決める)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bottleCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottleCell", for: indexPath)
        let item: BottleContents = _bottleItems[(indexPath).row];
        bottleCell.textLabel?.text = item.title
        //戻り値の設定（表示する中身)
        return bottleCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteBottle(at: indexPath.row)
            table.reloadData()
        }
    }
    
    func deleteBottle(at index: Int){
        let realm = try! Realm()
        try! realm.write{
            realm.delete(_bottleItems[index])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoReadView" {
            if let indexPath = table.indexPathForSelectedRow {
                guard let destination = segue.destination as? ReadViewController else {
                    fatalError("Failed to prepare DetailViewController.")
                }
                _cellNum = indexPath.row
                let item: BottleContents = _bottleItems[_cellNum];
                destination._titleText = item.title
                destination._createdDateText = item.createDate
                destination._contentText = item.content
                }
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

