//
//  KSMenuViewController.m
//  PlanAndDo
//
//  Created by Амин on 17.09.16.
//  Copyright © 2016 TodoTeamGroup. All rights reserved.
//

#import "KSMenuViewController.h"
#import "AMSideBarViewController.h"
#import "TaskTableViewCell.h"
#import "AddTaskViewController.h"
#import "SettingsViewController.h"
#import "EditTaskViewController.h"
#import "TabletasksViewController.h"
#import "ApplicationManager.h"

@interface KSMenuViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (nonatomic)NSMutableArray<KSCategory *> * categories;
@property (nonatomic)UISearchBar * searchBar;
@property (nonatomic)UITextField * addCategoryTextField;
@property (nonatomic)UIView * addCategoryAccessoryView;
@property (nonatomic)AMSideBarViewController * parentController;
@property (nonatomic)UILongPressGestureRecognizer * longPress;
@end

@implementation KSMenuViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result;
    if(self.state==KSMenuStateNormal)
    {
        if(section==0)
        {
            result = 0;
        }
        else if(section==1)
        {
            result = self.categories.count;
        }
        else
        {
            result = 2;
        }
    }
    else
    {
        result = 3;
    }
    return result;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger result;
    if(self.state==KSMenuStateNormal)
    {
        result=3;
    }
    else
    {
        result=1;
    }
    return result;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==1 && self.state==KSMenuStateNormal)
    {
        return @"Categories";
    }
    return nil;
}

-(void)addCategoryDidTap
{
    self.parentController.hiden=YES;
    self.searchBar.frame=CGRectMake(self.searchBar.frame.origin.x, self.searchBar.frame.origin.y, [UIScreen mainScreen].bounds.size.width-self.searchBar.frame.origin.x*2, self.searchBar.frame.size.height);
    //[text setInputAccessoryView:self.addCategoryAccessoryView];
    [self.addCategoryTextField becomeFirstResponder];
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==1 && self.state==KSMenuStateNormal)
    {
        UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
        view.backgroundColor=[UIColor colorWithRed:32.0/255.0 green:45.0/255.0 blue:52.0/255.0 alpha:1.0];
        
        UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
        imageView.image=[UIImage imageNamed:@"Category"];
        
        UILabel * titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 100, 30)];
        titleLabel.textColor=[UIColor colorWithRed:163.0/255.0 green:167.0/255.0 blue:169.0/255.0 alpha:0.35];
        titleLabel.text=@"CATEGORY";
        titleLabel.font=[UIFont systemFontOfSize:12];
        
        UIButton * addCategoryButton=[[UIButton alloc] initWithFrame:CGRectMake(233, 0, 30, 30)];
        [addCategoryButton setImage:[UIImage imageNamed:@"Add category"] forState:UIControlStateNormal];
        [addCategoryButton addTarget:self action:@selector(addCategoryDidTap) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:addCategoryButton];
        [view addSubview:titleLabel];
        [view addSubview:imageView];
        return view;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor=[UIColor colorWithRed:32.0/255.0 green:45.0/255.0 blue:52.0/255.0 alpha:1.0];
    cell.textLabel.textColor=[UIColor whiteColor];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:57.0/255.0 green:75.0/255.0 blue:86.0/255.0 alpha:1.0];
    [cell setSelectedBackgroundView:bgColorView];
    
    
