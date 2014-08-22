//
//  AppObject.h
//  AppManage
//
//  Created by chen on 14-8-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppObject<NSObject>

@property (copy, nonatomic) NSString *appTitle;
@property (assign, nonatomic) int appId;

@end
