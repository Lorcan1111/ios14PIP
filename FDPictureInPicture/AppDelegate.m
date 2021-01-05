//
//  AppDelegate.m
//  FDPictureInPicture
//
//  Created by fd-macmini on 2020/10/9.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "EnterViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    EnterViewController *rvc = [EnterViewController new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rvc];
    navi.navigationBar.backgroundColor = [UIColor blueColor];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
