

//
//  ConfirmOrderVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/16.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "ConfirmOrderVC.h"
#import "ThirdLibsHeader.h"
#import "PayOrderVC.h"
#import "ConfirmPayVC.h"

NSString *const xConfirmOrderCell = @"ConfirmOrderCell";

@interface ConfirmOrderVC ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSArray *labelTextArr;
    NSArray *detailTextArr;
    
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIView *userHeaderView;
@property (nonatomic,strong) NSMutableArray *orderIds;

@end

@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"确认订单";
    labelTextArr = @[@"课程所属机构",@"购买数量",@"快捷支付"];
    detailTextArr = @[_m.eduName,@"1",@"银联在线支付服务"];
    
    [self createUI];

}

- (void)createUI {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight-82) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.tableHeaderView = self.userHeaderView;
    [self.view addSubview:_mainTableView];
    
    [self createBottomView];
}

- (void)createBottomView {
    
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
        make.height.mas_equalTo(50);
        
    }];
    
    UIView *tipView = [[UIView alloc]init];
    tipView.backgroundColor = [UIColor colorWithHexString:@"#fff7e7"];
    [self.view addSubview:tipView];
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.equalTo(self.view);
         make.bottom.equalTo(bottomView.mas_top);
        make.height.mas_equalTo(32);
    }];
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payButton setTitle:@"提交订单" forState:0];
    [payButton setTitleColor:[UIColor whiteColor] forState:0];
    payButton.backgroundColor = [UIColor colorWithHexString:@"#ff410e"];
    payButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [bottomView addSubview:payButton];
    [payButton addTarget:self action:@selector(confirmOrderClick) forControlEvents:UIControlEventTouchUpInside];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(bottomView.mas_right);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.textColor = [UIColor colorWithHexString:@"#ffle00"];
    priceLabel.font = [UIFont systemFontOfSize:24];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",_orderPrice];
    [bottomView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.mas_equalTo(bottomView.mas_left).offset(17);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [bottomView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_bottom);
        make.width.mas_equalTo(xScreenWidth);
        make.height.mas_equalTo(1);
    }];
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [bottomView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top);
        make.width.mas_equalTo(xScreenWidth);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *tipIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tipIcon"]];
    [tipView addSubview:tipIcon];
    [tipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(tipView.mas_centerY);
        make.left.equalTo(tipView.mas_left).offset(17);
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.textColor = [UIColor colorWithHexString:@"#ff6600"];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.text = @"请仔细核对上课地点及课程名称";
    [tipView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tipView.mas_centerY);
        make.left.mas_equalTo(tipIcon.mas_right).offset(7);
    }];
}

- (UIView *)userHeaderView {
    
    if (!_userHeaderView) {
        
        _userHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 180)];
        UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 180)];
        bgView.image = [UIImage imageNamed:@"ConfirmOrderTop"];
        [_userHeaderView addSubview:bgView];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:22];
        titleLabel.text = _m.courseName;
        titleLabel.numberOfLines = 0;
        [bgView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).offset(50);
            make.left.equalTo(bgView.mas_left).offset(17);
            make.right.equalTo(bgView.mas_right).offset(-17);
        }];
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.font = [UIFont boldSystemFontOfSize:12];
        timeLabel.text = @"开课时间：请咨询机构";
        [bgView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(11);
            make.left.equalTo(titleLabel.mas_left);
        }];
        
        UILabel *addressLabel = [[UILabel alloc]init];
        addressLabel.textColor = [UIColor whiteColor];
        addressLabel.font = [UIFont boldSystemFontOfSize:12];
        addressLabel.numberOfLines = 0;
        addressLabel.text = _addressModel.address;
        [bgView addSubview:addressLabel];
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeLabel.mas_bottom).offset(11);
            make.left.equalTo(titleLabel.mas_left);
            make.right.equalTo(bgView.mas_right).offset(-17);
        }];
        
    }
    
    return _userHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xConfirmOrderCell];
    if (indexPath.row == 2) {
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:xConfirmOrderCell];
        }
        
        cell.imageView.image = [UIImage imageNamed:@"UnionPayIcon"];
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectedIcon"]];
        cell.textLabel.font =[UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#a9a9a9"];
        
    } else {
        
        if (!cell) {
          cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:xConfirmOrderCell];
        }
        cell.textLabel.font =[UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#515151"];
    }
    cell.textLabel.text = labelTextArr[indexPath.row];
    cell.detailTextLabel.text = detailTextArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)confirmOrderClick {
    
    NSMutableArray *courseIds = [[NSMutableArray alloc]init];
    [courseIds addObject:_addressModel.courseId];
    [self createOrder:courseIds];
}

- (void)createOrder:(NSMutableArray *)courseIds {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [parameter setValue:@(1) forKey:@"clientType"];
    [parameter setValue:@"" forKey:@"note"];
    [parameter setValue:@(true) forKey:@"isAlone"];
    [parameter setValue:courseIds forKey:@"courseIds"];
    [HttpRequestManager postWithUrlString:CreateCourseOrder parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        
        if ([responseObject[@"success"] boolValue] == YES) {

            self.orderIds = responseObject[@"data"];
            
            [self GetAlinSignInfo];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSDictionary *dic = error.userInfo;
        NSString *str = dic[@"NSLocalizedDescription"];
        [TipsView showCenterTitle:str duration:1 completion:nil];
        
    }];
}

- (void)GetAlinSignInfo {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [HttpRequestManager postWithUrlString:GetAllinSignInfo parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        
        if ([responseObject[@"success"] boolValue] == YES) {
            
            ConfirmPayVC *vc = [[ConfirmPayVC alloc]init];
            vc.orderPrice = self.orderPrice;
            vc.orderIds = self.orderIds;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            
            PayOrderVC *vc= [[PayOrderVC alloc]init];
            vc.orderPrice = self.orderPrice;
            vc.orderIds = self.orderIds;
            vc.theType = FromNewBind;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
