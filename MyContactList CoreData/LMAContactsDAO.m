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

- (void)insertContact:(ContactVO *)contactVO
{
    Contact *contact;
    if(!contact){
        contact =[NSEntityDescription
                   insertNewObjectForEntityForName:@"Contact"
                   inManagedObjectContext:_context];
        
    }
    
    NSError *error;
    [contact setValue:[contactVO contactName] forKey:contactNameKey];
    [contact setValue:[contactVO streetAddress] forKey:contactAddressKey];
    [contact setValue:[contactVO city] forKey:contactCityKey];
    [contact setValue:[contactVO state] forKey:contactStateKey];
    [contact setValue:[contactVO zipCode] forKey:contactZipCodeKey];
    [contact setValue:[contactVO phoneNumber] forKey:contactPhoneKey];
    [contact setValue:[contactVO cellNumber] forKey:contactCellPhoneKey];
    [contact setValue:[contactVO email] forKey:contactEmailKey];
    [contact setValue:[contactVO birthday] forKey:contactBirthdayKey];
    
    [_context save:&error];
    if(error !=nil) {
        NSLog(@"Error saving object: %@", error.description);
        
    }
    else {
        NSLog(@"Object saved successfully");
        
    }
}

- (NSArray*) findAllContacts:(NSArray *)sortDescriptors
{
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Contact"
                                            inManagedObjectContext:_context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entityDescription;
    
    request.sortDescriptors = sortDescriptors;
    
    NSError *error;
    
    NSArray *contacts = [[NSArray alloc]
                initWithArray:[_context executeFetchRequest:request
                                                     error:&error]];
    
    return contacts;
}

- (void) deleteContact:(Contact *)contact
{
    [_context deleteObject:contact];
    NSError *error;
    [_context save:&error];
    
}

@end