//    if(indexPath.row==0 && indexPath.section==0)
//    {
//        [cell addSubview:self.searchBar];
//    }
    
    if(self.state==KSMenuStateSearch)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"KSTaskCell"owner:self options:nil];
        TaskTableViewCell * customCell=nib[0];
        customCell.backgroundColor=[UIColor colorWithRed:32.0/255.0 green:45.0/255.0 blue:52.0/255.0 alpha:1.0];
        customCell.taskTimeLabel.backgroundColor=[UIColor colorWithRed:32.0/255.0 green:45.0/255.0 blue:52.0/255.0 alpha:1.0];
        
        customCell.taskTimeLabel.textColor=[UIColor whiteColor];
        customCell.taskDateLabel.textColor=[UIColor whiteColor];
        customCell.taskHeaderLabel.textColor=[UIColor whiteColor];
        customCell.taskPriorityLabel.textColor=[UIColor redColor];
        customCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        [customCell setSelectedBackgroundView:bgColorView];
        return customCell;
    }
    else
    {
        
    if(indexPath.row<=self.categories.count && indexPath.section==1)
    {
        UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(55, 8, 100, 30)];
        label.textColor=[UIColor whiteColor];
        label.text=[self.categories[indexPath.row] name];
        [cell addSubview:label];
        if(indexPath.row==self.categories.count-1)
        {
            cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
        }
    }
    else if(indexPath.section==2)
    {
        if(indexPath.row==0)
        {
            UIImageView * profileImageView=[[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 30, 30)];
            profileImageView.image=[UIImage imageNamed:@"Profile"];
            //[cell addSubview:profileImageView];
            cell.textLabel.text=@"Propfile";
            cell.imageView.image=[UIImage imageNamed:@"Profile"];
        }
        else
        {
            UIImageView * profileImageView=[[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 30, 30)];
            profileImageView.image=[UIImage imageNamed:@"Settings"];
            //[cell addSubview:profileImageView];
            cell.textLabel.text=@"Settings";
            cell.imageView.image=[UIImage imageNamed:@"Settings"];
            //tableView.separatorColor=[UIColor colorWithRed:38.0/255.0 green:53.0/255.0 blue:61.0/255.0 alpha:1.0];
        }
        
        cell.backgroundColor=[UIColor colorWithRed:38.0/255.0 green:53.0/255.0 blue:61.0/255.0 alpha:1.0];
    }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.searchBar resignFirstResponder];
    if(self.state==KSMenuStateSearch)
    {

        UINavigationController * frontNavigationViewController=(UINavigationController *)self.parentController.frontViewController;
        
        for(UIViewController* child in [frontNavigationViewController childViewControllers])
            [child.navigationController popViewControllerAnimated:YES];
        
        EditTaskViewController* editTaskVC = [[EditTaskViewController alloc] init];
        
        
        [frontNavigationViewController pushViewController:editTaskVC animated:NO];
        //[self.parentController setNewFrontViewController:[[UINavigationController alloc] initWithRootViewController:[[EditTaskViewController alloc] init]]];
        
        self.parentController.hiden=NO;
        [self.parentController side];
        
    }
    
    else if(indexPath.section == 1)
    {
        KSCategory* category = self.categories[indexPath.row];
        TabletasksViewController * categoryTasksViewController=[[TabletasksViewController alloc] init];
        
        if(categoryTasksViewController)
        {
            categoryTasksViewController.title=[category name];
            categoryTasksViewController.category = category;
            UINavigationController* categoryTasksNav = [[UINavigationController alloc] initWithRootViewController:categoryTasksViewController];
            [self.parentController setNewFrontViewController:categoryTasksNav];
        }
    }
    
    else if(indexPath.section == 2 && indexPath.row == 1)
    {
        SettingsViewController * settingsViewController=[[SettingsViewController alloc] init];
        
        if(settingsViewController)
        {
            settingsViewController.title=@"Settings";
            UINavigationController* settingsNav = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
            [self.parentController setNewFrontViewController:settingsNav];
        }
    }
}

#pragma mark Search Bar delegate methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;
    searchBar.clearsContextBeforeDrawing=YES;

    self.parentController.hiden=NO;
    searchBar.frame=CGRectMake(8, 8, 255, 30);
    
    self.state=KSMenuStateNormal;
    [self.tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    self.state=KSMenuStateSearch;
    self.parentController.hiden=YES;
    searchBar.frame=CGRectMake(searchBar.frame.origin.x, searchBar.frame.origin.y, [UIScreen mainScreen].bounds.size.width-searchBar.frame.origin.x*2, searchBar.frame.size.height);
    searchBar.showsCancelButton=YES;
    

    [self.tableView reloadData];
    
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.state==KSMenuStateSearch)
    {
        return 55;
    }
    else
    {
        return 45;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
  //  [self.categories addObject:textField.text];
    textField.text=@"";
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.categories.count-1 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
    self.parentController.hiden=NO;
    self.searchBar.frame=CGRectMake(self.searchBar.frame.origin.x, self.searchBar.frame.origin.y, 255, self.searchBar.frame.size.height);
    return YES;
}

