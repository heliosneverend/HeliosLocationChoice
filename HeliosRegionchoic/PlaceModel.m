//
//  PlaceModel.m
//  HeliosRegionchoic
//
//  Created by beyo-zhaoyf on 2017/7/25.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import "PlaceModel.h"

@implementation PlaceModel

@end

@implementation Province

- (instancetype)init {
    self = [super init];
    if(self){
        self.cityArr = [[NSMutableArray alloc]init];
    }
    return self;
}

@end

@implementation City

- (instancetype)init {
    if(self = [super init]){
        self.districtArr = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
@implementation District

@end
