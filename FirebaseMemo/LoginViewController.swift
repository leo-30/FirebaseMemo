//
//  LoginViewController.swift
//  FirebaseMemo
//
//  Created by 原田澪 on 2019/12/06.
//  Copyright © 2019 MioHarada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var mailLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        // エラーがなければ何もしません
        guard let error = errorOrNil else { return }
         
        let message = errorMessage(of: error) // エラーメッセージを取得
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
     
    private func errorMessage(of error: Error) -> String {
        var message = "エラーが発生しました"
        guard let errcd = AuthErrorCode(rawValue: (error as NSError).code) else {
            return message
        }
         
        switch errcd {
        case .networkError: message = "ネットワークに接続できません"
        case .userNotFound: message = "ユーザが見つかりません"
        case .invalidEmail: message = "不正なメールアドレスです"
        case .emailAlreadyInUse: message = "このメールアドレスは既に使われています"
        case .wrongPassword: message = "入力した認証情報でサインインできません"
        case .userDisabled: message = "このアカウントは無効です"
        case .weakPassword: message = "パスワードが脆弱すぎます"
        // これは一例です。必要に応じて増減させてください
        default: break
        }
        return message
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            //let uid = user.uid
            let name = user.displayName
            let email = user.email
            //let photoURL = user.photoURL
            nameLabel.text = name
            mailLabel.text = email
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func didTapSignOutButton() {
        let user = Auth.auth().currentUser
        let name = user?.displayName
        let email = user?.email
        do {
            try Auth.auth().signOut()
            messageLabel.text = "ログアウトしました"
            nameLabel.text = name
            mailLabel.text = email
        } catch let error {
            showErrorIfNeeded(error)
        }
    }
    
    @IBAction private func didTapWithdrawButton() {
        Auth.auth().currentUser?.delete() { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                // 非ログイン時の画面へ
                self.dismiss(animated: true, completion: nil)
            }
            self.showErrorIfNeeded(error)
        }
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
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
