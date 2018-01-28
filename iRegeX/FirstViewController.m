//
//  FirstViewController.m
//  iRegeX
//
//  Created by Matjaz Suber on 03/02/14.
//  Copyright (c) 2014 Matjaz Suber. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self InitScrollView];
    [self SetTextViewStyle];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gesture];
}

-(void)InitScrollView
{
    [self.m_scrollView layoutIfNeeded];
    [self.m_scrollView setContentSize:self.m_contentView.frame.size];
}

-(void)SetTextViewStyle
{
    //Set m_txtExpression
    [self.m_txtExpression.layer setBorderColor:[[UIColorFromRGB(0x4CD964) colorWithAlphaComponent:0.5]CGColor]];
    [self.m_txtExpression.layer setBorderWidth:1.0];
    self.m_txtExpression.layer.cornerRadius = 5;
    self.m_txtExpression.clipsToBounds = YES;
    
    //Set m_txtReplace
    [self.m_txtReplace.layer setBorderColor:[[UIColorFromRGB(0x4CD964) colorWithAlphaComponent:0.5]CGColor]];
    [self.m_txtReplace.layer setBorderWidth:1.0];
    self.m_txtReplace.layer.cornerRadius = 5;
    self.m_txtReplace.clipsToBounds = YES;
    
    //Set m_txtIN
    [self.m_txtIN.layer setBorderColor:[[UIColorFromRGB(0x4CD964) colorWithAlphaComponent:0.5] CGColor]];
    [self.m_txtIN.layer setBorderWidth:1.0];
    self.m_txtIN.layer.cornerRadius = 5;
    self.m_txtIN.clipsToBounds = YES;
    
    //Set m_txtOUT
    [self.m_txtOUT.layer setBorderColor:[[UIColorFromRGB(0x4CD964) colorWithAlphaComponent:0.5] CGColor]];
    [self.m_txtOUT.layer setBorderWidth:1.0];
    self.m_txtOUT.layer.cornerRadius = 5;
    self.m_txtOUT.clipsToBounds = YES;
}

-(void)dismissKeyboard
{
    [self.m_txtExpression resignFirstResponder];
    [self.m_txtReplace resignFirstResponder];
    [self.m_txtIN resignFirstResponder];
    [self.m_txtOUT resignFirstResponder];
}

- (IBAction)Replace:(id)sender
{
    NSString *expression = self.m_txtExpression.text != NULL ? self.m_txtExpression.text : @"";
    NSString *replaceWith = self.m_txtReplace.text != NULL ? self.m_txtReplace.text : @"";
    NSString *textIN = self.m_txtIN.text != NULL ? self.m_txtIN.text : @"";
    
    if([expression isEqualToString:@""] || [replaceWith isEqualToString:@""] || [textIN isEqualToString:@""]){
        UIAlertView *allert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please enter all required information." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [allert show];
    }
    else{
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
        NSString *textOUT = [regex stringByReplacingMatchesInString:textIN options:0 range:NSMakeRange(0, [textIN length]) withTemplate:replaceWith];
        if(error){
            UIAlertView *allert = [[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [allert show];
        }
        else{
            [self.m_txtOUT setText:textOUT];
        }
        
        [self dismissKeyboard];
    }
}

- (IBAction)Clear:(id)sender
{
    [self.m_txtExpression setText:@""];
    [self.m_txtReplace setText:@""];
    [self.m_txtIN setText:@""];
    [self.m_txtOUT setText:@""];
    
    [self dismissKeyboard];
}

- (IBAction)TextBoxShouldBeginEditing:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.m_contentView.frame;
    frame.origin.y = -80;
    [self.m_contentView setFrame:frame];
    [UIView commitAnimations];
}

- (IBAction)TextBoxDidEndEditing:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.m_contentView.frame;
    frame.origin.y = 0;
    [self.m_contentView setFrame:frame];
    [UIView commitAnimations];
    
    [self dismissKeyboard];
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
    frame.origin.y = -147;
    [self.m_contentView setFrame:frame];
    [UIView commitAnimations];
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.m_contentView.frame;
    frame.origin.y = 0;
    [self.m_contentView setFrame:frame];
    [UIView commitAnimations];
    
    [self dismissKeyboard];
}

@end
