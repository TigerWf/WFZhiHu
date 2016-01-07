//
//  AppDelegate.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "AppDelegate.h"
#import "WFMainController.h"
#import "WFHomePageController.h"
#import "WFSettingController.h"
#import "WFCommonController.h"
#import "WFHomePageVM.h"
#import "WFLeftVM.h"
#import "WFCommonVM.h"

#import "WFManager+MainViewInfo.h"

#import "WFCartoonController.h"
#import "WFCompanyController.h"
#import "WFDesignController.h"
#import "WFDonotBoredController.h"
#import "WFFilmController.h"
#import "WFFinanceController.h"
#import "WFGameController.h"
#import "WFMusicController.h"
#import "WFNetSecurityController.h"
#import "WFPsychicController.h"
#import "WFRecommendController.h"
#import "WFSportController.h"

@interface AppDelegate ()
{
    UIImageView *_firstLaunchView;
    UIImageView *_secondLaunchView;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    WFMainController *mainController = [[WFMainController alloc] initWithLeftController:[[WFLeftController alloc] initWithViewModel:[WFLeftVM new]] andControllers:[self configControllers]];
    self.window.rootViewController = mainController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setLaunchView];
    return YES;

}

- (void)setLaunchView{
    
    _secondLaunchView = [[UIImageView alloc] initWithFrame:kScreenBounds];
    _secondLaunchView.contentMode = UIViewContentModeScaleAspectFill;
    [self.window addSubview:_secondLaunchView];
    
    _firstLaunchView = [[UIImageView alloc] initWithFrame:kScreenBounds];
    _firstLaunchView.contentMode = UIViewContentModeScaleAspectFill;
    _firstLaunchView.image = Image(@"Default");
    [self.window addSubview:_firstLaunchView];
    
    [WFManager wf_getLaunchImageWithSize:@"720*1184" success:^(id data) {
        [_secondLaunchView wf_setImageWithUrlString:data[@"img"] placeholderImage:nil];
        [UIView animateWithDuration:2.f animations:^{
            _firstLaunchView.alpha = 0.f;
            _secondLaunchView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        } completion:^(BOOL finished) {
            [_firstLaunchView removeFromSuperview];
            [_secondLaunchView removeFromSuperview];
        }];
    } failure:^(WFError *error) {
        [_firstLaunchView removeFromSuperview];
        [_secondLaunchView removeFromSuperview];
    }];
}

//有点sb？
- (NSMutableArray *)configControllers{
    
    UINavigationController *homePageNav = [[UINavigationController alloc] initWithRootViewController:[[WFHomePageController alloc] initWithViewModel:[WFHomePageVM new]]];
    
    UINavigationController *cartoonNav = [[UINavigationController alloc] initWithRootViewController:[[WFCartoonController alloc] initWithViewModel:[WFCommonVM new]]];
    
    UINavigationController *psychicNav = [[UINavigationController alloc] initWithRootViewController:[[WFPsychicController alloc] initWithViewModel:[WFCommonVM new]]];

    UINavigationController *recommendNav = [[UINavigationController alloc] initWithRootViewController:[[WFRecommendController alloc] initWithViewModel:[WFCommonVM new]]];

    UINavigationController *filmNav = [[UINavigationController alloc] initWithRootViewController:[[WFFilmController alloc] initWithViewModel:[WFCommonVM new]]];

    UINavigationController *donotBoredNav = [[UINavigationController alloc] initWithRootViewController:[[WFDonotBoredController alloc] initWithViewModel:[WFCommonVM new]]];

    UINavigationController *designNav = [[UINavigationController alloc] initWithRootViewController:[[WFDesignController alloc] initWithViewModel:[WFCommonVM new]]];
    
    UINavigationController *companyNav = [[UINavigationController alloc] initWithRootViewController:[[WFCompanyController alloc] initWithViewModel:[WFCommonVM new]]];
    
    UINavigationController *financeNav = [[UINavigationController alloc] initWithRootViewController:[[WFFinanceController alloc] initWithViewModel:[WFCommonVM new]]];
    
    UINavigationController *netSecurityNav = [[UINavigationController alloc] initWithRootViewController:[[WFNetSecurityController alloc] initWithViewModel:[WFCommonVM new]]];
    
    UINavigationController *gameNav = [[UINavigationController alloc] initWithRootViewController:[[WFGameController alloc] initWithViewModel:[WFCommonVM new]]];
    
    UINavigationController *musicNav = [[UINavigationController alloc] initWithRootViewController:[[WFMusicController alloc] initWithViewModel:[WFCommonVM new]]];
    
    UINavigationController *sportNav = [[UINavigationController alloc] initWithRootViewController:[[WFSportController alloc] initWithViewModel:[WFCommonVM new]]];
    
    
    NSMutableArray *controllers = [NSMutableArray arrayWithObjects:homePageNav,cartoonNav,psychicNav,recommendNav,filmNav,donotBoredNav,designNav,companyNav,financeNav,netSecurityNav,gameNav,musicNav,sportNav, nil];
    
    return controllers;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
