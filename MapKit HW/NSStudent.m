//
//  NSStudent.m
//  Lesson30UITableVIew Dynamic cells
//
//  Created by Nik on 09.08.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "NSStudent.h"

@implementation NSStudent

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = [self createName];
        self.surname = [self createSurname];
        NSInteger sa =arc4random()%20;
        NSLog(@"sa = %ld",(long)sa);
        self.location = CLLocationCoordinate2DMake(arc4random()%15 + 40
                                                   ,-95 - sa);
        self.dateOfBirth = [self generateDayOfBirth];
        [self makeAdress];
    }
    return self;
}
- (void) makeAdress{
    
    
    
    CLLocationCoordinate2D coordinate = self.location;
    
    CLLocation* location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    CLGeocoder* geo = [[CLGeocoder alloc]init];
    
    
    [geo reverseGeocodeLocation:location
                        completionHandler:^(NSArray *placemarks, NSError *error) {
                            CLPlacemark *placemark = [placemarks firstObject];
                            
                            
                            self.adress =  [NSString stringWithFormat:@"%@ %@ %@ %@",
                                               placemark.country ? placemark.country: @"",
                                               placemark.locality ? placemark.locality:@"",
                                               placemark.thoroughfare ? placemark.thoroughfare:@"",
                                               placemark.subThoroughfare ? placemark.subThoroughfare:@""
                                               ];
                            
                            
                            NSLog(@"placemark %@",placemark);
                            //String to hold address
                            NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                            NSLog(@"addressDictionary %@", placemark.addressDictionary);
                            
                            NSLog(@"placemark %@",placemark.region);
                            NSLog(@"placemark %@",placemark.country);  // Give Country Name
                            NSLog(@"placemark %@",placemark.locality); // Extract the city name
                            NSLog(@"location %@",placemark.name);
                            NSLog(@"location %@",placemark.ocean);
                            NSLog(@"location %@",placemark.postalCode);
                            NSLog(@"location %@",placemark.subLocality);
                            
                            NSLog(@"location %@",placemark.location);
                            //Print the location to console
                            NSLog(@"I am currently at %@",locatedAt);
                            
                            
                            
                        }
     
     
     ];
    
    
}
- (NSString*) createName{
    
    NSArray* namesArray = [[NSArray alloc]initWithObjects:
                           @"Александр",
                           @"Иван",
                           @"Сергей",
                           @"Роберт",
                           @"Никита",
                           @"Вова",
                           @"Вадим",
                           @"Влад",
                           @"Григорий",
                           @"Назар",
                           nil];
    
    return [namesArray objectAtIndex:arc4random()%10];
}
- (NSString*) createSurname{
    
    NSArray* surnamesArray = [[NSArray alloc]initWithObjects:
                           @"Коноплянка",
                           @"Ярмоленко",
                           @"Коваленко",
                           @"Шевченко",
                           @"Левандовский",
                           @"Мюллер",
                           @"Иванович",
                           @"Гройсман",
                           @"Порошенко",
                           @"Суарез",
                           nil];
    
    return [surnamesArray objectAtIndex:arc4random()%10];
}
- (NSDate*) generateDayOfBirth{
    
    
    NSDate* birthDate = [NSDate date];
    
    NSTimeInterval  secondsPerDay = 60 * 60 *24;
    
    NSTimeInterval  secondsPerYear = secondsPerDay * 365;
    
    
    NSTimeInterval secondsPerBirthday = secondsPerDay * (arc4random()%365);
    NSTimeInterval secondsPerBirthYear = secondsPerYear * (arc4random()%(50-16+1)+16);
    
    birthDate = [birthDate dateByAddingTimeInterval:-(secondsPerBirthday+secondsPerBirthYear)];
    
    return birthDate;
    
    
    // NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    
    
    //[dateFormatter setDateFormat:@"dd.mm.yyyy"];
    
    // birthDate = [dateFormatter stringFromDate:birthDate];
    
}

@end
