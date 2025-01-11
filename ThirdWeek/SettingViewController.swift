//
//  SettingViewController.swift
//  ThirdWeek
//
//  Created by BAE on 1/10/25.
//

import UIKit


struct Setting {
    static let total = "전체 설정"
    static let personal = "개인 설정"
    static let others = "기타"
    
    private init() { }
}

enum SettingOptions: Int, CaseIterable  {
//    var hello = "고래밥"
    static var hello = "고래밥"
    case total
    case personal
    case others
    // Int로 선언하면 rawValue를 자동으로 0부터 순서대로 할당함
    
    var mainOption: String {
        switch self {
        case .total:
            return "전체설정"
        case .personal:
            return "개인 설정"
        case .others:
            return "기타"
        }
    }
    
    var subOption: [String] {
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅"]
        case .others:
            return ["고객센터/도움말"]
        }
    }
}

class SettingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let sectionList = ["전체설정", "개인설정", "기타"]
    let settingOptions = SettingOptions.allCases
    let rowList1 = ["공지사항", "실험실", "버전정보"]
    let rowList2 = ["개인/보안", "알림", "채팅"]
    let rowList3 = ["고객센터/도움말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        print(SettingOptions.others)
        print(SettingOptions.others.rawValue)
        print(Setting.others)
        print(SettingOptions.total.mainOption)
        print(SettingOptions.personal.mainOption)
        print(SettingOptions.others.mainOption)
        
        print("--------------------------------")
        print(SettingOptions.total.subOption)
        print(SettingOptions.total.subOption[2])
    }

}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].mainOption
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOptions.allCases[section].subOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        
        print(indexPath.forEach { print("\($0.description)") } )
        
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].subOption[indexPath.row]
        return cell
    }
    
}
