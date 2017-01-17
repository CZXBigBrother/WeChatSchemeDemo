//
//  wechatVC.m
//  wechatopenUrl
//
//  Created by marco chen on 2017/1/10.
//  Copyright © 2017年 marco chen. All rights reserved.
//

#import "wechatVC.h"
#import "JLRoutes/JLRoutes.h"

@interface wechatVC ()<UIWebViewDelegate>

@end

@implementation wechatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView * web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    web.delegate = self;
    NSString *html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo.html" ofType:nil] encoding:NSUTF8StringEncoding error:NULL];
    [web loadHTMLString:html baseURL:nil];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //    全自动[JLRoutes routeURL:request.URL]
    if ([request.URL.scheme isEqualToString:@"weixin"]) {
        return [JLRoutes routeURL:request.URL];
    }
    return YES;

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [JLRoutes routeURL:[NSURL URLWithString:@"weixin://dl/games"]];

}

//2017-01-16 14:03:39.934 wechatopenUrl[25457:4178993] /wechat
//2017-01-16 14:03:39.934 wechatopenUrl[25457:4178993] /wechat/scan
//2017-01-16 14:03:39.935 wechatopenUrl[25457:4178993] /address
//2017-01-16 14:03:39.935 wechatopenUrl[25457:4178993] /discover
//2017-01-16 14:03:39.935 wechatopenUrl[25457:4178993] /discover/moments
//2017-01-16 14:03:39.935 wechatopenUrl[25457:4178993] /discover/games
//2017-01-16 14:03:39.935 wechatopenUrl[25457:4178993] /self
//2017-01-16 14:03:39.935 wechatopenUrl[25457:4178993] /self/settings
//2017-01-16 14:03:39.936 wechatopenUrl[25457:4178993] /self/settings/feedback
//2017-01-16 14:03:39.936 wechatopenUrl[25457:4178993] /self/favorites

@end
