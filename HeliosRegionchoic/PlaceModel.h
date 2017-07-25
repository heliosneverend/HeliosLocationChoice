//
//  PlaceModel.h
//  HeliosRegionchoic
//
//  Created by beyo-zhaoyf on 2017/7/25.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Province;
@class City;
@class District;

@interface PlaceModel : NSObject

@end

@interface Province : NSObject
@property (nonatomic, copy)NSString *province;
@property (nonatomic, strong)NSMutableArray *cityArr;

@end

@interface City : NSObject
@property (nonatomic,copy)NSString *city;
@property (nonatomic,strong)NSMutableArray *districtArr;

@end

@interface District : NSObject
@property (nonatomic, copy)NSString *district;
@end
