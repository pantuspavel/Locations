//
//  UAccountID.m
//  Locations
//
//  Created by Pavel Pantus on 5/13/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

#import "UAccountID.h"

@implementation UAccountID

@synthesize identifier;


- (id)init {
    self = [super init];
    if (self) {
        //TODO: custom init
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    UAccountID *copy = [[[self class] alloc] init];
    if (copy) {
        copy.identifier = self.identifier;
    }
    return copy;
}

- (BOOL)isEqual:(id)other {
    return ([other isKindOfClass:[UAccountID class]] && [self.identifier isEqualToNumber:((UAccountID *)other).identifier]);
}

- (NSUInteger)hash {
    return [self.identifier integerValue];
}

- (id)initWithInt:(int)accountid {
    self = [super init];
    if (self) {
        self.identifier = [NSNumber numberWithInt:accountid];
    }
    return self;
}

- (id)initWithNSNumber:(NSNumber *)accountid {
    self = [super init];
    if (self) {
        self.identifier = accountid;
    }
    return self;
}

- (id)initWithString:(NSString *)accountid {
    self = [super init];
    if (self) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *myNumber = [f numberFromString:accountid];
        self.identifier = myNumber;
    }
    return self;
}

- (int)toInt {
    if (self.identifier == nil) return -1;
    return [identifier intValue];
}

- (id)toJson {
    return [self value];
}

- (NSString *)toString {
    return [identifier stringValue];
}

- (id)initWithJson:(id)json {
    self = [super init];
    if (self) {
        [self fillFromJson:json];
    }
    return self;
}

- (void)fillFromJson:(id)json {
    int account = [[json valueForKey:@"account"] integerValue];
    self.identifier = [NSNumber numberWithInt:account];
}

- (BOOL)isValid {
    return (identifier != nil);
}

- (id)value {
    return identifier;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.identifier forKey:@"Id"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
    if (self) {
		self.identifier = [aDecoder decodeObjectForKey:@"Id"];
    }
    return self;
}

@end
