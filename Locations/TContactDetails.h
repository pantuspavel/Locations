//
//  TContactDetails.h
//  Locations
//
//  Created by Pavel Pantus on 5/13/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

#import "AbstractStruct.h"

enum PendingType {
    PendingConnect,
    PendingAuthorize,
    PendingAskAgain,
    PendingDone,
    PendingWaiting,
    PendingUnknown
};

@interface TContactDetails : NSObject<NSCopying, NSCoding, AbstractStruct>
{
    enum PendingType pending;
    long long lastEvent;
}


@property (nonatomic, assign) enum PendingType pending;
@property (nonatomic, assign) long long lastEvent;


- (NSString *)pendingToString:(enum PendingType)pendingType;
- (enum PendingType)pendingFromString:(NSString *)pendingTypeString;

//NSCopying
- (id)copyWithZone:(NSZone *)zone;
//AbstractStruct
@property (nonatomic, assign, readonly) enum StructType type;
- (BOOL)isValid;
- (void)fillFromJson:(id)json;
- (id)value;

@end
