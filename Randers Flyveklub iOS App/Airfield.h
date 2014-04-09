//
//  Airfield.h
//  Randers Flyveklub iOS App
//
//  Created by Daniel Otkjær on 4/8/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Airfield : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icao;
@property (nonatomic, copy) NSString *country;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
