//
//  ViewController.m
//  MSTransitionView
//
//  Created by mrscorpion on 16/7/4.
//  Copyright © 2016年 mrscorpion. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "CEBaseInteractionController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
{
    IBOutlet UIImageView *iImage;
    IBOutlet UISegmentedControl *segmc;
    float numGrid;
}
@end

@implementation ViewController

- (void)explodeView:(UIView*)eView style:(int)style
{
    [segmc setEnabled:NO];
    CGSize size = eView.frame.size;
    NSMutableArray *snapshots = [NSMutableArray new];
    UIView *snapshotView = [eView snapshotViewAfterScreenUpdates:YES];
    
    float numCols = numGrid;
    float numRows = numCols * size.height/size.width;
    float ssWidth = size.width/numCols;
    float ssHeight = size.height/numRows;
    for (int row=0; row<numRows; row++) {
        for (int col=0; col<numCols; col++) {
            float offset = 0;
            if (row%2==1) {
                offset = -ssWidth/2;
            }
            CGRect ssSize = CGRectMake((col*ssWidth)+offset,row*ssHeight,ssWidth,ssHeight);
            
            UIView *ss =[snapshotView resizableSnapshotViewFromRect:ssSize
                                                 afterScreenUpdates:NO
                                                      withCapInsets:UIEdgeInsetsZero];
            ss.frame = ssSize;
            [self.view addSubview:ss];;
            [snapshots addObject:ss];
        }
    }
    
    
    //animation
    [UIView animateWithDuration:2
                     animations:^{
                         iImage.alpha = 0;
                         
                         for (UIView *view in snapshots) {
                             if (style==1) {
                                 CGFloat xOffset = [self randomFloatBetween:-100 and:100];
                                 CGFloat yOffset = [self randomFloatBetween:-100 and:100];
                                 
                                 view.frame = CGRectOffset(view.frame, xOffset, yOffset);
                                 view.alpha = 0.0;
                                 view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation([self randomFloatBetween:-10.0 and:10.0]),0.0,0.0);
                             }else{
                                 view.alpha = 0.0;
                                 view.transform = CGAffineTransformMakeScale(-1, 1);
                             }
                         }
                     }
                     completion:^(BOOL finished){
                         for (UIView *view in snapshots) {
                             [view removeFromSuperview];
                         }
                         
                         iImage.alpha = 1;
                         
                         [segmc setEnabled:YES];
                     }];
    
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}
- (IBAction)startExplode:(UISegmentedControl*)sender {
    [self explodeView:iImage style:(int)sender.selectedSegmentIndex];
    
}
- (IBAction)changeNumGrid:(UISlider *)sender {
    numGrid = sender.value;
}



//#pragma mark - UIViewControllerTransitioningDelegate
//
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    
//    if (AppDelegateAccessor.settingsInteractionController) {
//        [AppDelegateAccessor.settingsInteractionController wireToViewController:presented forOperation:CEInteractionOperationDismiss];
//    }
//    
//    AppDelegateAccessor.settingsAnimationController.reverse = NO;
//    return AppDelegateAccessor.settingsAnimationController;
//}
//
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    AppDelegateAccessor.settingsAnimationController.reverse = YES;
//    return AppDelegateAccessor.settingsAnimationController;
//}
//
//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
//    return AppDelegateAccessor.settingsInteractionController && AppDelegateAccessor.settingsInteractionController.interactionInProgress ? AppDelegateAccessor.settingsInteractionController : nil;
//}
@end
