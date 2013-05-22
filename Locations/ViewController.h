//
//  ViewController.h
//  Locations
//
//  Created by Pavel Pantus on 5/10/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import "CoreData/NSFetchedResultsController.h"

@interface ViewController : UITableViewController < NSFetchedResultsControllerDelegate >                                                                                                                                                                                                                                                                                                                                                               

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIBarButtonItem *addButton;
@property (nonatomic, retain) UIBarButtonItem *editButton;
@property (nonatomic, retain) UIBarButtonItem *changeOrderButton;

@end
