//
//  ViewController.m
//  ActivityIndicator
//
//  Created by Scherer Software on 11/09/15.
//  Copyright (c) 2015 Scherer Software. All rights reserved.
//

#import "ViewController.h"
#import "SSIndicatorView.h"

IB_DESIGNABLE
@interface ViewController ()

@property SSIndicatorView *indV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
// Init from Code
    _indV = [[SSIndicatorView alloc] initWithImage:[UIImage imageNamed:@"indicator"] withSpeed:0.5f withSize:CGSizeMake(50, 50) andColor:[UIColor greenColor] andPoint:CGPointMake(50, 50)];
    [_indV setTextLabelText:@"Loading..." withSize:CGSizeMake(200, 50) andWithAnimation:YES];
    [self.view addSubview:_indV];
    [_indV beginnAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonPressed:(UIButton *)sender {
    [_ibdesignableIndicator endAnimation];
}

- (IBAction)button2Pressed:(UIButton *)sender {
    [_ibdesignableIndicator beginnAnimation];
}

@end
