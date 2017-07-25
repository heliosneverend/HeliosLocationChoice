//
//  PlaceViewMenu.m
//  HeliosRegionchoic
//
//  Created by beyo-zhaoyf on 2017/7/25.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import "PlaceViewMenu.h"
@interface PlaceViewMenu ()
@property (nonatomic, strong) UIButton * provinceBtn;
@property (nonatomic, strong) UIButton * cityBtn;
@property (nonatomic, strong) UIButton * districtBtn;
@property (nonatomic, strong) UILabel * provinceLine;
@property (nonatomic, strong) UILabel * cityline;
@property (nonatomic, strong) UILabel * lastLine;
@end
@implementation PlaceViewMenu
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self makeUI];
    }
    return self;
}
- (void)makeUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.btn_province];
    [self addSubview:self.btn_city];
    [self addSubview:self.btn_district];
    [self addSubview:self.lab_lineV1];
    [self addSubview:self.lab_lineV2];
    [self addSubview:self.lab_lineH];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    float width = self.bounds.size.width;
    [_provinceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.bottom.mas_equalTo(@-1);
        make.width.mas_equalTo(@((width - 2)/3));
    }];
    
    [_provinceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@1);
        make.top.mas_equalTo(@5);
        make.bottom.mas_equalTo(@-6);
        make.left.mas_equalTo(_provinceBtn.mas_right);
    }];
    
    [_cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@((width - 2)/3));
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@-1);
        make.left.mas_equalTo(_provinceLine.mas_right);
    }];
    
    [_cityline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@1);
        make.top.mas_equalTo(@5);
        make.bottom.mas_equalTo(@-6);
        make.left.mas_equalTo(_cityBtn.mas_right);
    }];
    
    [_districtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@((width - 2)/3));
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@-1);
        make.left.mas_equalTo(_cityline.mas_right);
    }];
    
    [_lastLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 1));
        make.left.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
    }];

}

#pragma mark configView
- (void)configViewWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district {
    if(!province || province.length <= 0){
       // NSCAssert(!province || province.length <= 0, @"province is wrong");
    }else{
         [_provinceBtn setTitle:province forState:UIControlStateNormal];
    }
    if (!city || city.length <= 0) {
       // NSCAssert(!province || province.length <= 0, @"city is wrong");
    }else{
        [_cityBtn setTitle:city forState:UIControlStateNormal];
    }
    
    if (!district || district.length <= 0) {
      // NSCAssert(!province || province.length <= 0, @"district is wrong");
    }else{
         [_districtBtn setTitle:district forState:UIControlStateNormal];
    }

}
- (void)reset {
    if (_provinceBtn.selected) {
        _provinceBtn.selected = NO;
    }
    
    if (_cityBtn.selected) {
        _cityBtn.selected = NO;
    }
    
    if (_districtBtn.selected) {
        _districtBtn.selected = NO;
    }

}
#pragma mark button event
- (void)clickSelectProvince:(UIButton *)button {
    
    button.selected = !button.selected;
    _cityBtn.selected = NO;
    _districtBtn.selected = NO;
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectAtIndex:isShow:)]) {
        [self.delegate menuView:self didSelectAtIndex:0 isShow:button.selected];
    }
}
- (void)clickSelectCity:(UIButton *)button {
    
    button.selected = !button.selected;
    _provinceBtn.selected = NO;
    _districtBtn.selected = NO;
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectAtIndex:isShow:)]) {
        
        [self.delegate menuView:self didSelectAtIndex:1 isShow:button.selected];
    }
}

- (void)clickSelectDistrict:(UIButton *)button {
    
    button.selected = !button.selected;
    _provinceBtn.selected = NO;
    _cityBtn.selected = NO;
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectAtIndex:isShow:)]) {
        
        [self.delegate menuView:self didSelectAtIndex:2 isShow:button.selected];
    }
}

#pragma mark - setter and getter

- (UIButton *)btn_province {
    
    if (!_provinceBtn) {
        
        _provinceBtn = [[UIButton alloc] init];
        _provinceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_provinceBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_provinceBtn addTarget:self action:@selector(clickSelectProvince:) forControlEvents:UIControlEventTouchUpInside];
    }
    //_btn_province.backgroundColor = HeliosRandomColor;
    return _provinceBtn;
}

- (UIButton *)btn_city {
   
    if (!_cityBtn) {
        
        _cityBtn = [[UIButton alloc] init];
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cityBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_cityBtn addTarget:self action:@selector(clickSelectCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    // _btn_city.backgroundColor = HeliosRandomColor;
    return _cityBtn;
}

- (UIButton *)btn_district {

    if (!_districtBtn) {
        _districtBtn = [[UIButton alloc] init];
        _districtBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_districtBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_districtBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_districtBtn addTarget:self action:@selector(clickSelectDistrict:) forControlEvents:UIControlEventTouchUpInside];
    }
    // _btn_district.backgroundColor = HeliosRandomColor;
    return _districtBtn;
}

- (UILabel *)lab_lineV1 {
    
    if (!_provinceLine) {
        _provinceLine = [[UILabel alloc] init];
        _provinceLine.backgroundColor = Color_Line;
    }
    return _provinceLine;
}

- (UILabel *)lab_lineV2 {
    
    if (!_cityline) {
        
        _cityline = [[UILabel alloc] init];
        _cityline.backgroundColor = Color_Line;
    }
    return _cityline;
}

- (UILabel *)lab_lineH {
    
    if (!_lastLine) {
        
        _lastLine = [[UILabel alloc] init];
        _lastLine.backgroundColor = Color_Line;
    }
    return _lastLine;
}
@end
