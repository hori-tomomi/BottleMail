//
//  ReadViewController.swift
//  BottleMail
//
//  Created by Tomomi Hori on 2022/03/07.
//

import UIKit
import RealmSwift

class ReadViewController: UIViewController {
    
    @IBOutlet var _titleTextField: UITextField!
    @IBOutlet var _createdDateTextField: UITextField!
    @IBOutlet var _contentTextView: UITextView!
    
    var bottleItem: BottleContents!
    var _index: Int!
    var _titleText: String!
    var _contentText: String!
    var _createdDateText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _titleTextField.text = _titleText
        _contentTextView.text = _contentText
        _createdDateTextField.text = _createdDateText
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
