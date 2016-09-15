//
//  SettingsViewController.m
//  PlanAndDo
//
//  Created by Arthur Chistyak on 13.09.16.
//  Copyright © 2016 TodoTeamGroup. All rights reserved.
//

#import "SettingsViewController.h"
#import "KSSettingsCell.h"
#import "FormatDateViewController.h"
#import "FormatTimeViewController.h"
#import "StartDayViewController.h"
#import "StartPageViewController.h"


@interface SettingsViewController()<UITableViewDelegate, UITableViewDataSource>
@end

@implementation SettingsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"KSSettingsCell"owner:self options:nil];
    KSSettingsCell * cell=[nib objectAtIndex:0];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    
    switch (indexPath.row) {
        case 0:
            cell.paramNameLabel.text = @"Start page";
            break;
        case 1:
            cell.paramNameLabel.text = @"Format date";
            break;
        case 2:
            cell.paramNameLabel.text = @"Format time";
            break;
        case 3:
            cell.paramNameLabel.text = @"Start day";
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
    switch (indexPath.row) {
            
        case 0:
            [self.navigationController pushViewController:[[StartPageViewController alloc] init] animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:[[FormatDateViewController alloc] init] animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:[[FormatTimeViewController alloc] init] animated:YES];
            break;
            
        case 3:
            [self.navigationController pushViewController:[[StartDayViewController alloc] init] animated:YES];
            break;
            
        default:
            break;
    }
}


@end