-(void)longPressDidUsed:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if (indexPath != nil && gestureRecognizer.state == UIGestureRecognizerStateBegan && indexPath.section==1)
    {
        UIAlertController * alertController=[UIAlertController alertControllerWithTitle:@"Allah" message:@"Test" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction * deleteAction=[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
        {
            [self.categories removeObjectAtIndex:indexPath.row];
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            });

        }];
        
        UIAlertAction * editAction=[UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            self.addCategoryTextField.text=[self.categories[indexPath.row] name];
            [self addCategoryDidTap];
        }];
        
        UIAlertAction * cancelAction=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:editAction];
        [alertController addAction:deleteAction];
        [alertController addAction:cancelAction];
        [self.parentController presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.parentController=(AMSideBarViewController *)self.parentViewController;
    self.state=KSMenuStateNormal;
    //self.tableView.separatorColor = [UIColor clearColor];
    
    UILongPressGestureRecognizer * longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDidUsed:)];
    longPress.minimumPressDuration=1.0;
    longPress.delegate=self;
    
    [self.tableView addGestureRecognizer:longPress];
    self.searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(8, 8, 255, 30)];
    self.searchBar.searchBarStyle=UISearchBarStyleMinimal;
    self.searchBar.tintColor=[UIColor whiteColor];
    self.searchBar.barTintColor=[UIColor whiteColor];
    self.searchBar.delegate=self;
    
    self.addCategoryAccessoryView=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.bounds.size.width, 44)];
    self.addCategoryAccessoryView.backgroundColor=[UIColor colorWithRed:32.0/255.0 green:45.0/255.0 blue:52.0/255.0 alpha:1.0];
    self.addCategoryTextField=[[UITextField alloc] initWithFrame:CGRectMake(16, 8, self.navigationController.toolbar.frame.size.width-32, 30)];
    self.addCategoryTextField.borderStyle=UITextBorderStyleRoundedRect;
    self.addCategoryTextField.backgroundColor=[UIColor colorWithRed:227.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
    self.addCategoryTextField.delegate=self;
    [self.addCategoryAccessoryView addSubview:self.addCategoryTextField];

    [self.view addSubview:self.addCategoryAccessoryView];

    
    UIView * searchBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 46)];
    [searchBarView addSubview:self.searchBar];
    
    self.tableView.tableHeaderView=searchBarView;
    [[UITextField appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObject:[UISearchBar class]]] setTextColor:[UIColor whiteColor]];
    [self.refresh removeFromSuperview];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:163.0/255.0 green:167.0/255.0 blue:169.0/255.0 alpha:0.35]];
    
    self.categories=[NSMutableArray arrayWithArray:[[ApplicationManager categoryApplicationManager] allCategories]];
    
    self.view.backgroundColor=[UIColor colorWithRed:32.0/255.0 green:45.0/255.0 blue:52.0/255.0 alpha:1.0];
    self.tableView.backgroundColor=[UIColor colorWithRed:32.0/255.0 green:45.0/255.0 blue:52.0/255.0 alpha:1.0];
    [self.view removeConstraint:self.top];
    
    [self.view addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.tableView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                   attribute:NSLayoutAttributeTop
                                   multiplier:1.0f
                                   constant:20.f]];
    
    self.addCategoryTextField.translatesAutoresizingMaskIntoConstraints=NO;
    [self.addCategoryAccessoryView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.addCategoryTextField
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.addCategoryAccessoryView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                     constant:-8.0]];
    
    [self.addCategoryAccessoryView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.addCategoryTextField
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.addCategoryAccessoryView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.0f
                                     constant:8.0]];
    
    [self.addCategoryAccessoryView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.addCategoryTextField
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.addCategoryAccessoryView
                                     attribute:NSLayoutAttributeTrailing
                                     multiplier:1.0f
                                     constant:-16.0]];
    
    [self.addCategoryAccessoryView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.addCategoryTextField
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.addCategoryAccessoryView
                                     attribute:NSLayoutAttributeLeading
                                     multiplier:1.0f
                                     constant:16.0]];
    
    self.addCategoryAccessoryView.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.addCategoryAccessoryView
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeBottom
                              multiplier:1.0f
                              constant:44.0]];
    
    //    [self.toolBarView addConstraint:[NSLayoutConstraint
    //                                     constraintWithItem:self.toolBarView
    //                                     attribute:NSLayoutAttributeHeight
    //                                     relatedBy:NSLayoutRelationEqual
    //                                     toItem:self.toolBarView
    //                                     attribute:NSLayoutAttributeHeight
    //                                     multiplier:1.0f
    //                                     constant:44.0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.addCategoryAccessoryView
                              attribute:NSLayoutAttributeTrailing
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeTrailing
                              multiplier:1.0f
                              constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.addCategoryAccessoryView
                              attribute:NSLayoutAttributeLeading
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeLeading
                              multiplier:1.0f
                              constant:0.0]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidHide:) name:@"menuDidHideNotification" object:nil];
}

