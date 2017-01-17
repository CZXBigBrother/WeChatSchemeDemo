//
//  MCRoutes.m
//  wechatopenUrl
//
//  Created by marco chen on 2017/1/16.
//  Copyright © 2017年 marco chen. All rights reserved.
//

#import "MCWeChatRoutes.h"

@implementation MCWeChatRoutes

+ (NSString *)searchPath:(NSString *)path withArr:(NSArray *)arr withTarget:(NSString *)name{
    for (NSDictionary * data in arr) {
        NSString * temp = [[path stringByAppendingString:@"/"] stringByAppendingString: [data objectForKey:@"name"]];
        if ([[data objectForKey:@"name"] isEqualToString:name]) {
            return temp;
        }else
            if ([data objectForKey:@"childs"] && [[data objectForKey:@"childs"]count]>0) {
                NSString * path1 = [self searchPath:temp withArr:[data objectForKey:@"childs"] withTarget:name];
                if (path1) {return path1;}
            }
    }
    return nil;
}
+ (NSString *)searchIndex:(NSString *)path withArr:(NSArray *)arr withTarget:(NSString *)name {
    for (int i = 0; i<arr.count; i++) {
        NSDictionary * data = arr[i];
        NSString * temp = [[path stringByAppendingString:@"/"] stringByAppendingString: [NSString stringWithFormat:@"%zd",i]];
        if ([[data objectForKey:@"name"] isEqualToString:name]) {
            return temp;
        }else if ([data objectForKey:@"childs"] && [[data objectForKey:@"childs"]count]>0) {
            NSString * path1 = [self searchIndex:temp withArr:[data objectForKey:@"childs"] withTarget:name];
            if (path1) {return path1;}
        }
    }

    return nil;
}
+ (NSArray *)filteArr:(NSArray *)arr withTarget:(NSString *)name{
    NSMutableArray * pathArr = [NSMutableArray arrayWithArray:[[self searchIndex:@"" withArr:arr withTarget:name] componentsSeparatedByString:@"/"]];
    if ([[pathArr firstObject]isEqualToString:@""]) {
        [pathArr removeObjectAtIndex:0];
    }
    return [self getArrPathArr:pathArr withOriginal:arr];
}
+ (NSMutableArray *)getArrPathArr:(NSArray *)pathArr withOriginal:(NSArray *)OriginalArr {
    NSMutableArray * tempArr = [NSMutableArray arrayWithCapacity:pathArr.count];
    NSDictionary * tempDict;
    for (int i = 0; i<pathArr.count; i++) {
        if (tempDict == nil) {
            tempDict = OriginalArr[[[pathArr firstObject] integerValue]];
        }else {
            tempDict = [tempDict objectForKey:@"childs"][[pathArr[i]integerValue]];
        }
        [tempArr addObject:tempDict];
    }
    return tempArr;
}
+ (id)MC_RuntimeClassKey:(NSString *)name {
    return [[NSClassFromString(name) alloc]init];
}
+ (NSMutableArray *)retureViewController:(NSArray *)arr {
    NSMutableArray * temparr = [NSMutableArray arrayWithCapacity:arr.count - 1];
    for (int i = 1; i < arr.count; i++ ) {
        NSDictionary * dict = arr[i];
        [temparr addObject:[self MC_RuntimeClassKey:[dict objectForKey:@"class"]]];
    }
    return temparr;
}
@end
