//
//  StartDayViewController.m
//  PlanAndDo
//
//  Created by Arthur Chistyak on 15.09.16.
//  Copyright © 2016 TodoTeamGroup. All rights reserved.
//

#import "StartDayViewController.h"
#import "KSCheckSettingsTableViewCell.h"
#import "ApplicationManager.h"

@interface StartDayViewController () <UITableViewDelegate, UITableViewDataSource>
@property UserSettings* settings;

@end

@implementation StartDayViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Start day";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.settings = [[[ApplicationManager userApplicationManager] authorisedUser] settings];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"KSCheckSettingsTableViewCell"owner:self options:nil];
    KSCheckSettingsTableViewCell * cell=[nib objectAtIndex:0];
    
    
    switch (indexPath.row) {
        case 0:
            cell.paramNameLabel.text = @"Monday";
            break;
        case 1:
            cell.paramNameLabel.text = @"Sunday";
            break;
        default:
            break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* day = indexPath.row ? @"Sunday" : @"Monday";
    
    UserSettings* updatedSettings = [[UserSettings alloc] initWithID:self.settings.ID andStartPage:self.settings.startPage andDateFormat:self.settings.dateFormat andPageType:self.settings.pageType andTimeFormat:self.settings.timeFormat andStartDay:day andSyncStatus:[[NSDate date] timeIntervalSince1970]];
    
    [[ApplicationManager settingsApplicationManager] updateSettings:updatedSettings];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
