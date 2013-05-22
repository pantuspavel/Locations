//
//  TContact.h
//  Locations
//
//  Created by Pavel Pantus on 5/13/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "UAccountID.h"
#import "UFlakeID.h"
#import "UAccountType.h"
#import "TContactDetails.h"

@interface TContact : NSManagedObject

@property (nonatomic, retain) UAccountID* identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) UFlakeID* avatarId;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) UFlakeID* organizationId;
@property (nonatomic, retain) UAccountType* accountType;
@property (nonatomic, retain) NSDate * lastModified;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) TContactDetails* details;

@end
