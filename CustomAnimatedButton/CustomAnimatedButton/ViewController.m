//
//  ViewController.m
//  CustomAnimatedButton
//
//  Created by Fenly on 2017/7/8.
//  Copyright © 2017年 Cotte. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "CustomTranisition.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *CustomButtons;

/**
 *  <#注释#>
 */
@property (nonatomic, strong) CustomTranisition *customTranisition;

@end

@implementation ViewController

- (CustomTranisition *)customTranisition {
    if (!_customTranisition) {
        _customTranisition = [[CustomTranisition alloc] init];
    }
    return _customTranisition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [self.CustomButtons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.transform = CGAffineTransformMakeScale(0, 0);
    }];
    
    
//    __weak typeof(self)weakSelf = self;
    [self.CustomButtons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self animateWithOption:^{
            obj.transform = CGAffineTransformIdentity;
            
        }
                       complete:nil
                          delay:idx*0.7];
    }];
}

- (void)animateWithOption:(void(^)())option
                 complete:(void(^)(BOOL finished))complete
                    delay:(float)delay {
    [UIView animateWithDuration:0.5
                          delay:delay
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (option) {
                             option();
                         }
                     }
                     completion:^(BOOL finished) {
                         if (complete) {
                             complete(finished);
                         }
                     }];
}

- (IBAction)button1Click:(UIButton *)sender {
    ViewController2 *viewC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"VC2"];
    
    viewC2.transitioningDelegate = self;
    self.customTranisition.sourcePoint = self.CustomButtons[0];
    
    [self presentViewController:viewC2 animated:YES completion:nil];
}

- (IBAction)button2Click:(UIButton *)sender {
    ViewController2 *viewC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"VC2"];
    
    viewC2.transitioningDelegate = self;
    self.customTranisition.sourcePoint = self.CustomButtons[1];
    
    [self presentViewController:viewC2 animated:YES completion:nil];
}

- (IBAction)button3Click:(UIButton *)sender {
    ViewController2 *viewC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"VC2"];
    
    viewC2.transitioningDelegate = self;
    self.customTranisition.sourcePoint = self.CustomButtons[2];
    
    [self presentViewController:viewC2 animated:YES completion:nil];
}

#pragma mark - UIViewControllerTranisitionDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.customTranisition.present = YES;
    return self.customTranisition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.customTranisition.present = NO;
    return self.customTranisition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
