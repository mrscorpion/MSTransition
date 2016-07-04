//
//  AppDelegate.h
//  MSTransitionView
//
//  Created by mrscorpion on 16/7/4.
//  Copyright © 2016年 mrscorpion. All rights reserved.
//

#import <UIKit/UIKit.h>
#define AppDelegateAccessor ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@class CEReversibleAnimationController, CEBaseInteractionController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CEBaseInteractionController *navigationControllerInteractionController;
@property (strong, nonatomic) CEBaseInteractionController *settingsInteractionController;

@end

