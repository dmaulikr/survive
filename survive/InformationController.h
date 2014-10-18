//
//  InformationController.h
//  survive
//
//  Created by 苏智 on 14-10-17.
//  Copyright (c) 2014年 suzic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterViewController.h"

@interface InformationController : UITableViewController<UITabBarControllerDelegate>
{
@public
    CenterViewController* centerController;
}

- (void)switchToAction;

@end
