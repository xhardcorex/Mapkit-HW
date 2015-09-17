//
//  PersonalInfoViewController.m
//  MapKit HW
//
//  Created by Nik on 15.09.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "PersonalInfoViewController.h"
@interface PersonalInfoViewController () 
@end
@implementation PersonalInfoViewController

- (void) setName:(NSString*)name dateOfBirth:(NSDate*) date andAdress:(NSString*)addres{
    
    NSLog(@"%@", name);
    
    self.nameAndSurname = name;
    self.date = date;
    self.address = addres;
    NSLog(@"addres: %@",addres);
    
}

- (void) viewDidLoad{

    self.nameLabel.text = self.nameAndSurname;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    NSDate *date = self.date;
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSString *string = [dateFormatter stringFromDate: date];
    
    self.dateOfBirthLabel.text = string;
    self.addressLabel.text = self.address;
    
}
@end
