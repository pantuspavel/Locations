//
//  UFlakeID.m
//  Locations
//
//  Created by Pavel Pantus on 5/13/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

#import "UFlakeID.h"

@implementation UFlakeID
@synthesize identifier;



- (id)init {
    self = [super init];
    if (self) {
        //TODO: custom init
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    UFlakeID *copy = [[[self class] alloc] init];
    if (copy) {
        copy->identifier = self.identifier;
    }
    return copy;
}

- (BOOL)isValid {
    return (self.identifier != nil) && (self.identifier.length == 11);
}

- (NSString *)toString {
    return self.identifier;
}

- (id)initWithString:(NSString *)str {
    self = [super init];
    if (self) {
        self->identifier = str;
    }
    return self;
}

- (id)value {
    return identifier;
}

- (BOOL)isEqual:(id)other {
    return ([other isKindOfClass:[UFlakeID class]] && [self.identifier isEqualToString:((UFlakeID *)other).identifier]);
}

- (NSUInteger)hash {
    return [self.identifier hash];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.identifier forKey:@"id"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
    if (self) {
		self.identifier = [aDecoder decodeObjectForKey:@"Id"];
    }
    return self;
}

@end