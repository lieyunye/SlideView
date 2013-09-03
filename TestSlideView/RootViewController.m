//
//  RootViewController.m
//  TestSlideView
//
//  Created by lieyunye on 8/30/13.
//  Copyright (c) 2013 lieyunye. All rights reserved.
//

#import "RootViewController.h"
#import "LViewController.h"
#import "RViewController.h"
#import "MViewController.h"
#import "CNavViewController.h"

#define KEY_WINDOW  [[UIApplication sharedApplication] keyWindow]

@interface RootViewController ()<UIGestureRecognizerDelegate>
{
    LViewController *lvc;
    MViewController *mvc;
    RViewController *rvc;
    CNavViewController *nav;
    UITapGestureRecognizer *_tapGestureRecognizer;
    UIPanGestureRecognizer *_panGestureReconginzer;
    
    BOOL isLeftSide;
    BOOL isRightSide;
}
@end

@implementation RootViewController

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
    self.view.backgroundColor = [UIColor orangeColor];
    
	// Do any additional setup after loading the view.
    lvc = [[LViewController alloc] init];
    rvc = [[RViewController alloc] init];
    mvc = [[MViewController alloc] init];
    
    nav = [[CNavViewController alloc] initWithRootViewController:mvc];
    UIButton *leftSideButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [leftSideButton addTarget:self action:@selector(showLeftSide) forControlEvents:UIControlEventTouchUpInside];
    mvc.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftSideButton] autorelease];
    
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightSideButton addTarget:self action:@selector(showRightSide) forControlEvents:UIControlEventTouchUpInside];
    mvc.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightSideButton] autorelease];
    
    lvc.view.frame = CGRectMake(0, -20, KEY_WINDOW.frame.size.width, KEY_WINDOW.frame.size.height);
    rvc.view.frame = CGRectMake(0, -20, KEY_WINDOW.frame.size.width, KEY_WINDOW.frame.size.height);
    nav.view.frame = CGRectMake(0, -20, KEY_WINDOW.frame.size.width, KEY_WINDOW.frame.size.height);
    
    [self.view addSubview:lvc.view];
    [self.view addSubview:rvc.view];
    [self.view addSubview:nav.view];
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnContentView:)];
    [_tapGestureRecognizer setCancelsTouchesInView:NO];
    
    _panGestureReconginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)];
    _panGestureReconginzer.delegate = self;
    [mvc.view addGestureRecognizer:_panGestureReconginzer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showLeftSide
{
    if (isLeftSide) {
        [self moveViewanimation:0];
    }else {
        [self setLeftSide];
        [self moveViewanimation:275];
    }
}

- (void) setLeftSide
{
    isLeftSide = YES;
    isRightSide = NO;
    [self.view insertSubview:lvc.view aboveSubview:rvc.view];
}

- (void) showRightSide
{
    if (isRightSide) {
        [self moveViewanimation:0];
    }else {
        [self setRightSide];
        [self moveViewanimation:-275];
    }
}

- (void) setRightSide
{
    isLeftSide = NO;
    isRightSide = YES;
    [self.view insertSubview:rvc.view aboveSubview:lvc.view];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    return YES;
}

- (void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self moveViewanimation:0];
}

- (void) moveViewanimation:(int) tx
{
    void (^animations)(void) = ^{
        nav.view.transform = CGAffineTransformMakeTranslation(tx, 0);
    };
    void (^complete)(BOOL) = ^(BOOL finished){
        if (abs(tx) == 275) {
            [mvc.view addGestureRecognizer:_tapGestureRecognizer];
            [mvc.view removeGestureRecognizer:_panGestureReconginzer];
        }
        if (tx == 0) {
            [mvc.view removeGestureRecognizer:_tapGestureRecognizer];
            [mvc.view addGestureRecognizer:_panGestureReconginzer];
            isLeftSide = NO;
            isRightSide = NO;
        }
    };
    [UIView animateWithDuration:0.3 animations:animations completion:complete];
}

- (void) panInContentView:(UIPanGestureRecognizer *)panGestureReconginzer
{
    CGPoint translation = [panGestureReconginzer translationInView:KEY_WINDOW];
    CGFloat xOffSet = translation.x;
    switch (panGestureReconginzer.state) {
        case UIGestureRecognizerStateBegan:
            if (xOffSet >= 0) {
                [self setLeftSide];
            }
            if (xOffSet < 0) {
                [self setRightSide];
            }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (isRightSide && xOffSet >= 0) {
                [self setLeftSide];
            }
            if (isLeftSide && xOffSet < 0) {
                [self setRightSide];
            }
            nav.view.transform = CGAffineTransformMakeTranslation(xOffSet, 0);
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
            if (isLeftSide) {
                if (xOffSet >= 100) {
                    [self moveViewanimation:275];
                }else {
                    [self moveViewanimation:0];
                }
            }
            if (isRightSide) {
                if (xOffSet <= -100) {
                    [self moveViewanimation:-275];
                }else {
                    [self moveViewanimation:0];
                }
            }
            
            break;
        default:
            break;
    }    
}

@end
