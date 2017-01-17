//
//  AppDelegate.m
//  wechatopenUrl
//
//  Created by marco chen on 2017/1/10.
//  Copyright © 2017年 marco chen. All rights reserved.
//

#import "AppDelegate.h"
#import "JLRoutes/JLRoutes.h"
#import "MCWeChatRoutes.h"

@interface AppDelegate ()
@property(strong, nonatomic) NSMutableArray *targetArr;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.targetArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wechatSchemePlist" ofType:@"plist"]];
    
    [[JLRoutes routesForScheme:@"weixin"] addRoute:@"/dl/:name" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSLog(@"找到了 %@",[MCWeChatRoutes searchPath:@"" withArr:self.targetArr withTarget:[parameters objectForKey:@"name"]]);
        NSArray * arr = [MCWeChatRoutes filteArr:self.targetArr withTarget:[parameters objectForKey:@"name"]];
        NSLog(@"arr = %@",arr);
        [self getChildsViewController:arr];
        return NO;
    }];
    
    return YES;
}
- (void)getChildsViewController :(NSArray *)arr {
    UITabBarController * root = (UITabBarController *)self.window.rootViewController;
    for (int i = 0; i < root.childViewControllers.count; i++) {
        NSDictionary * dict = [arr firstObject];
        UINavigationController * nav = root.childViewControllers[i];
        UIViewController * vc = [nav.childViewControllers firstObject];
        NSLog(@"UIViewController = %@",vc);
        if ([vc isKindOfClass:NSClassFromString(dict[@"class"])]) {
            NSLog(@"yes");
            NSMutableArray * temp = [NSMutableArray arrayWithObject:vc];
            [temp addObjectsFromArray:[MCWeChatRoutes retureViewController:arr]];
            [nav setViewControllers:temp];
            root.selectedViewController = nav;
        }
    }
    
}


@end
