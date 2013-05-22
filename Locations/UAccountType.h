//
//  UAccountType.h
//  Locations
//
//  Created by Pavel Pantus on 5/13/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

enum AccountType {
    AccountUndefined,
    AccountDeleted,
    AccountFake,
    AccountNormal
};


@interface UAccountType : NSObject<NSCopying, NSCoding>
{
    enum AccountType accountType;
}
@property (nonatomic, assign) enum AccountType accountType;

- (BOOL)isEqual:(id)other;
- (NSUInteger)hash;

- (NSString *)value;
- (NSString *)toString;
- (void)fromString:(NSString *)stype;
- (id)initWithAccountType:(enum AccountType)atype;
- (id)initWithString:(NSString *)stype;
- (id)copyWithZone:(NSZone *)zone;
@end
