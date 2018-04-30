//
//  LMAFirstViewController.m
//  My ContactList
//
//  Created by Iversen, Jakob H on 8/29/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMAContactsController.h"
#import "LMADateController.h"
#import "ContactVO.h"
#import "LMAContactsDAO.h"

@interface LMAContactsController () <LMADateControllerDelegate>

@end

@implementation LMAContactsController

BOOL atLeastIOS6;
NSDate *birthdate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _scrollView.contentSize = CGSizeMake(320,500);
    
    UIBarButtonItem *saveButton =
                [[UIBarButtonItem alloc]
                        initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                        target:self
                        action:@selector(saveContact:)];
    (self.navigationItem).rightBarButtonItem = saveButton;
    self.title = @"Contact";
    
    if(_contact){
        _txtName.text = _contact.contactName;
        _txtAddress.text = _contact.streetAddress;
        _txtCity.text = _contact.city;
        _txtState.text = _contact.state;
        _txtZip.text = _contact.zipCode;
        _txtPhone.text = _contact.phoneNumber;
        _txtCell.text = _contact.cellNumber;
        _txtEmail.text = _contact.email;
        [self dateChanged:_contact.birthday];
        _sgmtEditMode.selectedSegmentIndex = 0; //set to view mode
        _imgContactPicture.image = [UIImage imageWithData:_contact.image];
    }
    else{
        _sgmtEditMode.selectedSegmentIndex = 1;//edit mode
    }
    [self changeEditMode:self];
    atLeastIOS6 = [UIDevice currentDevice].systemVersion.floatValue >= 6.0;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(callPhone:)];
    [_txtPhone addGestureRecognizer:longPress];
}


-(void)viewDidLayoutSubviews
{
    _scrollView.contentSize = CGSizeMake(320,500);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backgroundTap:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)changeEditMode:(id)sender {
    NSArray *textFields = @[_txtName, _txtAddress, _txtCity, _txtState,
                            _txtZip, _txtPhone, _txtCell, _txtEmail];
    if (_sgmtEditMode.selectedSegmentIndex == 0){
        for (UITextField *txtfield in textFields) {
            [txtfield setEnabled:NO];
            txtfield.borderStyle = UITextBorderStyleNone;
        }
        [_btnChange setHidden:YES];
        _txtPhone.editMode = NO;
        [_txtPhone setEnabled:YES];
    }
    else if (_sgmtEditMode.selectedSegmentIndex == 1)
    {
        for (UITextField *txtfield in textFields) {
            [txtfield setEnabled:YES];
            txtfield.borderStyle = UITextBorderStyleRoundedRect;
        }
        [_btnChange setHidden:NO];
        _txtPhone.editMode = YES;
    }
}



-(void)dateChanged:(NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    _lblBirthdate.text = [dateFormatter stringFromDate:date ];
    birthdate = date;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueContactDate"]) {
        LMADateController *dateController = segue.destinationViewController;
        dateController.delegate = self;
    }
}

-(IBAction)saveContact: (id)sender
{
    LMAContactsDAO *dao = [[LMAContactsDAO alloc] init];
    _contact = [[ContactVO alloc] init];
    
    [_contact setContactName: _txtName.text];
    [_contact setStreetAddress: _txtAddress.text];
    [_contact setCity: _txtCity.text];
    [_contact setState: _txtState.text];
    [_contact setZipCode: _txtZip.text];
    [_contact setPhoneNumber: _txtPhone.text];
    [_contact setCellNumber: _txtCell.text];
    [_contact setEmail: _txtEmail.text];
    [_contact setBirthday: birthdate];
    NSData *imageData = UIImagePNGRepresentation(_imgContactPicture.image);
    [_contact setImage: imageData];
    
    [dao insertContact: _contact];
}
- (IBAction)changePicture:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:                            //1
        UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *cameraController =[[UIImagePickerController      //2
                                                     alloc] init];
        cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;    //3
        cameraController.delegate = self;                                         //4
        cameraController.allowsEditing = YES;                                     //5
        if(atLeastIOS6){                                                          //6
            [self presentViewController:cameraController
                               animated:YES
                             completion:nil];
        }
        else{ //deprecated from iOS 6                                             //7
            [self presentModalViewController:cameraController
                                    animated:YES];
        }
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];      //1
//    if(!image)                                                                    //2
//        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imgContactPicture.image = image;                                             //3
    if(atLeastIOS6){                                                              //4
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)callPhone:(UILongPressGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {                         //1
        NSLog(@"Long Press");                                                      //2
        NSString *phoneURL = [NSString                                             //3
                              stringWithFormat:@"telprompt://%@", _txtPhone.text];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:phoneURL]]; //4
    }
}


@end
