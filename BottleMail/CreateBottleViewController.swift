//
//  CreateBottleViewController.swift
//  BottleMail
//
//  Created by Tomomi Hori on 2022/03/07.
//

import UIKit
import RealmSwift


var titleArray = [String]()
var dateArray = [String]()
var contentsArray = [String]()

var ToDate = DateFormatter.date


class CreateBottleViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    let realm = try! Realm()

    @IBOutlet var _createdDatePicker: UIDatePicker!
    @IBOutlet var _receiveDatePicker: UIDatePicker!
    @IBOutlet var _titleTextField: UITextField!
    @IBOutlet var _contentTextView: UITextView!
    @IBOutlet var _addButton: UIButton!
    
    var titleItems:Results<BottleContents>!
    var _createdDateText: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Realm内に保存した内容を保存するための定数bottleの初期化
        //let bottle: BottleContents? = read()
        
        _createdDatePicker.preferredDatePickerStyle = .compact
        _createdDatePicker.datePickerMode = .date
        _receiveDatePicker.preferredDatePickerStyle = .compact
        _receiveDatePicker.datePickerMode = .date

        _titleTextField.delegate = self
        
        let custombar = UIView(frame: CGRect(x:0, y:0,width:(UIScreen.main.bounds.size.width),height:40))
        custombar.backgroundColor = UIColor.groupTableViewBackground
        let commitBtn = UIButton(frame: CGRect(x:(UIScreen.main.bounds.size.width)-50,y:0,width:50,height:40))
        commitBtn.setTitle("Close", for: .normal)
        commitBtn.setTitleColor(UIColor.blue, for:.normal)
        commitBtn.addTarget(self, action:#selector(CreateBottleViewController.onClickCommitButton), for: .touchUpInside)
        custombar.addSubview(commitBtn)
        _contentTextView.inputAccessoryView = custombar
        _contentTextView.keyboardType = .default
        _contentTextView.delegate = self
        
        let realm_1 = try! Realm()
        self.titleItems = realm_1.objects(BottleContents.self)

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Realmにアクセスして、情報を読み出す
    /*func read() -> BottleContents? {
        
        return realm.objects(BottleContents.self).first
        
    }*/
    
    @objc func onClickCommitButton (sender: UIButton) {
        if(_contentTextView.isFirstResponder){
            _contentTextView.resignFirstResponder()
        }
    }
    
    //送信ボタンが押されたときの処理
    @IBAction func addButton(_ sender: Any) {
        let realm_2 = try! Realm()
        let bottleItem:BottleContents = BottleContents()
        let formatter = DateFormatter()
        
        
        formatter.dateFormat = "yyyy/MM/dd"
        _createdDateText = "\(formatter.string(from: _createdDatePicker.date))"
        
        bottleItem.receiveDate = self._receiveDatePicker.date
        bottleItem.title = self._titleTextField.text
        bottleItem.createDate = self._createdDateText
        bottleItem.content = self._contentTextView.text
        
        try! realm_2.write{
            realm_2.add(bottleItem)
        }
           
        _titleTextField.text = ""
        _contentTextView.text = ""
        print ("保存されたかなあ")
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
