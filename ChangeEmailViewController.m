//
//  ChangeEmailViewController.m
//  PlanAndDo
//
//  Created by Arthur Chistyak on 13.09.16.
//  Copyright © 2016 TodoTeamGroup. All rights reserved.
//

#import "ChangeEmailViewController.h"
#import "KSApplicatipnColor.h"

#define TEXTFIELD_PADDING_LEFT 10


@interface ChangeEmailViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic)UITapGestureRecognizer * tap;
@end

@implementation ChangeEmailViewController

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    [self.emailTextField resignFirstResponder];
    [self.oldEmailTextField resignFirstResponder];
    [self.reenterEmailTextField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CAGradientLayer * gradient=[KSApplicatipnColor sharedColor].rootGradient;
    gradient.frame=self.view.bounds;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    UIView *oldEmailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TEXTFIELD_PADDING_LEFT, 0)];
    self.oldEmailTextField.leftView = oldEmailPaddingView;
    self.oldEmailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *emailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TEXTFIELD_PADDING_LEFT, 0)];
    self.emailTextField.leftView = emailPaddingView;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *reenterEmailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TEXTFIELD_PADDING_LEFT, 0)];
    self.reenterEmailTextField.leftView = reenterEmailPaddingView;
    self.reenterEmailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.tap=[[UITapGestureRecognizer alloc] init];
    self.tap.delegate=self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)keyboardWillHide:(NSNotification *)not
{
    [self.view removeGestureRecognizer:self.tap];
    
    [UIView animateWithDuration:1 animations:^
     {
         self.backTextFieldView.frame=CGRectMake(self.backTextFieldView.frame.origin.x,
                                                 self.view.bounds.size.height/2-self.backTextFieldView.frame.size.height/2,
                                                 self.backTextFieldView.frame.size.width,
                                                 self.backTextFieldView.frame.size.height);
     } completion:^(BOOL finished)
     {
     }];
}

-(void)keyboardWillShown:(NSNotification *)not
{
    [self.view addGestureRecognizer:self.tap];
    NSDictionary * info=[not userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    [UIView animateWithDuration:1 animations:^
     {
         self.backTextFieldView.frame=CGRectMake(self.backTextFieldView.frame.origin.x,
                                                 [aValue CGRectValue].origin.y-self.backTextFieldView.frame.size.height-70,
                                                 self.backTextFieldView.frame.size.width,
                                                 self.backTextFieldView.frame.size.height);
     } completion:^(BOOL finished)
     {
     }];
}
- (IBAction)submitDidTap:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
