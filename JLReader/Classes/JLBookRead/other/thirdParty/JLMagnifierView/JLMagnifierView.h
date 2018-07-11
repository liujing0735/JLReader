//
//  JLMagnifierView.h
//  UIMenuController
//
//  Created by JasonLiu on 2018/07/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLMagnifierView : UIWindow

/// 目标视图 (注意: 传视图的Window 例子: self.view.window)
@property (nonatomic, weak, nullable) UIView *targetWindow;

/// 目标视图展示位置 (放大镜需要展示的位置)
@property (nonatomic, assign) CGPoint targetPoint;

/// 放大镜位置调整 (调整放大镜在原始位置上的偏移 Defalut: CGPointMake(0, 0))
@property (nonatomic, assign) CGPoint adjustPoint;

/// 放大比例 Defalut: 1.8
@property (nonatomic, assign) CGFloat scale;

/// 弱引用接收对象 (内部已经强引用,如果外部也强引用需要自己释放)
+ (nonnull instancetype)magnifierView;

/// 移除 (移除对象 并释放内部强引用)
- (void)remove:(nullable void (^)(void))complete;

@end
