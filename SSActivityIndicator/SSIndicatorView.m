//
//  SSIndicatorView.m
//  ActivityIndicator
//
//  Created by Benedikt Veith on 11/09/15.
//  Copyright (c) 2015 Benedikt Veith. All rights reserved.
//

#import "SSIndicatorView.h"

@interface SSIndicatorView()

@property UIImageView *activityIndicatorView;

@property UILabel *indicatorLabel;
@property IBInspectable NSString *labelText;
@property IBInspectable CGSize size;
@property IBInspectable float speed;
@property IBInspectable UIColor *color;
@property IBInspectable UIImage *actImage;

@property BOOL wasStarted;

// Set to NO before runtime
@property IBInspectable BOOL playing;

@property UIView *allViews;

@end


@implementation SSIndicatorView

#pragma mark - Setups

// Init without the IBDesignable;
- (id)initWithImage:(UIImage *)img withSpeed:(float)spd withSize:(CGSize)cgsize andColor:(UIColor *)clr andPoint:(CGPoint)point{
    self = [super init];
    
    if (self) {
        _size = cgsize;
        _speed = spd;
        _actImage = img;
        _color = clr;
        _playing = NO;
        _wasStarted = NO;
        [self setFrame:CGRectMake(point.x, point.y, 0, 0)];
    }
    
    return self;
}

// Init for IBDesignable; Sets defaults;
- (id)init {
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    _size = CGSizeMake(50, 50);
    _speed = 0.5f;
    _color = [UIColor greenColor];
    _wasStarted = NO;
    _playing = NO;
    _actImage = [UIImage imageNamed:@"indicator"];
}


#pragma mark - Draw Activity Indicator

- (void)drawRect:(CGRect)rect {
    // If not started yet start Animation
    if (! _wasStarted) {
        [self scaleOutAnimation];
        _wasStarted = YES;
    }
    
    if (! _playing) {
        return;
    }
    
    // Init allViews
    _allViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    // Recolor and Resize Image
    _actImage = [self colorImage:_actImage];
    _actImage = [self resizeImage:_actImage];
    
    // Center Activity Indicator View
    _activityIndicatorView = [[UIImageView alloc] initWithImage:_actImage];
    _activityIndicatorView.center = CGPointMake(self.frame.size.width / 2,
                                                _activityIndicatorView.frame.size.height / 2);
    
    // Setup + Center Indicator Label
    _indicatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    _indicatorLabel.center = CGPointMake(_activityIndicatorView.center.x,
                                         _activityIndicatorView.frame.size.height + _indicatorLabel.frame.size.height / 2);
    _indicatorLabel.text = _labelText;
    _indicatorLabel.textAlignment = NSTextAlignmentCenter;
    
    // Rotate Activity Indicator
    [self rotateActivityIndicatorImage:_activityIndicatorView.layer];
    
    // Add Views together
    [_allViews addSubview:_activityIndicatorView];
    [_allViews addSubview:_indicatorLabel];

    // Add all Views
    [self addSubview:_allViews];
}

#pragma mark - Animations

- (void)endAnimation {
    [UIView animateWithDuration:1 delay:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }                 completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        _playing = NO;
        [_allViews removeFromSuperview];
    }];
}

- (void)beginnAnimation {
    [_allViews removeFromSuperview];
    
    _playing = YES;
    _wasStarted = NO;
    [self drawRect:CGRectZero];
}

- (void)scaleOutAnimation {
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:1 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformIdentity;
    }
                     completion:nil];
}

#pragma mark - Image Methods

- (UIImage *)colorImage:(UIImage *)img {

    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_color setFill];
    
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context, kCGPathFill);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *)resizeImage:(UIImage *)img {
    
    UIGraphicsBeginImageContextWithOptions(_size, NO, 0.0);
    [img drawInRect:CGRectMake(0, 0, _size.width, _size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)rotateActivityIndicatorImage:(CALayer *)layer {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    rotation.duration = _speed;
    rotation.repeatCount = HUGE_VALF;
    
    [layer removeAllAnimations];
    [layer addAnimation:rotation forKey:@"Spin"];
}

@end
