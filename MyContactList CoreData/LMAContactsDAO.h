//
//  LMAContactsDAO.h
//  MyContactList
//
//  Copyright © 2018 Learning Mobile Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMAAppDelegate.h"
#import "Contact.h"

@interface LMAContactsDAO : NSObject

@property (nonatomic, strong) LMAAppDelegate *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *context;

- (void) insertContact: (Contact*) contact;

@end