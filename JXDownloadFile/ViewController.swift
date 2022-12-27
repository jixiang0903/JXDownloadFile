//
//  ViewController.swift
//  JXDownloadFile
//
//  Created by jixiang on 2022/12/27.
//

import UIKit
import Tiercel
import SVProgressHUD

class ViewController: UIViewController {
    var sessionManager = SessionManager("ViewController", configuration: SessionConfiguration())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let downloadBtn = UIButton(type: .custom)
        downloadBtn.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        downloadBtn.setTitle("下载文件", for: .normal)
        downloadBtn.setTitleColor(.red, for: .normal)
        downloadBtn.addTarget(self, action: #selector(downloadFile), for: .touchUpInside)
        self.view.addSubview(downloadBtn)
        
        
        
    }
    
    @objc func downloadFile() {
        //https://oss-workplace-prod.innoecos.cn/picture/05919decfa000000_iOSDemo.pdf
        //https://oss-workplace-prod.innoecos.cn/picture/0591960c05c00000_aaaa.docx
        //https://dscloud-digitalmaint-iyou-prod.oss-cn-beijing.aliyuncs.com/prod/6ccbgbfh8ha97867b8dacdc56h7b5ece_1659783077043.png
        
        let link = "https://oss-workplace-prod.innoecos.cn/picture/0591960c05c00000_aaaa.docx"
        _ = sessionManager.download(link)?.progress{ (task) in
            SVProgressHUD.showProgress(Float(task.progress.fractionCompleted), status: "下载中…")
        }.completion { [weak self] task in
            SVProgressHUD.dismiss()
            if task.status == .succeeded {// 下载成功
                let activityViewController = UIActivityViewController(activityItems: [URL.init(fileURLWithPath: task.filePath)], applicationActivities: nil)
                self?.present(activityViewController, animated: true, completion: nil)
            }else {
                
            }
        }
    }

}