-(void)menuDidHide:(NSNotification*) not
{
 
}

-(void)setBottomConstraintToValue:(float)value inView:(UIView*)view toView:(UIView *)targetView
{
    for(NSLayoutConstraint * constraint in view.constraints)
    {
        if(constraint.firstAttribute==NSLayoutAttributeBottom)
        {
            [view removeConstraint:constraint];
            break;
        }
    }
    [view addConstraint:[NSLayoutConstraint
                         constraintWithItem:targetView
                         attribute:NSLayoutAttributeBottom
                         relatedBy:NSLayoutRelationEqual
                         toItem:view
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:value]];
}

-(void)keyboardWillHide:(NSNotification*) not
{
    NSDictionary * info=[not userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    self.addCategoryAccessoryView.translatesAutoresizingMaskIntoConstraints = YES;
    self.tableView.translatesAutoresizingMaskIntoConstraints=YES;
    
    [UIView animateWithDuration:1 animations:^
     {
         self.addCategoryAccessoryView.frame=CGRectMake(0, [aValue CGRectValue].origin.y+44, self.view.bounds.size.width, 44);
         self.tableView.frame=CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height+keyboardSize.height);
     } completion:^(BOOL finished)
     {
         if(finished)
         {
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                self.addCategoryAccessoryView.translatesAutoresizingMaskIntoConstraints = NO;
                                self.tableView.translatesAutoresizingMaskIntoConstraints=NO;
                                [self setBottomConstraintToValue:44 inView:self.view toView:self.addCategoryAccessoryView];
                                [self setBottomConstraintToValue:0 inView:self.view toView:self.tableView];
                            });
             
         }
     }];
}

-(void)keyboardWillShown:(NSNotification*) not
{
    if(self.state==KSMenuStateNormal)
    {
    NSDictionary * info=[not userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    self.addCategoryAccessoryView.translatesAutoresizingMaskIntoConstraints = YES;
    self.tableView.translatesAutoresizingMaskIntoConstraints=YES;
    NSLog(@"%@",info);
    [UIView animateWithDuration:1 animations:^
     {
         self.addCategoryAccessoryView.frame=CGRectMake(0, [aValue CGRectValue].origin.y-45, self.view.bounds.size.width, 44);
         self.tableView.frame=CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height-keyboardSize.height);
     } completion:^(BOOL finished)
     {
         if(finished)
         {
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                self.addCategoryAccessoryView.translatesAutoresizingMaskIntoConstraints = NO;
                                self.tableView.translatesAutoresizingMaskIntoConstraints=NO;
                                [self setBottomConstraintToValue:-keyboardSize.height inView:self.view toView:self.addCategoryAccessoryView];
                                [self setBottomConstraintToValue:-keyboardSize.height-45.0 inView:self.view toView:self.tableView];
                            });
             
         }
     }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
