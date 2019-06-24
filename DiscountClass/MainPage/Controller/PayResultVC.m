

//
//  PayResultVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/20.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "PayResultVC.h"
#import "ThirdLibsHeader.h"

NSString *const xPayResultCell = @"PayResultCell";

@interface PayResultVC ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSArray *labelTextArr;
    NSArray *detailTextArr;
    
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIView *userHeaderView;
@property (nonatomic,strong) UIView *userFooterView;

@end

@implementation PayResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"支付成功";
    
    NSString *behindStr = [_bankNo substringFromIndex:_bankNo.length-4];
    NSString *str = [NSString stringWithFormat:@"银行储蓄卡%@快捷支付",behindStr];
    
    labelTextArr = @[@"支付方式"];
    detailTextArr = @[str];
    
    [self createUI];
}

- (void)createUI {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = self.userFooterView;
    _mainTableView.tableHeaderView = self.userHeaderView;
    [self.view addSubview:_mainTableView];
}

- (UIView *)userHeaderView {
    
    if (!_userHeaderView) {
        
        _userHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 240)];
        
        UIImageView *successImg = [[UIImageView alloc]init];
        successImg.image = [UIImage imageNamed:@"successImg"];
        [_userHeaderView addSubview:successImg];
        [successImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userHeaderView).offset(24);
            make.centerX.equalTo(self.userHeaderView.mas_centerX);
        }];
        if (_payResult == YES) {
            successImg.image = [UIImage imageNamed:@"successImg"];
        } else {
            successImg.image = [UIImage imageNamed:@"failedImg"];
        }
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor colorWithHexString:@"#25bb06"];
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        titleLabel.text = @"支付成功";
        [_userHeaderView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(successImg.mas_bottom).offset(16);
            make.centerX.equalTo(successImg.mas_centerX).offset(10);
        }];
        
        if (_payResult == YES) {
            titleLabel.text = @"支付成功";
            titleLabel.textColor = [UIColor colorWithHexString:@"#25bb06"];
        } else {
           titleLabel.text = @"支付失败";
            titleLabel.textColor = [UIColor colorWithHexString:@"#ff694e"];
        }
        
        UIImageView *successIcon = [[UIImageView alloc]init];
        successIcon.image = [UIImage imageNamed:@"successIcon"];
        [_userHeaderView addSubview:successIcon];
        [successIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(successImg.mas_bottom).offset(16);
            make.right.equalTo(titleLabel.mas_left).offset(-12);
        }];
        
        if (_payResult == YES) {
            successIcon.image = [UIImage imageNamed:@"successIcon"];
        } else {
            successIcon.image = [UIImage imageNamed:@"failedIcon"];
        }
        
        UILabel *priceLabel = [[UILabel alloc]init];
        priceLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        priceLabel.font = [UIFont boldSystemFontOfSize:30];
        priceLabel.text = @"21600.00";
        [_userHeaderView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(successImg.mas_centerX);
            make.bottom.equalTo(self.userHeaderView.mas_bottom).offset(-24);
        }];
        
        if (_payResult == YES) {
            priceLabel.text = [NSString stringWithFormat:@"￥%@",_msg];
        } else {
            priceLabel.text = _msg;
        }
    }
    
    return _userHeaderView;
}

- (UIView *)userFooterView {
    if (!_userFooterView) {
        _userFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 92)];
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setTitle:@"完成" forState:0];
        [nextButton setTitleColor:[UIColor whiteColor] forState:0];
        nextButton.backgroundColor = [UIColor colorWithHexString:@"#ff694e"];
        nextButton.titleLabel.font = [UIFont systemFontOfSize:17];
        nextButton.layer.cornerRadius = 22;
        [nextButton addTarget:self action:@selector(gotoSuccess) forControlEvents:UIControlEventTouchUpInside];
        [_userFooterView addSubview:nextButton];
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userFooterView.mas_top).offset(48);
            make.centerX.equalTo(self.userFooterView.mas_centerX);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(44);
        }];
        
        if (_payResult == YES) {
            
            [nextButton setTitle:@"完成" forState:0];
         
        } else {
           
            [nextButton setTitle:@"重新操作" forState:0];
        }
        
    }
    
    return _userFooterView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return labelTextArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xPayResultCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:xPayResultCell];
    }
    cell.textLabel.text = labelTextArr[indexPath.row];
    cell.detailTextLabel.text = detailTextArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font =[UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    return cell;
}

- (void)gotoSuccess {
    
    if (_payResult == YES) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
