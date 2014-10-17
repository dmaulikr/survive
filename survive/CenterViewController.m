//
//  CenterViewController.m
//  survive
//
//  Created by 苏智 on 14-10-16.
//  Copyright (c) 2014年 suzic. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()
{
    NSTimer *timer;
    double during;
    double interval;
    int ticker;
}

@end

@implementation CenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    during = 30.0;
    interval = 1.00;
    ticker = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)intoDetail:(id)sender
{
    [self performSegueWithIdentifier:@"goDetail" sender:sender];
}

- (IBAction)avatorTalk:(id)sender
{
}

- (void)timerHandler
{
    NSDate* now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    //    int year = [dateComponent year];
    //    int month = [dateComponent month];
    //    int day = [dateComponent day];
    //    int hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    NSInteger countMin = 59 - minute;
    NSInteger countSec = 59 - second;
    self.wating.titleLabel.text = [NSString stringWithFormat:@"CD - %02ld:%02ld", countMin, (long)countSec];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITabBarController* targetController = (UITabBarController*)[segue destinationViewController];
    if ([targetController isKindOfClass:[UITabBarController class]])
    {
        targetController.delegate = self;
        UIButton* org = (UIButton*)sender;
        UITabBarItem* item = (UITabBarItem*)[targetController.tabBar.items lastObject];
        if (org == self.stay)
        {
            item.title = @"BACK";
        }
        else if (org == self.action)
        {
            item.title = @"SUBMIT";
        }
    }
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.title isEqualToString:@"TAB-SUBMIT"])
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        // [self.navigationController popToRootViewControllerAnimated:YES];
        return NO;
    }
    return YES;
}

@end
