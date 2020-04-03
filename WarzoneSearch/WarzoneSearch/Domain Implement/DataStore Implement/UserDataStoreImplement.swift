//
//  UserDataStoreImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire
import SwiftyJSON
import CoreData

class UserDataStoreImplement: UserDataStore {
    
    private let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    private let entityName = "User"
    
    func getUserList() -> Observable<[UserViewable]> {
        return Observable.create { observer in
            var models = [UserViewable]()
            
            if let context = self.context {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
                do {
                    if let fetchResult: [User] = try context.fetch(fetchRequest) as? [User] {
                        for user in fetchResult {
                            models.append(UserViewModel(user: user))
                        }
                        
                        observer.onNext(models.sorted { $0.updateTime > $1.updateTime })
                        observer.onCompleted()
                    }
                } catch let error {
                    print(error.localizedDescription)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func saveUser(platform: Platform, id: String) {
        guard let context = self.context, let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context) else {
            return
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
        do {
            if let fetchResult: [User] = try context.fetch(fetchRequest) as? [User] {
                
                if fetchResult.count == 0 {
                    let user = NSManagedObject(entity: entity, insertInto: context)
                    user.setValue(id, forKey: "id")
                    user.setValue(platform.name, forKey: "platform")
                    user.setValue(Date(), forKey: "updateTime")
                    try context.save()
                } else {
                    var saveFlag: Bool = true
                    for user in fetchResult {
                        guard let savePlatform = user.platform, let saveId = user.id else { return }
                        
                        if savePlatform == platform.name && saveId == id {
                            saveFlag = false
                            user.setValue(Date(), forKey: "updateTime")
                            try context.save()
                        }
                    }
                    if saveFlag {
                        let user = NSManagedObject(entity: entity, insertInto: context)
                        user.setValue(id, forKey: "id")
                        user.setValue(platform.name, forKey: "platform")
                        user.setValue(Date(), forKey: "updateTime")
                        try context.save()
                    }
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
