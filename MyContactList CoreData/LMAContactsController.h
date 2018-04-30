//
//  LMAFirstViewController.h
//  My ContactList
//
//  Created by Iversen, Jakob H on 8/29/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactVO.h"
#import "LMAPhoneTextField.h"

@interface LMAContactsController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> 

@property (strong, nonatomic) ContactVO *contact;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)changeEditMode:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmtEditMode;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;
@property (weak, nonatomic) IBOutlet UITextField *txtCell;
@property (weak, nonatomic) IBOutlet LMAPhoneTextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthdate;

@property (weak, nonatomic) IBOutlet UIButton *btnChange;

@property (weak, nonatomic) IBOutlet UIImageView *imgContactPicture;
- (IBAction)changePicture:(id)sender;
@end
