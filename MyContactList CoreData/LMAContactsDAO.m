//
//  LMAContactsDAO.m
//  MyContactList
//
//  Copyright © 2018 Learning Mobile Apps. All rights reserved.
//

#import "LMAContactsDAO.h"

@implementation LMAContactsDAO

static NSString *const contactNameKey = @"contactName";
static NSString *const contactAddressKey = @"streetAddress";
static NSString *const contactCityKey = @"city";
static NSString *const contactStateKey = @"state";
static NSString *const contactZipCodeKey = @"zipCode";
static NSString *const contactPhoneKey = @"phoneNumber";
static NSString *const contactCellPhoneKey = @"cellNumber";
static NSString *const contactEmailKey = @"email";
static NSString *const contactBirthdayKey = @"birthday";
static NSString *const contactImageKey = @"image";

- (instancetype) init
{
    self = [super init];
    if (self) {
        _appDelegate = (LMAAppDelegate*)[[UIApplication sharedApplication]delegate];
        _context = _appDelegate.managedObjectContext;
    }
    return self;
}

- (void)insertContact:(Contact *)contact
{
    Contact *contactCD;
    if(!contactCD){
        contactCD =[NSEntityDescription
                   insertNewObjectForEntityForName:@"Contact"
                   inManagedObjectContext:_context];
        
    }
    
    NSError *error;
    [contactCD setValue:[contact contactName] forKey:contactNameKey];
    [contactCD setValue:[contact streetAddress] forKey:contactAddressKey];
    [contactCD setValue:[contact city] forKey:contactCityKey];
    [contactCD setValue:[contact state] forKey:contactStateKey];
    [contactCD setValue:[contact zipCode] forKey:contactZipCodeKey];
    [contactCD setValue:[contact phoneNumber] forKey:contactPhoneKey];
    [contactCD setValue:[contact cellNumber] forKey:contactCellPhoneKey];
    [contactCD setValue:[contact email] forKey:contactEmailKey];
    [contactCD setValue:[contact birthday] forKey:contactBirthdayKey];
    
    [_context save:&error];
    if(error !=nil) {
        NSLog(@"Error saving object: %@", error.description);
        
    }
    else {
        NSLog(@"Object saved successfully");
        
    }
}

@end
