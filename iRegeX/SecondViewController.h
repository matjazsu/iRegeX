//
//  SecondViewController.h
//  iRegeX
//
//  Created by Matjaz Suber on 03/02/14.
//  Copyright (c) 2014 Matjaz Suber. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SecondViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *m_scrollView;

@property (strong, nonatomic) IBOutlet UIView *m_contentView;

@property (strong, nonatomic) IBOutlet UITextField *m_txtExpression;

@property (strong, nonatomic) IBOutlet UISwitch *m_chcMatch;

@property (strong, nonatomic) IBOutlet UITextView *m_txtIN;

@property (strong, nonatomic) IBOutlet UITextField *m_txtNumber;

- (IBAction)Match:(id)sender;

- (IBAction)Clear:(id)sender;

- (IBAction)RemoveKeyboard:(id)sender;

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;

- (void)textViewDidEndEditing:(UITextView *)textView;

@end
