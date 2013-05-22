//
//  UFlakeID.h
//  Locations
//
//  Created by Pavel Pantus on 5/13/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

@interface UFlakeID : NSObject<NSCopying, NSCoding>
{
    NSString *identifier;
}

- (id)copyWithZone:(NSZone *)zone;

@property (nonatomic, strong) NSString *identifier;

- (id)initWithString:(NSString *)str;
- (BOOL)isValid;
- (NSString *)toString;
- (id)value;
@end
