//
//  CenterViewController.h
//  survive
//
//  Created by 苏智 on 14-10-16.
//  Copyright (c) 2014年 suzic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterViewController : UIViewController<UITabBarControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *heartScaleView;
@property (strong, nonatomic) IBOutlet UIButton *playerAvatar;
@property (strong, nonatomic) IBOutlet UITableView *majorInfo;
@property (strong, nonatomic) IBOutlet UIButton *stay;
@property (strong, nonatomic) IBOutlet UIButton *action;
@property (strong, nonatomic) IBOutlet UIButton *wating;

@end
