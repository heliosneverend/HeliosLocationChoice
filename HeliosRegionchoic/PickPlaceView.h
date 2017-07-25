//
//  PickPlaceView.h
//  HeliosRegionchoic
//
//  Created by beyo-zhaoyf on 2017/7/25.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PickPlaceView;
/*
 ** 使用tableView 展示
 */
//声明代理
@protocol PickerPlaceDelegate <NSObject>
@optional
/*
 ** param placeView 区域
 ** param place 选中地区
 ** param place 菜单的第几个
 ** param place 选中在第几个
 */

- (void)placeView:(PickPlaceView *)placeView didSelectPlace:(NSString *)place atComponent:(NSInteger )component atRow:(NSInteger )row;
//展示区域收起
- (void)placeViewDidHidden;

@end

@interface PickPlaceView : UIView
@property (nonatomic,weak)id<PickerPlaceDelegate>delegate;
/*
 **  刷新地区列表View
 **  @param dataArr 数据源 省/市  区或县
 **  @param component 选中的列
 */
- (void)reloadViewWithDataSource:(NSArray *)dataArr component:(NSUInteger )component;
/*
 ** 收起
 */
- (void)hiddenView;

@end
