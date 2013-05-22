//
//  UAccountID.h
//  Locations
//
//  Created by Pavel Pantus on 5/13/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

@interface UAccountID : NSObject<NSCopying, NSCoding>
{
    NSNumber *identifier;
}

@property (nonatomic, strong) NSNumber *identifier;

- (id)initWithJson:(id)json;
- (id)initWithInt:(int)accountid;
- (id)initWithNSNumber:(NSNumber *)accountid;
- (id)initWithString:(NSString *)accountid;

- (BOOL)isValid;
- (int)toInt;
- (id)toJson;
- (id)value; //same as above?
- (NSString *)toString;


//NSCopying
- (id)copyWithZone:(NSZone *)zone;
@end