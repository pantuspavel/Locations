//
//  UAccountType.m
//  Locations
//
//  Created by Pavel Pantus on 5/13/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

#import "UAccountType.h"

@implementation UAccountType
@synthesize accountType;

- (BOOL)isEqual:(id)other {
    return ([other isKindOfClass:[UAccountType class]] && self.accountType == ((UAccountType *)other).accountType);
}

- (NSUInteger)hash {
    return self.accountType;
}

- (NSString *)toString {
    switch (accountType) {
        case AccountFake:
            return @"fake";
        case AccountNormal:
            return @"normal";
        case AccountDeleted:
            return @"deleted";
        default:
            return @""; //FIXME: should it be nil instead?
    }
    return @""; //FIXME: should it be nil instead?
}

- (void)fromString:(NSString *)stype {
    enum AccountType type;
    if ([stype isEqualToString:@"fake"]) {
        type = AccountFake;
    } else if ([stype isEqualToString:@"normal"] || [stype isEqualToString:@"confirmed"]) {
        type = AccountNormal;
    } else if ([stype isEqualToString:@"deleted"]) {
        type = AccountDeleted;
    } else {
        type = AccountUndefined;
    }
	
    accountType = type;
}

- (NSString *)value {
    return [self toString];
}

- (id)init {
    self = [super init];
    if (self) {
        self.accountType = AccountUndefined;
    }
    return self;
}

- (id)initWithAccountType:(enum AccountType)atype {
    self = [super init];
    if (self) {
        self.accountType = atype;
    }
    return self;
}

- (id)initWithString:(NSString *)stype {
    self = [super init];
    if (self) {
        [self fromString:stype];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    UAccountType *copy = [[[self class] alloc] init];
    if (copy) {
        copy.accountType = self.accountType;
    }
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:[self toString] forKey:@"Type"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
    if (self) {
		[self fromString:[aDecoder decodeObjectForKey:@"Type"]];
    }
    return self;
}

@end
