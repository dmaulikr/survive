//
//  InformationController.m
//  survive
//
//  Created by 苏智 on 14-10-17.
//  Copyright (c) 2014年 suzic. All rights reserved.
//

#import "InformationController.h"
#import "AppDelegate.h"

@interface InformationController () <UIAlertViewDelegate>

@end

#define AlertPressSubmitTag 2000

@implementation InformationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnCenter:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BackCenter object:nil];
}

- (void)switchToAction
{
    [self performSegueWithIdentifier:@"actionSegue" sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITabBarController* targetController = (UITabBarController*)[segue destinationViewController];
    if ([targetController isKindOfClass:[UITabBarController class]])
    {
        targetController.delegate = self;
    }
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.title isEqualToString:@"TAB-SUBMIT"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"行动完成"
                                                        message:@"请确认已经执行完所有操作；该操作需要网络连接，请确保网络通畅，否则您有可能浪费当前行动机会。"
                                                       delegate:self
                                              cancelButtonTitle:@"我再看看"
                                              otherButtonTitles:@"确认完成！", nil];
        alert.tag = AlertPressSubmitTag;
        alert.delegate = self;
        [alert show];
        
        return NO;
    }
    return YES;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag)
    {
        case AlertPressSubmitTag:
            if (buttonIndex == 1)
            {
                // 这个方法是用来修正iOS7的一个Bug的，对于iOS8来说，即便不修正也不会出错
                if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
                {
                    if (centerController != nil)
                        [centerController fixError];
                }
                
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    if (centerController != nil)
                        [centerController switchOverlayShowCharactor:YES andShowStatics:YES andShowBottomBar:YES completion:nil];
                }];
            }
            break;
        default:
            break;
    }
}


@end
