//
//  ConfirmPayVC.m
//  DiscountClass
//
//  Created by Cary on 2019/6/3.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "ConfirmPayVC.h"
#import "ThirdLibsHeader.h"
#import "PayOrderOneCell.h"
#import "PayOrderTwoCell.h"
#import "PayResultVC.h"
#import "BankModel.h"
#import "PayOrderVC.h"
#import <LocalAuthentication/LocalAuthentication.h>

NSString *const xPayOneCell = @"PayOneCell";
NSString *const xPayTwoCell = @"PayTwoCell";

@interface ConfirmPayVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIView *userHeaderView;
@property (nonatomic,strong) BankInfoModel *model;
@property (nonatomic,strong) MBProgressHUD *HUD;

@end

@implementation ConfirmPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"支付订单";
    
    [self createUI];
    [self bottomView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
     [self GetAlinSignInfo];
    
}

- (void)createUI {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableHeaderView = self.userHeaderView;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mainTableView registerClass:[PayOrderOneCell class] forCellReuseIdentifier:xPayOneCell];
     [_mainTableView registerClass:[PayOrderTwoCell class] forCellReuseIdentifier:xPayTwoCell];
    [self.view addSubview:_mainTableView];
}

- (void)bottomView {
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"确认支付" forState:0];
    [nextButton setTitleColor:[UIColor whiteColor] forState:0];
    nextButton.backgroundColor = [UIColor colorWithHexString:@"#ff694e"];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [nextButton addTarget:self action:@selector(gotoPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
        make.width.mas_equalTo(xScreenWidth);
        make.height.mas_equalTo(44);
    }];
}

- (UIView *)userHeaderView {
    
    if (!_userHeaderView) {
        
        _userHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 182)];
        UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 150)];
        bgView.image = [UIImage imageNamed:@"payBanner"];
        [_userHeaderView addSubview:bgView];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.text = @"订单金额（元）";
        [bgView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).offset(40);
            make.centerX.equalTo(bgView.mas_centerX);
        }];
        
        UILabel *priceLabel = [[UILabel alloc]init];
        priceLabel.textColor = [UIColor whiteColor];
        priceLabel.font = [UIFont boldSystemFontOfSize:44];
        priceLabel.text = [NSString stringWithFormat:@"￥%@",_orderPrice];
        [bgView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(11);
            make.centerX.equalTo(bgView.mas_centerX);
        }];
        
        UIView *tipView = [[UIView alloc]init];
        tipView.backgroundColor = [UIColor colorWithHexString:@"#fff7e7"];
        [_userHeaderView addSubview:tipView];
        [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(xScreenWidth);
            make.height.mas_equalTo(32);
            make.top.equalTo(bgView.mas_bottom);
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
        tipLabel.text = @"请在30分钟内完成支付";
        [tipView addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(tipView.mas_centerY);
            make.left.mas_equalTo(tipIcon.mas_right).offset(7);
        }];
        
    }
    
    return _userHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.model) {
        return 2;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        PayOrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:xPayOneCell];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        PayOrderTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:xPayTwoCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定解绑此张银行卡并绑定新卡么？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
           [self UnsignRequest];
            
        }]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertController animated:YES completion:nil];
        });
   
    }
}

- (void)gotoPay {
    
//    PayResultVC *vc = [[PayResultVC alloc]init];
//    vc.bankNo = self.model.accountNo;
//    [self.navigationController pushViewController:vc animated:YES];
    
    [self fingerVerification];
}

- (void)payOrderRequest {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [parameter setValue:self.orderIds forKey:@"orderIds"];
    
    [HttpRequestManager postWithUrlString:PayOrder parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        
        if ([responseObject[@"success"] boolValue] == YES) {
            
            PayResultVC *vc = [[PayResultVC alloc]init];
            vc.payResult = YES;
            vc.bankNo = self.model.accountNo;
            vc.msg = self.orderPrice;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            PayResultVC *vc = [[PayResultVC alloc]init];
            vc.payResult = NO;
            vc.bankNo = self.model.accountNo;
            vc.msg = responseObject[@"msg"];
            [self.navigationController pushViewController:vc animated:YES];
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
        
        BankModel *basedata = [[BankModel alloc]initWithDic:responseObject];
        if (basedata.success == YES) {
            
            self.model = [[BankInfoModel alloc]initWithDic:basedata.data];
            [self.mainTableView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)UnsignRequest {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [parameter setValue:self.model.accountNo  forKey:@"accountNo"];
    [HttpRequestManager postWithUrlString:UnSignRequest parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        if ([responseObject[@"success"] boolValue] == YES) {
            PayOrderVC *vc = [[PayOrderVC alloc]init];
            vc.theType = FromOldBind;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)fingerVerification
{
    if ([UIDevice currentDevice].systemVersion.floatValue<9.0) {
        NSLog(@"ios9.0以后才支持指纹识别");
        return;
    }
    //IOS11之后如果支持faceId也是走同样的逻辑，faceId和TouchId只能选一个
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        //支持 localizedReason为alert弹框的message内容
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"请验证已有指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证通过");
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    //用户选择输入密码，切换主线程处理
                    NSLog(@"用户选择输入密码，切换主线程处理");
                    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    [self.view addSubview:self.HUD];
                    self.HUD.mode = MBProgressHUDModeCustomView;
                    self.HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"successTipIcon"]];
                    self.HUD.label.text = @"验证通过";
                    self.HUD.label.textColor = [UIColor whiteColor];
                    self.HUD.bezelView.backgroundColor = [UIColor colorWithHexString:@"#999999"];
                   [self.HUD hideAnimated:YES afterDelay:1];
                 //  [self payOrderRequest];
    
                }];
                
            } else {
                NSLog(@"验证失败:%@",error.description);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"系统取消授权，如其他APP切入");
                        //系统取消授权，如其他APP切入
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        //用户取消验证Touch ID
                        NSLog(@"用户取消验证Touch ID");
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        //授权失败
                        NSLog(@"授权失败");
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        //系统未设置密码
                        NSLog(@"系统未设置密码");
                        break;
                    }
                    case LAErrorBiometryNotAvailable:
                    {
                        //设备Touch ID不可用，例如未打开
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        break;
                    }
                    case LAErrorBiometryNotEnrolled:
                    {
                        //设备Touch ID不可用，用户未录入
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                            NSLog(@"用户选择输入密码，切换主线程处理");
                            
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
            }
        }];
    } else {
        NSLog(@"不支持指纹识别");
        NSLog(@"error : %@",error.localizedDescription);
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
