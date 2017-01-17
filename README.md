![WechatIMG2.png](http://upload-images.jianshu.io/upload_images/3258209-980a5498c083432d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
####有人还记得,但是这段跳转的URL吗,一点直接从网页调到指定的界面了(不过现在已经被封了,不用再尝试了)
内部跳转其实很平常,只要给出指点的路径URL就能实现
但是我们分析下微信的URL:
第一部分是scheme:weixin
第二部分应该是一个判断是否进跳转方法的参数:dl
最后部分是要跳转的vc的名字
没有给一个完整的跳转路径是如何完成一步步的加载的,所以我有了一个实现的猜想虽然不一定和微信的完全一样
#解决方案是在程序内部存放一张跳转的路由表
![
![Uploading Snip20170117_2_280003.png . . .]
](http://upload-images.jianshu.io/upload_images/3258209-90007dca948e2138.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
通常一次一次查找,找到存放的路径
![Snip20170117_2.png](http://upload-images.jianshu.io/upload_images/3258209-b025d86b79745138.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
存储的实体数据

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/3258209-7333c79949c21d3c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
name:对外的查找名
class:controller的名字,之后可以通过NSClassFromString(name)方式创建实例
childs:这个类底下还能打开的子类
##具体的实现
###配合JLRoutes获取目标类名
```
[[JLRoutes routesForScheme:@"weixin"] addRoute:@"/dl/:name" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
//分析出目标类
return NO;
}];
```

###打开H类
```
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
```
我们通过查找之后获得到的路径相当于/0/1/1数组第一个对象底下子类的第二个类底下的第二个类
```
根据表格创建
nav setViewControllers@[微信类,B类,H类]
之后修改TabBar selected
selectedViewController = 微信类
```
#做了一个丑陋的Demo........不喜勿喷
![wechat.gif](http://upload-images.jianshu.io/upload_images/3258209-3b37b109e1ae77d0.gif?imageMogr2/auto-orient/strip)





