//
//  TContactDetails.m
//  Locations
//
//  Created by Pavel Pantus on 5/13/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

#import "TContactDetails.h"

@implementation TContactDetails
@synthesize pending;
@synthesize lastEvent;
@synthesize type;

- (id)copyWithZone:(NSZone *)zone {
    TContactDetails *copy = [[[self class] alloc] init];
    if (copy) {
        [copy setPending:self.pending];
        [copy setLastEvent:self.lastEvent];
        copy->type = TContactDetailsStruct;
    }
    return copy;
}

- (id)init {
    self = [super init];
    if (self) {
        type = TContactDetailsStruct;
        pending = PendingUnknown;
        lastEvent = 0;
    }
    return self;
}

- (BOOL)isValid {
    return YES;
}

- (void)fillFromJson:(id)json {
    NSDictionary *d = (NSDictionary *)json;
    pending = [self pendingFromString:[d objectForKey:@"pending"]];
	
    id personlastEvent = [d objectForKey:@"last_event"];
    if ([personlastEvent isKindOfClass:[NSNull class]]) {
        lastEvent = 0;
    } else {
        lastEvent = [personlastEvent longLongValue];
    }
}

- (id)value {
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    [d setObject:[self pendingToString:self.pending] forKey:@"pending"];
    [d setObject:[NSNumber numberWithLongLong:lastEvent] forKey:@"last_event"];
    return d;
}

- (NSString *)pendingToString:(enum PendingType)pendingType;
{
    NSString *result = @"";
    switch (pendingType) {
        case PendingConnect:
            result = @"paConnect";
            break;
        case PendingAuthorize:
            result = @"paAuthorize";
            break;
        case PendingAskAgain:
            result = @"paAskAgain";
            break;
        case PendingDone:
            result = @"paDone";
            break;
        case PendingWaiting:
            result = @"paWaiting";
            break;
        case PendingUnknown:
        default:
            break;
    }
    return result;
}
- (enum PendingType)pendingFromString:(NSString *)pendingTypeString;
{
    if ([pendingTypeString isEqualToString:@"paConnect"]) {
        return PendingConnect;
    } else if ([pendingTypeString isEqualToString:@"paAuthorize"]) {
        return PendingAuthorize;
    } else if ([pendingTypeString isEqualToString:@"paAskAgain"]) {
        return PendingAskAgain;
    } else if ([pendingTypeString isEqualToString:@"paDone"]) {
        return PendingDone;
    } else if ([pendingTypeString isEqualToString:@"paWaiting"]) {
        return PendingWaiting;
    }
    return PendingUnknown;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:[NSNumber numberWithLongLong:self.lastEvent] forKey:@"LastEvent"];
	[aCoder encodeObject:[NSNumber numberWithInt:self.pending] forKey:@"Pending"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
    if (self) {
		NSNumber* lastEventNumber = [aDecoder decodeObjectForKey:@"LastEvent"];
		NSNumber* pendingNumber = [aDecoder decodeObjectForKey:@"Pending"];
		
		self.lastEvent = lastEventNumber.longLongValue;
		self.pending = pendingNumber.integerValue;
    }
    return self;
}

@end
