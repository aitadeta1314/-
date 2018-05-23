//
//  CustomTranisition.m
//  CustomAnimatedButton
//
//  Created by Fenly on 2017/7/8.
//  Copyright © 2017年 Cotte. All rights reserved.
//

#import "CustomTranisition.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface CustomTranisition()<CAAnimationDelegate>
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong) UIView *fromViewSnapView;
@end

@implementation CustomTranisition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    UIBezierPath *circleMaskPathInitail = [UIBezierPath bezierPathWithOvalInRect:self.sourcePoint.frame];
    CGRect frameOfWindow = [self.sourcePoint.superview convertRect:self.sourcePoint.frame toView:fromViewController.view];
    CGPoint extremePoint = CGPointMake(CGRectGetWidth(fromViewController.view.bounds) - self.sourcePoint.center.x,
                                       CGRectGetHeight(fromViewController.view.bounds) - self.sourcePoint.center.y);
    CGFloat redius = sqrt(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y);
    UIBezierPath *circleMaskFinial = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.sourcePoint.frame, -redius, -redius)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = circleMaskPathInitail.CGPath;
    shapeLayer.position = CGPointMake(0,
                                      frameOfWindow.origin.y);
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    
    if (self.present) {
        UIView *fromViewSnapView = [fromViewController.view snapshotViewAfterScreenUpdates:YES];
        fromViewSnapView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [containerView addSubview:fromViewSnapView];
        [containerView addSubview:toViewController.view];
        self.fromViewSnapView = fromViewSnapView;
        [toViewController.view.layer addSublayer:shapeLayer];
        toViewController.view.layer.mask = shapeLayer;
        
    } else {
        [fromViewController.view.layer addSublayer:shapeLayer];
        fromViewController.view.layer.mask = shapeLayer;
    }
    
    CABasicAnimation *shapeAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    if (_present) {
        shapeAnimation.fromValue = (__bridge id)circleMaskPathInitail.CGPath;
        shapeAnimation.toValue = (__bridge id)circleMaskFinial.CGPath;
    } else {
        shapeAnimation.toValue = (__bridge id)circleMaskPathInitail.CGPath;
        shapeAnimation.fromValue = (__bridge id)circleMaskFinial.CGPath;
    }
    
    shapeAnimation.duration = [self transitionDuration:transitionContext];
    shapeAnimation.delegate = self;
    
    shapeAnimation.removedOnCompletion = NO;
    shapeAnimation.fillMode = kCAFillModeForwards;
    [shapeLayer addAnimation:shapeAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    if (_present) {
        [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    } else {
        [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
        [self.fromViewSnapView removeFromSuperview];
        self.fromViewSnapView = nil;
        self.transitionContext = nil;
    }
    
}


@end
