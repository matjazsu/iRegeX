//
//  SecondViewController.m
//  iRegeX
//
//  Created by Matjaz Suber on 03/02/14.
//  Copyright (c) 2014 Matjaz Suber. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{    
    [super viewDidLoad];
    [self InitScrollView];
    [self SetTextViewStyle];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gesture];
}

- (void)InitScrollView
{
    [self.m_scrollView layoutIfNeeded];
    [self.m_scrollView setContentSize:self.m_contentView.frame.size];
}

- (void)SetTextViewStyle
{
    //Set m_txtExpression
    [self.m_txtExpression.layer setBorderColor:[[UIColorFromRGB(0x4CD964) colorWithAlphaComponent:0.5]CGColor]];
    [self.m_txtExpression.layer setBorderWidth:1.0];
    self.m_txtExpression.layer.cornerRadius = 5;
    self.m_txtExpression.clipsToBounds = YES;
    
    //Set m_txtNumber
    [self.m_txtNumber.layer setBorderColor:[[UIColorFromRGB(0x4CD964) colorWithAlphaComponent:0.5]CGColor]];
    [self.m_txtNumber.layer setBorderWidth:1.0];
    self.m_txtNumber.layer.cornerRadius = 5;
    self.m_txtNumber.clipsToBounds = YES;
    
    //Set m_txtIN
    [self.m_txtIN.layer setBorderColor:[[UIColorFromRGB(0x4CD964) colorWithAlphaComponent:0.5] CGColor]];
    [self.m_txtIN.layer setBorderWidth:1.0];
    self.m_txtIN.layer.cornerRadius = 5;
    self.m_txtIN.clipsToBounds = YES;
}

- (void)dismissKeyboard
{
    [self.m_txtExpression resignFirstResponder];
    [self.m_txtIN resignFirstResponder];
}

- (IBAction)RemoveKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.m_contentView.frame;
    frame.origin.y = -60;
    [self.m_contentView setFrame:frame];
    [UIView commitAnimations];
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.m_contentView.frame;
    frame.origin.y = 20;
    [self.m_contentView setFrame:frame];
    [UIView commitAnimations];
}

- (IBAction)Match:(id)sender
{
    NSString *expression = self.m_txtExpression.text != NULL ? self.m_txtExpression.text : @"";
    NSString *textIN = self.m_txtIN.text != NULL ? self.m_txtIN.text : @"";
    
    if([expression isEqualToString:@""] || [textIN isEqualToString:@""]){
        UIAlertView *allert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please enter all required information." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [allert show];
    }
    else{
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
        NSInteger countMatch = [regex numberOfMatchesInString:textIN options:0 range:NSMakeRange(0, [textIN length])];
        if(error){
            UIAlertView *allert = [[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [allert show];
        }
        else{
            if(countMatch > 0){
                [self.m_chcMatch setOn:YES animated:YES];
                [self.m_txtNumber setText:[NSString stringWithFormat:@"%ld", (long)countMatch]];
            }
            else{
                [self.m_chcMatch setOn:NO animated:YES];
                [self.m_txtNumber setText:[NSString stringWithFormat:@"%ld", (long)0]];
            }
        }
    }
    
    [self dismissKeyboard];
}

- (IBAction)Clear:(id)sender
{
    [self.m_txtExpression setText:@""];
    [self.m_txtIN setText:@""];
    [self.m_txtNumber setText:@""];
    [self.m_chcMatch setOn:NO animated:YES];
    
    [self dismissKeyboard];
}

@end
