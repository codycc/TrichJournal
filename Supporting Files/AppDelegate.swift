//
//  AppDelegate.swift
//  TrichJournal
//
//  Created by Cody Condon on 2025-01-21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        //for save to files controller so the fonts visible
        self.window?.tintColor = .blue
        
        if launchedBefore {
            
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            print("this function was called ")
            let computer = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let homework = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let driving = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let grooming = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let bathroom = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let inBed = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let watchingTv = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let inFrontOfMirror = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let inPublic = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            
            
            computer.setValue("Computer", forKey: "place")
            homework.setValue("Homework", forKey: "place")
            driving.setValue("Driving", forKey: "place")
            grooming.setValue("Grooming", forKey: "place")
            bathroom.setValue("Bathroom", forKey: "place")
            inBed.setValue("In Bed", forKey: "place")
            watchingTv.setValue("Watching TV", forKey: "place")
            inFrontOfMirror.setValue("In Front Of Mirror", forKey: "place")
            inPublic.setValue("In Public", forKey: "place")
            
            do {
                try context.save()
            } catch {
                print("error saving data \(error)")
            }
           
        }
        
       
        
        
        // Override point for customization after application launch.
        
        UIFont.familyNames.forEach({ name in
            for font_name in UIFont.fontNames(forFamilyName: name) {
                print("\(font_name)")
            }
            
            
            
        })
        
        
      
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TrichJournal")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

