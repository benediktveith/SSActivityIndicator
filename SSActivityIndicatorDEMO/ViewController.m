//
//  ViewController.m
//  ActivityIndicator
//
//  Created by Benedikt Veith on 11/09/15.
//  Copyright (c) 2015 Benedikt Veith. All rights reserved.
//

#import "ViewController.h"
#import "SSIndicatorView.h"

IB_DESIGNABLE
@interface ViewController ()

//@property SSIndicatorView *indV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
// Init from Code
//    _indV = [[SSIndicatorView alloc] initWithImage:[UIImage imageNamed:@"indicator"] withSpeed:0.5f withSize:CGSizeMake(50, 50) andColor:[UIColor greenColor]];
//    [self.view addSubview:_indV];
//    [_indV startAnimation];
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
