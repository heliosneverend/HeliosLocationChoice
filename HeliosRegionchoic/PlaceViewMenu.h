//
//  PlaceViewMenu.h
//  HeliosRegionchoic
//
//  Created by beyo-zhaoyf on 2017/7/25.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaceViewMenu;
@protocol PlaceViewMenuDelegate <NSObject>

@optional
/**
 点击菜单
 
 @param menuView 菜单view
 @param index    选中菜单的下标：0代表省，1代表市，2代表区/县
 @param isShow   是否弹出显示当前的对应列表
 */
- (void)menuView:(PlaceViewMenu *)menuView didSelectAtIndex:(NSInteger)index isShow:(BOOL)isShow;
@end

@interface PlaceViewMenu : UIView

@property (nonatomic,weak)id<PlaceViewMenuDelegate> delegate;
- (void)configViewWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district;
//刷新
- (void)reset;
@end
