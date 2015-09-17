//
//  PersonalInfoViewController.h
//  MapKit HW
//
//  Created by Nik on 15.09.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "ViewController.h"
#import "NSStudent.h"

@interface PersonalInfoViewController : ViewController <NSPersonalInfoDelegate>


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong,nonatomic) NSString* nameAndSurname;
@property (strong,nonatomic) NSDate* date;
@property (strong,nonatomic) NSString* address;


//@property (weak,nonatomic) id<NSPersonalInfoDelegate> delegate;
@end
