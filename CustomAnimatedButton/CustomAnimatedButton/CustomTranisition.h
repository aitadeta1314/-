//
//  CustomTranisition.h
//  CustomAnimatedButton
//
//  Created by Fenly on 2017/7/8.
//  Copyright © 2017年 Cotte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomTranisition : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  <#注释#>
 */
@property (nonatomic, strong) UIButton *sourcePoint;

/**
 * <#注释#>
 */
@property (nonatomic, assign) BOOL present;

@end
