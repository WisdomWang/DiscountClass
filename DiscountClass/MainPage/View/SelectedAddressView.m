//
//  SelectedAddressView.m
//  DiscountClass
//
//  Created by Cary on 2019/5/16.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "SelectedAddressView.h"
#import "ThirdLibsHeader.h"


NSString *const xSelectedAddressCell = @"SelectedAddressCell";

@interface SelectedAddressView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SelectedAddressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
        self.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.5];;
        self.addressArr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)createViews {
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(xScreenWidth);
        make.height.mas_equalTo(300);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"选择地址";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.top.mas_equalTo(bgView.mas_top).offset(10);
        make.width.mas_equalTo(200);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"alertBack"] forState:0];
    [button addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label.mas_centerY);
        make.right.mas_equalTo(bgView.mas_right).offset(-15);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, xScreenWidth, self.frame.size.height-20) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [bgView addSubview:_mainTableView];
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:xSelectedAddressCell];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.addressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressListDetailModel *m = _addressArr[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xSelectedAddressCell];
    cell.textLabel.text = m.address;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressListDetailModel *m = _addressArr[indexPath.row];
    self.selectedBlock(m);
}

- (void)popBack {
    
    self.popBackBlock();
}

@end
