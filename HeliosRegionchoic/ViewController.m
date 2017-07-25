//
//  ViewController.m
//  HeliosRegionchoic
//
//  Created by beyo-zhaoyf on 2017/7/25.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import "ViewController.h"
#import "PickerPlaceViewHeader.h"
@interface ViewController ()<PickerPlaceDelegate,PlaceViewMenuDelegate>
@property (nonatomic,strong)PlaceViewMenu *menuView;
@property (nonatomic,strong)PickPlaceView *placeView;

@property (nonatomic, strong) NSMutableArray * placeArr;

@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger districtIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     self.navigationItem.title = @"选择地区";
    [self setDataSource];
    [self makeUI];
}
- (void)setDataSource {
    _provinceIndex = 0;
    _cityIndex = 0;
    _districtIndex = 0;
    
    
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Place" ofType:@"plist"]];
    NSLog(@"%@", dic);
    NSArray * provinceArr = dic[@"province"];
    
    for (int i = 0; i < provinceArr.count; i++) {
        
        NSDictionary * provinceDic = provinceArr[i];
        Province * province = [[Province alloc] init];
        province.province = provinceDic[@"province"];
    
        NSArray * cityArr = provinceDic[@"city"];
        for (int j = 0; j < cityArr.count; j++) {
            
            NSDictionary * cityDic = cityArr[j];
            City * city = [[City alloc] init];
            city.city = cityDic[@"city"];
            
            NSArray * districtArr = cityDic[@"district"];
            for (int k = 0; k < districtArr.count; k++) {
                
                District * district = [[District alloc] init];
                district.district = districtArr[k];
                [city.districtArr addObject:district];
            }
            [province.cityArr addObject:city];
        }
        
        [self.placeArr addObject:province];
    }
    
    Province * province = _placeArr.firstObject;
    City * city = province.cityArr.firstObject;
    District * district = city.districtArr.firstObject;    
    [self.menuView configViewWithProvince:province.province city:city.city district:district.district];
    
}
- (void)makeUI {
    [self.view addSubview:self.placeView];
    [self.view addSubview:self.menuView];
    _placeView.hidden = YES;
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(@64);
    }];
    
    [self.placeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(self.menuView.mas_bottom);
        make.bottom.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
    }];

}
#pragma mark pickViewDelegate
- (void)menuView:(PlaceViewMenu *)menuView didSelectAtIndex:(NSInteger)index isShow:(BOOL)isShow {
    if(index == 0){
        if (isShow){
             _placeView.hidden = NO;
            NSMutableArray * provinceArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.placeArr.count; i++) {
                Province * province = _placeArr[i];
                [provinceArr addObject:province.province];
            }
            NSLog(@"provinceArr==%@",provinceArr);
            [_placeView reloadViewWithDataSource:provinceArr component:0];
        }else{
            [_placeView hiddenView];
        }
    }else if (index == 1){
        if(isShow){
            _placeView.hidden = NO;
            Province * province = _placeArr[_provinceIndex];
            NSMutableArray * cityArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < province.cityArr.count; i++) {
                
                City * city = province.cityArr[i];
                [cityArr addObject:city.city];
            }
             NSLog(@"cityArr==%@",cityArr);
            [_placeView reloadViewWithDataSource:cityArr component:1];
        }else{
            [_placeView hiddenView];
        }
    }else{
        if(isShow){
            _placeView.hidden = NO;
            Province * province = _placeArr[_provinceIndex];
            City * city = province.cityArr[_cityIndex];
            NSMutableArray * districtArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < city.districtArr.count; i++) {
                District * district = city.districtArr[i];
                [districtArr addObject:district.district];
            }
            NSLog(@"districtArr==%@",districtArr);
            [_placeView reloadViewWithDataSource:districtArr component:2];
        }else{
            [_placeView hiddenView];
        }
    }
}
- (void)placeView:(PickPlaceView *)placeView didSelectPlace:(NSString *)place atComponent:(NSInteger)component atRow:(NSInteger)row {
    if (component == 0){
        if (_provinceIndex != row){
            _provinceIndex = row;
            _cityIndex = 0;
            _districtIndex = 0;
            Province * province = _placeArr[row];
            City * city = province.cityArr.firstObject;
            District * district = city.districtArr.firstObject;
            [_menuView configViewWithProvince:place city:city.city district:district.district];
        }
    }else if (component == 1){
        if (_cityIndex != row) {
            
            _cityIndex = row;
            _districtIndex = 0;
            Province * province = _placeArr[_provinceIndex];
            City * city = province.cityArr[row];
            District * district = city.districtArr.firstObject;
            [_menuView configViewWithProvince:nil city:place district:district.district];
        }
    }else{
        if (_districtIndex != row) {
            
            _districtIndex = row;
            [_menuView configViewWithProvince:nil city:nil district:place];
        }
    }
     [_menuView reset];
}
#pragma mark - setter and getter

- (PlaceViewMenu *)menuView {
    
    if (!_menuView) {
        
        _menuView = [[PlaceViewMenu alloc] init];
        _menuView.delegate = self;
    }
    return _menuView;
}

- (PickPlaceView *)placeView {
    
    if (!_placeView) {
        
        _placeView = [[PickPlaceView alloc] init];
        _placeView.delegate = self;
    }
    return _placeView;
}

- (NSMutableArray *)placeArr {
    
    if (!_placeArr) {
        
        _placeArr = [[NSMutableArray alloc] init];
    }
    return _placeArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
