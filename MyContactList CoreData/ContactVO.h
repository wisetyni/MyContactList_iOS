//
//  ContactVO.h
//  MyContactList
//
//  Created by Allen, Yvonne on 4/30/18.
//  Copyright © 2018 Learning Mobile Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactVO : NSObject

@property (nonatomic, strong) NSDate * birthday;
@property (nonatomic, strong) NSString * cellNumber;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * contactName;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * phoneNumber;
@property (nonatomic, strong) NSString * state;
@property (nonatomic, strong) NSString * streetAddress;
@property (nonatomic, strong) NSString * zipCode;
@property (nonatomic, strong) NSData * image;

@end
