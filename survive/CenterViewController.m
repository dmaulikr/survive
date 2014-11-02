//
//  CenterViewController.m
//  survive
//
//  Created by 苏智 on 14-10-16.
//  Copyright (c) 2014年 suzic. All rights reserved.
//

#import "CenterViewController.h"
#import "AppDelegate.h"
#import "TalkViewController.h"

#define AlertPressCDTag     1000
#define AlertPressActionTag 1001

@interface CenterViewController () <UIAlertViewDelegate, UIPopoverControllerDelegate>
{
    NSTimer *timer;
    double during;
    double interval;
    int ticker;
}

@property (assign, nonatomic) InformationController* informationController;
@property (strong, nonatomic) UIPopoverController* talkPopoverController;
@property (strong, nonatomic) UIView* talkOverlayerView;
@property (strong, nonatomic) TalkViewController* talkViewController;

@end

@implementation CenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 增加对话泡相关UI
    self.talkOverlayerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 1024)];
    [self.talkOverlayerView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    self.talkViewController = [[TalkViewController alloc] initWithNibName:@"TalkViewController" bundle:nil];
    [self.talkOverlayerView addSubview:self.talkViewController.view];
    [self.view addSubview:self.talkOverlayerView];
    [self.talkOverlayerView setHidden:YES];
    
    // 注册返回消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToCenter:) name:BackCenter object:nil];

    // 增加对时间标签的点击响应
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressCD:)];
    [self.wating addGestureRecognizer:tapGesture];

    // 设置时间标签计时器
    during = 30.0;
    interval = 1.00;
    ticker = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];

    // 对界面叠加层设置初始的动画转换计算
    self.charactorZone.transform = CGAffineTransformMakeTranslation(0, 0);
    self.staticsZone.transform = CGAffineTransformMakeTranslation(0, 0);
    self.bottomZone.transform = CGAffineTransformMakeTranslation(0, 0);
    self.avator.transform = CGAffineTransformMakeTranslation(0, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)intoDetail:(id)sender
{
    [self switchOverlayShowCharactor:NO andShowStatics:NO andShowBottomBar:YES completion:nil];
}

- (IBAction)intoAction:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"行动启用"
                                                    message:@"行动一旦启用，无论最终你是否提交行动结果还是中途放弃操作，这一次机会都将被消耗，请确认启用行动。"
                                                   delegate:self
                                          cancelButtonTitle:@"容我考虑"
                                          otherButtonTitles:@"好的！", nil];
    alert.tag = AlertPressActionTag;
    alert.delegate = self;
    [alert show];
}

- (IBAction)avatorTalk:(id)sender
{
    return;
    UIButton* avator = (UIButton*)sender;
    TalkViewController* talkViewController = [[TalkViewController alloc] initWithNibName:@"TalkViewController" bundle:nil];
    self.talkPopoverController = [[UIPopoverController alloc] initWithContentViewController:talkViewController];
    [self.talkPopoverController presentPopoverFromRect:avator.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionRight
                                              animated:YES];
}

- (void)pressCD:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"行动冷却尚未结束"
                                                    message:@"您要使用兴奋剂立刻获得一次行动机会吗？注意，您的行动机会最多只会有一次。"
                                                   delegate:self
                                          cancelButtonTitle:@"还是算了"
                                          otherButtonTitles:@"现在就要！", nil];
    alert.tag = AlertPressCDTag;
    alert.delegate = self;
    [alert show];
}

- (void)backToCenter:(NSNotification *)notification
{
    [self switchOverlayShowCharactor:YES andShowStatics:YES andShowBottomBar:YES completion:nil];
}

- (void)fixError
{
    // 这个方法是用来修正iOS7的一个Bug的，对于iOS8来说，即便不修正也不会出错
    self.charactorZone.transform = CGAffineTransformIdentity;
    self.staticsZone.transform = CGAffineTransformIdentity;
    self.bottomZone.transform = CGAffineTransformIdentity;
    self.avator.transform = CGAffineTransformIdentity;

    [self.charactorZone setFrame:CGRectMake(0, -220, self.charactorZone.frame.size.width, self.charactorZone.frame.size.height)];
    [self.staticsZone setFrame:CGRectMake(0, -360, self.staticsZone.frame.size.width, self.staticsZone.frame.size.height)];
    [self.bottomZone setFrame:CGRectMake(0, self.view.frame.size.height, self.bottomZone.frame.size.width, self.bottomZone.frame.size.height)];
    [self.avator setFrame:CGRectMake(0, -220, self.avator.frame.size.width, self.avator.frame.size.height)];
}

- (void)switchOverlayShowCharactor:(bool)showCharactor andShowStatics:(bool)showStatic andShowBottomBar:(bool)showBottom
                        completion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:0.4 animations:^{
        self.charactorZone.transform = CGAffineTransformMakeTranslation(0, showCharactor ? 0 : -220);
        self.staticsZone.transform = CGAffineTransformMakeTranslation(0, showStatic ? 0 : -360);
        self.bottomZone.transform = CGAffineTransformMakeTranslation(0, showBottom ? 0 : 30);
        self.avator.transform = CGAffineTransformMakeTranslation(0, showCharactor ? 0 : -220);
    } completion:^(BOOL finished) {
        if (completion != nil)
            completion(finished);
    }];
}

- (void)timerHandler
{
    NSDate* now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    // int year = [dateComponent year];
    // int month = [dateComponent month];
    // int day = [dateComponent day];
    // int hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    NSInteger countMin = 59 - minute;
    NSInteger countSec = 59 - second;
    [self.wating setText:[NSString stringWithFormat:@"CD - %02ld:%02ld", (long)countMin, (long)countSec]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"embedInfo"])
    {
        UINavigationController* nav = (UINavigationController*)[segue destinationViewController];
        self.informationController = (InformationController*)[nav topViewController];
        self.informationController->centerController = self;
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag)
    {
        case AlertPressCDTag:
            if (buttonIndex == 1)
            {
                self.wating.hidden = YES;
                self.action.hidden = NO;
            }
            break;
        case AlertPressActionTag:
            if (buttonIndex == 1)
            {
                self.wating.hidden = NO;
                self.action.hidden = YES;
                
                [self switchOverlayShowCharactor:NO andShowStatics:NO andShowBottomBar:NO completion:^(BOOL finished) {
                    if (self.informationController != nil)
                        [self.informationController switchToAction];
                }];
            }
        default:
            break;
    }
}

@end
