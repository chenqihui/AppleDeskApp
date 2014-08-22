//
//  SimpleAppData.m
//  AppManage
//
//  Created by chen on 14-8-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "SimpleAppData.h"

@implementation SimpleAppData

@synthesize appTitle = _appTitle;
@synthesize appId = _appId;

+ (instancetype)randomAppObject
{
    uint32_t randomID = arc4random_uniform(10000);
    NSString *title = [NSString stringWithFormat:@"Title #%u", randomID];
    
    return [self appObjectWithTitle:title appId:randomID];
}

+ (instancetype)randomAppObjectWithTitle:(NSString *)title
{
    uint32_t randomID = arc4random_uniform(100);
    
    return [self appObjectWithTitle:title appId:randomID];
}

+ (instancetype)appObjectWithTitle:(NSString *)title appId:(int)appId
{
    return [[self alloc] initWithTitle:title appId:appId];
}

- (instancetype)initWithTitle:(NSString *)title appId:(int)appId
{
    self = [super init];
    if (self != nil)
    {
        _appTitle = [title copy];
        _appId = appId;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%d: %@:", self.appId, self.appTitle];
}

@end
