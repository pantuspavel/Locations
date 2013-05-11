//
//  AppDelegate.h
//  Locations
//
//  Created by Pavel Pantus on 5/10/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//properties
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//methods
- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;

@end
