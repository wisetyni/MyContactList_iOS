//
//  LMAContactsDAO.m
//  MyContactList
//
//  Copyright © 2018 Learning Mobile Apps. All rights reserved.
//

#import "LMAContactsDAO.h"

@implementation LMAContactsDAO

- (id) init
{
    self = [super init];
    if (self) {
        self.appDelegate = (LMAAppDelegate*)[[UIApplication sharedApplication]delegate];
        self.context = _appDelegate.managedObjectContext;
    }
    return self;
}

- (void)insertContact:(Contact *)contact
{
    
}

@end
