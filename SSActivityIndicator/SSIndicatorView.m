//
//  SSIndicatorView.m
//  ActivityIndicator
//
//  Created by Scherer Software on 11/09/15.
//  Copyright (c) 2015 Scherer Software. All rights reserved.
//

#import "SSIndicatorView.h"

@interface SSIndicatorView()

@property UIImageView *activityIndicatorView;

@property UILabel *indicatorLabel;
@property IBInspectable NSString *labelText;
@property IBInspectable CGSize textLabelSize;
@property IBInspectable BOOL textLabelAnimation;


@property IBInspectable CGSize size;
@property IBInspectable float speed;
@property IBInspectable UIColor *color;
@property IBInspectable UIImage *actImage;
@property BOOL wasStarted;
// Set to NO before runtime
@property IBInspectable BOOL showing;
@property BOOL endedAnimations;

@property UIView *allViews;

@end


@implementation SSIndicatorView

#pragma mark - Setups

// Init without the IBDesignable
- (id)initWithImage:(UIImage *)img withSpeed:(float)spd withSize:(CGSize)cgsize andColor:(UIColor *)clr andPoint:(CGPoint)point{
    self = [super init];
    
    if (self) {
        _size = cgsize;
        _speed = spd;
        _actImage = img;
        _color = clr;
        _showing = NO;
        _wasStarted = NO;
        [self setFrame:CGRectMake(point.x, point.y, 0, 0)];
    }
    
    return self;
}

// Init for IBDesignable; Sets defaults
- (id)init {
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

// Sets defaults
- (void)setup {
    _size = CGSizeMake(50, 50);
    _speed = 0.5f;
    _color = [UIColor greenColor];
    _wasStarted = NO;
    _showing = NO;
    _actImage = [UIImage imageNamed:@"indicator"];
}

// Set Text before calling 'beginnAnimation'
- (void)setTextLabelText:(NSString *)text withSize:(CGSize)aSize andWithAnimation:(BOOL)animation {
    _textLabelSize = aSize;
    _labelText = text;
    _textLabelAnimation = animation;
}

#pragma mark - Draw Activity Indicator

- (void)drawRect:(CGRect)rect {
    // If not started yet start Animation
    if (! _wasStarted) {
        [self scaleOutAnimation];
        _wasStarted = YES;
        _endedAnimations = NO;
    }
    
    if (! _showing) {
        return;
    }
    
    // Init allViews
    _allViews = [[UIView alloc] initWithFrame:CGRectZero];
    
    // Recolor and Resize Image
    _actImage = [self colorImage:_actImage];
    _actImage = [self resizeImage:_actImage];
    
    // Center Activity Indicator View
    _activityIndicatorView = [[UIImageView alloc] initWithImage:_actImage];
    _activityIndicatorView.center = CGPointMake(self.frame.size.width / 2,
                                                _activityIndicatorView.frame.size.height / 2);
    
    // Setup + Center Indicator Label
    _indicatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _textLabelSize.width, _textLabelSize.height)];
    _indicatorLabel.center = CGPointMake(_activityIndicatorView.center.x,
                                         _activityIndicatorView.frame.size.height + _indicatorLabel.frame.size.height / 2);
    _indicatorLabel.text = _labelText;
    _indicatorLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //Determine whete _indicatorLabel has or has not an animation
    if (_textLabelAnimation) {
        [self startTextLabelAnimation];
    }
    
    // Rotate Activity Indicator
    [self rotateActivityIndicatorImage:_activityIndicatorView.layer];
    
    // Add Views together
    [_allViews addSubview:_activityIndicatorView];
    [_allViews addSubview:_indicatorLabel];

    // Add all Views
    [self addSubview:_allViews];
}

#pragma mark - Activity Indicator animations

- (void)endAnimation {
    if (! _showing) {
        return;
    }
    
    [UIView animateWithDuration:1 delay:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }                 completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        _showing = NO;
        _endedAnimations = YES;
        [_allViews.layer removeAllAnimations];
        [_allViews removeFromSuperview];
    }];
}

- (void)beginnAnimation {
    if (_showing) {
        return;
    }
    
    _showing = YES;
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

- (void)rotateActivityIndicatorImage:(CALayer *)layer {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    rotation.duration = _speed;
    rotation.repeatCount = HUGE_VALF;
    
    [layer removeAllAnimations];
    [layer addAnimation:rotation forKey:@"Spin"];
}

#pragma mark - TextLabel Animations

- (void)startTextLabelAnimation {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:_labelText forKey:@"text"];
    [userInfo setObject:@0 forKey:@"count"];
    
    if (_endedAnimations) {
        return;
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.12
                                                      target:self
                                                    selector:@selector(animateTextLabel:)
                                                    userInfo:userInfo
                                                     repeats:YES];
    [timer fire];
}

- (void)animateTextLabel:(NSTimer *)timer {
    
    if (_endedAnimations) {
        [timer invalidate];
        timer = nil;
        return;
    }
    
    NSString *text = [timer.userInfo objectForKey:@"text"];
    int count = [[timer.userInfo objectForKey:@"count"] intValue];
    count++;
    [timer.userInfo setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    
    if (count > text.length - 1) {
        [timer invalidate];
        timer = nil;
        
        if (! _showing) {
            return;
        }
        
        [self startTextLabelAnimation];
    }
    
    _indicatorLabel.text = [text substringToIndex:count];
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

@end
