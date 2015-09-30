//
//  SSIndicatorView.h
//  ActivityIndicator
//
//  Created by Scherer Software on 11/09/15.
//  Copyright (c) 2015 Scherer Software. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SSIndicatorView : UIView

- (id)init;
- (id)initWithImage:(UIImage *)img withSpeed:(float)spd withSize:(CGSize)cgsize andColor:(UIColor *)clr andPoint:(CGPoint)point;
- (void)setTextLabelText:(NSString *)text withSize:(CGSize)aSize andWithAnimation:(BOOL)animation;
- (void)beginnAnimation;
- (void)endAnimation;

@end
