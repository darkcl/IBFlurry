//
//  FKViewController.m
//  IBFlurry
//
//  Created by Yeung Yiu Hung on 04/18/2016.
//  Copyright (c) 2016 Yeung Yiu Hung. All rights reserved.
//

#import "FKViewController.h"

@interface FKViewController ()

@end

@implementation FKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    NSLog(@"Button Pressed");
    
    UIButton *aButton = (UIButton *)sender;
    aButton.flurryParam = @{@"testing": @"param"};
}

@end
