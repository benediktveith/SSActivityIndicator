//
//  ViewController.h
//  ActivityIndicator
//
//  Created by Scherer Software on 11/09/15.
//  Copyright (c) 2015 Scherer Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSIndicatorView.h"

@interface ViewController : UIViewController

- (IBAction)buttonPressed:(UIButton *)sender;
- (IBAction)button2Pressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet SSIndicatorView *ibdesignableIndicator;

@end

