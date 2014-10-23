//
//  CenterViewController.h
//  survive
//
//  Created by 苏智 on 14-10-16.
//  Copyright (c) 2014年 suzic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *container;

@property (strong, nonatomic) IBOutlet UIView *charactorZone;
@property (strong, nonatomic) IBOutlet UIView *staticsZone;
@property (strong, nonatomic) IBOutlet UIView *bottomZone;
@property (strong, nonatomic) IBOutlet UIButton *avator;

@property (strong, nonatomic) IBOutlet UIImageView *heartScaleView;
@property (strong, nonatomic) IBOutlet UILabel *daysValue;
@property (strong, nonatomic) IBOutlet UIButton *playerAvatar;

@property (strong, nonatomic) IBOutlet UITableView *majorInfo;

@property (strong, nonatomic) IBOutlet UIButton *stay;
@property (strong, nonatomic) IBOutlet UIButton *action;
@property (strong, nonatomic) IBOutlet UILabel *wating;

- (void)fixError;

- (void)switchOverlayShowCharactor:(bool)showCharactor andShowStatics:(bool)showStatic andShowBottomBar:(bool)showBottom
                        completion:(void (^)(BOOL finished))completion;

@end
