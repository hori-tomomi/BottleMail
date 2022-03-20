//
//  MailBoxViewController.swift
//  BottleMail
//
//  Created by Tomomi Hori on 2022/03/07.
//

import UIKit
import RealmSwift

class MailBoxViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    var bottleItems: Results<BottleContents>!
    var list: List<BottleContents>!
    var selectedBottle: BottleContents!
    var cellNum: Int!
   // var bottleContentList: Results<BottleContents>!
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMdkHms", options: 0, locale: Locale(identifier: "ja_JP"))
        print(dateFormatter.string(from: now))
        
        table.dataSource = self
        let realm = try! Realm()
        // Realmのfunctionでデータを取得。functionを更に追加することで、フィルターもかけられる
        
        //recieveDateが今日の日付と一緒だったら　　がToDateと本日までの日付の間立ったら表示
        self.bottleItems = realm.objects(BottleContents.self).filter("receiveDate <= %@" , now)
        table.reloadData()
        
        //Realm内に保存した内容を保存するための定数bottleの初期化
        //let bottle: BottleContents? = read()
        
        /*if bottle != nil {
            
        }*/


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
        return bottleItems.count
    }
    
    //UITableView、cellForRowAtの追加(表示するcellの中身を決める)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bottleCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottleCell", for: indexPath)
        let item: BottleContents = bottleItems[(indexPath).row];
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
            realm.delete(bottleItems[index])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoReadView" {
            if let indexPath = table.indexPathForSelectedRow {
                guard let destination = segue.destination as? ReadViewController else {
                    fatalError("Failed to prepare DetailViewController.")
                }
                cellNum = indexPath.row
                let item: BottleContents = bottleItems[cellNum];
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
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoReadView", sender: nil)
        
      }*/

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

