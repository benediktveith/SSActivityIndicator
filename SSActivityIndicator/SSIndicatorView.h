//
//  SSIndicatorView.h
//  ActivityIndicator
//
//  Created by Benedikt Veith on 11/09/15.
//  Copyright (c) 2015 Benedikt Veith. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SSIndicatorView : UIView

- (id)init;
- (id)initWithImage:(UIImage *)img withSpeed:(float)spd withSize:(CGSize)cgsize andColor:(UIColor *)clr;
- (void)beginnAnimation;
- (void)endAnimation;

@end
