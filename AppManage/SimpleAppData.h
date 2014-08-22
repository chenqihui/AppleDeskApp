//
//  SimpleAppData.h
//  AppManage
//
//  Created by chen on 14-8-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppObject.h"

@interface SimpleAppData : NSObject<AppObject>

+ (instancetype)randomAppObject;
+ (instancetype)randomAppObjectWithTitle:(NSString *)title;
+ (instancetype)appObjectWithTitle:(NSString *)title appId:(int)appId;
- (instancetype)initWithTitle:(NSString *)title appId:(int)appId;

@end
