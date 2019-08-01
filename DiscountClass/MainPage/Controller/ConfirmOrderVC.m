

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
    NSArray *imgArr;
    BOOL canPay;
    
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIView *userHeaderView;
@property (nonatomic,strong) NSMutableArray *orderIds;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;

@end

@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"确认订单";
    labelTextArr = @[@"课程所属机构",@"购买数量",@"快捷支付",@"学费分期",@"民生银行信用卡分期",@"微信支付",@"支付宝支付",@"京东白条"];
    detailTextArr = @[_m.eduName,@"1",@"银联在线支付服务",@"惠学习学费分期",@"银联在线支付服务",@"微信安全支付",@"支付宝安全支付",@"京东白条支付"];
    imgArr = @[@"",@"",@"UnionPayIcon",@"huiPayIcon",@"minshengPayIcon",@"weixinPayIcon",@"aliPayIcon",@"jdPayIcon"];
    canPay = YES;
    
    [self createUI];

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [TipsView dismiss];
}

- (void)createUI {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight-82-xTabbarSafeBottomMargin) style:UITableViewStylePlain];
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    } else {
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor colorWithHexString:@"#515151"];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    [view addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(view.mas_left).offset(15);
    }];
    
    if (section == 0) {
        headerLabel.text = @"";
    }
    else if (section == 1) {
        headerLabel.text = @"选择支付方式";
    }
    else {
        headerLabel.text = @"其他支付方式";
    }
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0) {
        return 2;
    }
    else if (section == 1) {
        return 2;
    }
    else {
        return 4;
    }
    
   // return labelTextArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xConfirmOrderCell];
    if (indexPath.section ==0) {
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:xConfirmOrderCell];
        }
        cell.textLabel.font =[UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        
        cell.textLabel.text = labelTextArr[indexPath.row];
        cell.detailTextLabel.text = detailTextArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:xConfirmOrderCell];
        }
        
        cell.imageView.image = [UIImage imageNamed:imgArr[indexPath.row+indexPath.section*2]];
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"unSelectedIcon"]];
        cell.textLabel.font =[UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#a9a9a9"];
        
        cell.textLabel.text = labelTextArr[indexPath.row+indexPath.section*2];
        cell.detailTextLabel.text = detailTextArr[indexPath.row+indexPath.section*2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath == _selectedIndexPath) {
            cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectedIcon"]];
        } else {
            cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"unSelectedIcon"]];
        }
        if (!_selectedIndexPath) {
            if (indexPath.section == 1 && indexPath.row == 0) {
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectedIcon"]];
            }
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section != 0) {
        
        _selectedIndexPath = indexPath;
        if (indexPath.section ==1 && indexPath.row ==0) {
            canPay = YES;
        }
        else {
            canPay = NO;
        }
        [self.mainTableView reloadData];
    }
    
}

- (void)confirmOrderClick {
    
    if (canPay == NO) {
        [self alertViewWithMessage:@"暂不支持该付款方式~" cancelTitle:@"知道了"];
        return;
    }
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
        }  else {
            
            NSString *msg = responseObject[@"msg"];
            [TipsView showCenterTitle:msg duration:1 completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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

- (void)alertViewWithMessage:(NSString *)message cancelTitle:(NSString *)title {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
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
