//
//  MViewController.m
//  TestSlideView
//
//  Created by lieyunye on 8/30/13.
//  Copyright (c) 2013 lieyunye. All rights reserved.
//

#import "MViewController.h"

@interface MViewController ()

@end

@implementation MViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
	// Do any additional setup after loading the view.
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 100, 10, 100);
//    btn.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:btn];
//
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn1.frame = CGRectMake(0, btn.frame.origin.y + btn.frame.size.height, 10, 100);
//    btn1.backgroundColor = [UIColor redColor];
//    [btn1 addTarget:self action:@selector(moveItem:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn1];

}

- (void) moveItem:(UIButton *)btn
{
    x += 20;
//    btn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, x, 0);
//    if (btn.transform.tx > 100) {
//        x = 0;
//        btn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
//    }
    if (btn.transform.tx > 100) {
        btn.transform = CGAffineTransformMakeTranslation(0, 0);
        x = 0;
        return;
    }
    btn.transform = CGAffineTransformMakeTranslation(x, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
