//
//  WFMainController.m
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFMainController.h"
#import "WFBaseController.h"
#import "WFLeftDataModel.h"


@interface WFMainController ()<UIGestureRecognizerDelegate>
{
    UIView *_leftMenuView;//左边目录栏的视图
    CGFloat _originX;
    BOOL    _isFold;//是否已经展开
    UITapGestureRecognizer *_tapGesture;//单击手势
    
}

@property(nonatomic,strong) WFLeftController *leftController;//左抽屉的视图控制器
@property(nonatomic,strong) UIViewController *showViewController;//最上层显示的viewcontroller
@property(nonatomic,copy)   NSString *markLevelVc;//纪录最上层的vc
@property(nonatomic,strong) UIViewController *containerController;//视图控制器容器

@end

@implementation WFMainController

- (id)initWithLeftController:(WFLeftController *)leftController
              andControllers:(NSMutableArray *)controllers{
    
    if (self == [super init]) {
       
        self.leftController = leftController;
        self.controllers = controllers;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;


}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    DLog(@"will disappear");
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    DLog(@"will Appear");
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _originX = 0;
    _isFold = NO;//默认不是展开
    
    
    WS(weakSelf);
    
    [_leftController.viewModel requestLeftData:_controllers];
    
   
    
    _leftMenuView = [[UIView alloc] init];
    _leftMenuView = _leftController.view;
    _leftMenuView.frame = CGRectMake(-kScreenWidth * kDrawerRatio, 0, kScreenWidth * kDrawerRatio, kScreenHeight);
    [self.view addSubview:_leftMenuView];
    
    _leftController.drawerAction = ^(NSString *className){//左抽屉tableview点击事件
    
       
        for (WFBaseController *vc in weakSelf.controllers) {
            
            if ([NSStringFromClass([vc class]) isEqualToString:className]) {
                
                vc.showFlag = YES;
                
                if ([className isEqualToString:weakSelf.markLevelVc]) {//如果和标记的控制器一样 则直接隐藏左抽屉
                    [weakSelf hideDrawerList];
                    return ;
                }
                
                _markLevelVc = className;
                
            }else{
                
                vc.showFlag = NO;
            }
            
        }
        
        [weakSelf convertControllerLayerLevel];
    };

    _containerController = [UIViewController new];
    _containerController.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_containerController.view];
    
    
    [self convertControllerLayerLevel];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
 
}

#pragma mark - 设置controller 层级
- (void)convertControllerLayerLevel{
    
    int k = 0;
    
    if (_showViewController != nil) {//如果不为nil移除最上面的视图控制器
       
        [_showViewController.view removeFromSuperview];
        [_showViewController removeFromParentViewController];
    }
    
    [self hideDrawerList];//隐藏左抽屉
    
    for (WFBaseController *vc in _controllers) {
        if (vc.showFlag == YES) {//有主动标记为最上
            
            _markLevelVc = NSStringFromClass([vc class]);
            k ++;
            
            [_containerController addChildViewController:vc];
            [_containerController.view addSubview:vc.view];
            
            vc.view.alpha = 0.f;
            [UIView animateWithDuration:0.4f animations:^{
                vc.view.alpha = 1.0f;
            } completion:^(BOOL finished) {
                _showViewController = vc;
            }];
            
        }
    }

    if (k == 0) {//没标记最上  用数组第一个放最上
        
        WFBaseController *vc = [_controllers firstObject];
        [_containerController addChildViewController:vc];
        [_containerController.view addSubview:vc.view];
        _markLevelVc = NSStringFromClass([vc class]);
        
        vc.view.alpha = 0.f;
        [UIView animateWithDuration:0.4f animations:^{
            vc.view.alpha = 1.0f;
        } completion:^(BOOL finished) {
            _showViewController = vc;
        }];

    }
    DLog(@"_containerController.child.count = %ld",_containerController.childViewControllers.count);
}

