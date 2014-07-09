//
//  ViewController.m
//  AjRecord
//
//  Created by anjun on 14-7-9.
//  Copyright (c) 2014年 anjun. All rights reserved.
//

#import "ViewController.h"
#import "Record.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[Record shared]audio];
    [[Record shared]record];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
