//
//  OrderDetailVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/8.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "OrderDetailVC.h"
#import "ThirdLibsHeader.h"
#import "ConfirmCartCell.h"
#import "PayOrderVC.h"
#import "CartModel.h"
#import "ConfirmPayVC.h"

NSString *const xConfirmCartCell = @"ConfirmCartCell";
NSString *const xConfirmCartTwoCell = @"ConfirmCartTwoCell";

@interface OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>  {
    
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

@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"确认订单";
    
    labelTextArr = @[@"快捷支付",@"学费分期",@"微信支付",@"支付宝支付",@"信用卡分期",@"京东白条"];
    detailTextArr = @[@"银联在线支付服务",@"惠学习学费分期",@"微信安全支付",@"支付宝安全支付",@"银联在线支付服务",@"京东白条支付"];
    imgArr = @[@"UnionPayIcon",@"huiPayIcon",@"weixinPayIcon",@"aliPayIcon",@"stagesPayIcon",@"jdPayIcon"];
    canPay = YES;
    [self createUI];
}

- (void)createUI {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight-82-xTabbarSafeBottomMargin) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableHeaderView = self.userHeaderView;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.estimatedRowHeight = 200;
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    [_mainTableView registerClass:[ConfirmCartCell class] forCellReuseIdentifier:xConfirmCartCell];
    [self.view addSubview:_mainTableView];
    [self createBottomView];
}

- (void)createBottomView {
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
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
        
        _userHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 20)];
        
    }
    
    return _userHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return _selectedArr.count;
    } else {
        return labelTextArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return  0;
    } else {
        return  44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat height;
    
    if (section == 0) {
        height = 0;
    } else {
        height = 44;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, height)];
    view.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    
    UILabel * headerLabel = [[UILabel alloc] init];
    headerLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    [view addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(view.mas_left).offset(17);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(height);
    }];
    
    UILabel * numLabel = [[UILabel alloc] init];
    numLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    numLabel.font = [UIFont boldSystemFontOfSize:12];
    numLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.right.equalTo(view.mas_right).offset(-17);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(height);
    }];
    
    if (section == 0) {
        headerLabel.text = @"";
        numLabel.text = @"";
    } else {
        headerLabel.text = @"购买数量";
        numLabel.text = [NSString stringWithFormat:@"%ld",_selectedArr.count];
    }
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        CartLessonModel *m = _selectedArr[indexPath.row];
        ConfirmCartCell *cell = [tableView dequeueReusableCellWithIdentifier:xConfirmCartCell];
        cell.model = m;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xConfirmCartTwoCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:xConfirmCartTwoCell];
         
        }
        cell.imageView.image = [UIImage imageNamed:imgArr[indexPath.row]];
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"unSelectedIcon"]];
        cell.textLabel.font =[UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#a9a9a9"];
        cell.textLabel.text = labelTextArr[indexPath.row];
        cell.detailTextLabel.text = detailTextArr[indexPath.row];
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
        
        return cell;
    }

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
    
    NSMutableArray *selectedArr = [[NSMutableArray alloc]init];
    for (CartLessonModel *m in _selectedArr) {
        [selectedArr addObject:m.courseId];
    }
    [self createOrder:selectedArr];
}

- (void)createOrder:(NSMutableArray *)courseIds {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [parameter setValue:courseIds forKey:@"courseIds"];
    [parameter setValue:@(false) forKey:@"isAlone"];
    [parameter setValue:@(1) forKey:@"clientType"];
    [parameter setValue:@"" forKey:@"note"];
    
    [HttpRequestManager postWithUrlString:CreateCourseOrder parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        if ([responseObject[@"success"] boolValue] == YES) {
            self.orderIds = responseObject[@"data"];
            [self getAlinSignInfo];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)getAlinSignInfo {
    
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
            vc.theType =FromNewBind;
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