#pragma mark - 手势相关

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
      
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.view];
        return fabs(translation.x) > fabs(translation.y);
    
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if ([otherGestureRecognizer isKindOfClass:[XPPanGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}
#pragma mark - 平移手势
- (void)panAction:(UIPanGestureRecognizer *)recongnizer{
    
    CGPoint touchPoint = [recongnizer locationInView:self.view];
    switch (recongnizer.state) {
            
        case UIGestureRecognizerStateBegan:{
            
            _originX = touchPoint.x;
            
        }
            break;
            
        case UIGestureRecognizerStateChanged:{
            
            CGFloat offSetX = touchPoint.x - _originX;
        
            if (offSetX >= kScreenWidth * kDrawerRatio) {
                offSetX = kScreenWidth * kDrawerRatio;
               
            }
            
            if (offSetX <= -kScreenWidth * kDrawerRatio ) {
                offSetX = -kScreenWidth * kDrawerRatio;
               
            }
        
            
            if (_isFold == NO) {
          
                 _leftMenuView.frame = CGRectMake(-kScreenWidth * kDrawerRatio + offSetX, 0, kScreenWidth * kDrawerRatio, kScreenHeight);
                _containerController.view.frame = CGRectMake(offSetX, 0, kScreenWidth, kScreenHeight);
                
                if (_containerController.view.frame.origin.x <= 0) {
                    _containerController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                }

                
                
                if (_leftMenuView.frame.origin.x <= -kScreenWidth * kDrawerRatio) {
                    
                    _leftMenuView.frame = CGRectMake(-kScreenWidth * kDrawerRatio, 0, kScreenWidth * kDrawerRatio, kScreenHeight);

                }
               
            }else{
             
                _leftMenuView.frame = CGRectMake(offSetX, 0, kScreenWidth * kDrawerRatio, kScreenHeight);
                _containerController.view.frame = CGRectMake(kScreenWidth * kDrawerRatio + offSetX, 0, kScreenWidth, kScreenHeight);
                if (_containerController.view.frame.origin.x >= kScreenWidth * kDrawerRatio ) {
                    _containerController.view.frame = CGRectMake(kScreenWidth * kDrawerRatio, 0, kScreenWidth, kScreenHeight);
                }
                
                if (_leftMenuView.frame.origin.x >= 0) {
                    
                    _leftMenuView.frame = CGRectMake(0, 0, kScreenWidth * kDrawerRatio, kScreenHeight);
                }
        
         
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:{
            
            
                CGPoint point = [recongnizer velocityInView:self.view];
            
                if (point.x < -1000) {
            
                    [UIView animateWithDuration:0.2 animations:^{
            
                        _leftMenuView.frame = CGRectMake(-kScreenWidth * kDrawerRatio, 0, kScreenWidth * kDrawerRatio, kScreenHeight);
                        _containerController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            
                    } completion:^(BOOL finished) {
                        _showViewController.view.userInteractionEnabled = YES;
                        [_containerController.view removeGestureRecognizer:_tapGesture];
                        _isFold = NO;
                    }];
                   
                    return;
                }
            
        
            CGFloat currentOffsetX = _leftMenuView.frame.origin.x + kScreenWidth * kDrawerRatio;
          
            if (currentOffsetX < kMaxMovingOffsetX) {
        
                [UIView animateWithDuration:0.2f animations:^{
                    
                    _leftMenuView.frame = CGRectMake(-kScreenWidth * kDrawerRatio, 0, kScreenWidth * kDrawerRatio, kScreenHeight);
                     _containerController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                    
                } completion:^(BOOL finished) {
                    
                    [_containerController.view removeGestureRecognizer:_tapGesture];
                    _showViewController.view.userInteractionEnabled = YES;
                    _isFold = NO;
                }];
                
            }else{//展开了
                
                NSTimeInterval duringTime = 0.4 * currentOffsetX / (kScreenWidth * kDrawerRatio);
                
                [UIView animateWithDuration:duringTime animations:^{
                    
                    _leftMenuView.frame = CGRectMake(0, 0, kScreenWidth * kDrawerRatio, kScreenHeight);
                    _containerController.view.frame = CGRectMake(kScreenWidth * kDrawerRatio, 0, kScreenWidth, kScreenHeight);
                    
                } completion:^(BOOL finished) {
                    
                    [_containerController.view addGestureRecognizer:_tapGesture];
                    _showViewController.view.userInteractionEnabled = NO;
                    _isFold = YES;
                    
                }];
                
            }
       
            
        }
            break;
        default:
            break;
    }


}

#pragma mark - 点击手势
- (void)tapAction:(UITapGestureRecognizer *)recongnizer{

    [self hideDrawerList];
}


#pragma mark - 隐藏抽屉栏
- (void)hideDrawerList{

    [UIView animateWithDuration:0.4f animations:^{
        
        _leftMenuView.frame = CGRectMake(-kScreenWidth * kDrawerRatio, 0, kScreenWidth * kDrawerRatio, kScreenHeight);
        _containerController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
    } completion:^(BOOL finished) {
        
        [_containerController.view removeGestureRecognizer:_tapGesture];
        _showViewController.view.userInteractionEnabled = YES;
        _isFold = NO;
    }];
}

@end
