//
//  MCRoutes.h
//  wechatopenUrl
//
//  Created by marco chen on 2017/1/16.
//  Copyright © 2017年 marco chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCWeChatRoutes : NSObject
+ (NSString *)searchPath:(NSString *)path withArr:(NSArray *)arr withTarget:(NSString *)name;
+ (NSString *)searchIndex:(NSString *)path withArr:(NSArray *)arr withTarget:(NSString *)name;
+ (NSArray *)filteArr:(NSArray *)arr withTarget:(NSString *)name;
+ (id)MC_RuntimeClassKey:(NSString *)name;
+ (NSMutableArray *)retureViewController:(NSArray *)arr;
@end
