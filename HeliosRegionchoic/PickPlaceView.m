//
//  PickPlaceView.m
//  HeliosRegionchoic
//
//  Created by beyo-zhaoyf on 2017/7/25.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import "PickPlaceView.h"
#define Cell_Place @"Cell_Place"
#define CellHeight 44
@interface PickPlaceView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)float kWidth;
@property (nonatomic,assign)float kHeight;

@end
@implementation PickPlaceView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self makeUI];
    }
    return self;
}
- (void)makeUI {
    [self addSubview:self.aTableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _kWidth = self.bounds.size.width;
    _kHeight = self.bounds.size.height;
}
#pragma mark public Method

- (void)reloadViewWithDataSource:(NSArray *)dataArr component:(NSUInteger )component {
    _index = component;
    self.dataSource = [NSMutableArray arrayWithArray:dataArr];
    float height = _dataSource.count *44;
    
//    (_kHeight - height) > 0 ? (_aTableView.frame = CGRectMake(0, -height, _kWidth, height)) : (_aTableView.frame = CGRectMake(0, -_kHeight, _kWidth, _kHeight));
    if (_kHeight - height > 0) {
        
        _aTableView.frame = CGRectMake(0, -height, _kWidth, height);
    } else {
        
        _aTableView.frame = CGRectMake(0, -_kHeight, _kWidth, _kHeight);
    }

    [_aTableView reloadData];
    [self show];
}
#pragma mark touch event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(placeViewDidHidden)]){
        [self.delegate placeViewDidHidden];
    }
    [self hiddenView];
}
#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Cell_Place forIndexPath:indexPath];
    
    if (indexPath.row < self.dataSource.count) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = self.dataSource[indexPath.row];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *place = _dataSource[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(placeView:didSelectPlace:atComponent:atRow:)]){
        [self.delegate placeView:self didSelectPlace:place atComponent:_index atRow:indexPath.row];
    }
        [self hiddenView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offset = scrollView.contentOffset.y;
    if(offset < 0){
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}
#pragma mark private method
- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = Color_RGB_Alpha(0, 0, 0, 0.3);
         _aTableView.frame = CGRectMake(0, 0, _kWidth, _aTableView.bounds.size.height);
    }];
}
- (void)hiddenView {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = Color_RGB_Alpha(0, 0, 0, 0);
        _aTableView.frame = CGRectMake(0, -_kHeight, _kWidth, _kHeight);
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
#pragma mark getter setter
- (UITableView *)aTableView {
    if(!_aTableView){
        _aTableView = [[UITableView alloc] init];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
        _aTableView.backgroundColor = Color_RGB_Alpha(0, 0, 0, 0);
      //  _aTableView.backgroundColor = HeliosRandomColor;
        [_aTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Cell_Place];
        _aTableView.tableFooterView = [[UIView alloc] init];
    }
    return _aTableView;
}

- (NSMutableArray *)dataSource {
    if(!_dataSource){
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
@end
