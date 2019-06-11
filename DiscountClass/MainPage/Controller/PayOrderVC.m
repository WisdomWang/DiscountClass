//
//  PayOrderVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/16.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "PayOrderVC.h"
#import "ThirdLibsHeader.h"
#import "bindInfoPayCell.h"
#import "PayResultVC.h"
#import "ConfirmPayVC.h"

NSString *const xBindInfoPayCell = @"BindInfoPayCell";

@interface PayOrderVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    
    NSArray *labelTextArr;
    NSArray *detailTextArr;
    
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIView *userFooterView;
@property (nonatomic,strong) NSMutableDictionary *infoDic;
@property (nonatomic,strong) NSString *srcreqsn;

@end 

@implementation PayOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"绑定银行卡";
    
    _infoDic = [[NSMutableDictionary alloc]init];
    
    labelTextArr = @[@"姓名",@"身份证号",@"银行卡号",@"预留手机",@"验证码"];
    detailTextArr = @[@"请输入您的真实姓名",@"请输入您的身份证号",@"请输入您的银行卡号",@"请输入银行预留手机",@"请输入短信验证码"];
    
    [self createUI];
}

- (void)createUI {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = self.userFooterView;
    _mainTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 20)];
    [_mainTableView registerClass:[bindInfoPayCell class] forCellReuseIdentifier:xBindInfoPayCell];
    [self.view addSubview:_mainTableView];
}

- (UIView *)userFooterView {
    if (!_userFooterView) {
        _userFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 129)];
        
        UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectedButton setImage:[UIImage imageNamed:@"unSelectedIconXieyi"] forState:UIControlStateNormal];
        [selectedButton addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
        [_userFooterView addSubview:selectedButton];
        [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userFooterView.mas_top).offset(17);
            make.left.equalTo(self.userFooterView.mas_left).offset(17);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *agreementLabel = [[UILabel alloc]init];
        agreementLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        agreementLabel.font = [UIFont systemFontOfSize:13];
        agreementLabel.text = @"已同意惠学习与通联";
        [_userFooterView addSubview:agreementLabel];
        [agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(selectedButton.mas_centerY);
            make.left.equalTo(selectedButton.mas_right).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UIButton *agreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [agreementButton setTitle:@"《用户服务协议》" forState:0];
        [agreementButton setTitleColor:[UIColor colorWithHexString:@"#6a7fa6"] forState:0];
        agreementButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [agreementButton addTarget:self action:@selector(gotoAgreement) forControlEvents:UIControlEventTouchUpInside];
        [_userFooterView addSubview:agreementButton];
        [agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(selectedButton.mas_centerY);
            make.left.equalTo(agreementLabel.mas_right);
            make.height.mas_equalTo(20);
            
        }];
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setTitle:@"确认绑定" forState:0];
        [nextButton setTitleColor:[UIColor whiteColor] forState:0];
        nextButton.backgroundColor = [UIColor colorWithHexString:@"#ff694e"];
        nextButton.titleLabel.font = [UIFont systemFontOfSize:17];
        nextButton.layer.cornerRadius = 22;
        [nextButton addTarget:self action:@selector(gotoSuccess) forControlEvents:UIControlEventTouchUpInside];
        [_userFooterView addSubview:nextButton];
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userFooterView.mas_top).offset(85);
            make.centerX.equalTo(self.userFooterView.mas_centerX);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(44);
        }];
        
    }
    
    return _userFooterView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return labelTextArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    bindInfoPayCell *cell = [tableView dequeueReusableCellWithIdentifier:xBindInfoPayCell];
    cell.label.text = labelTextArr[indexPath.row];
    cell.textField.placeholder = detailTextArr[indexPath.row];
    cell.textField.delegate = self;
    cell.textField.tag = 800+indexPath.row;
    if (indexPath.row == 3) {
        cell.sendCodeButton.hidden = NO;
    } else {
        cell.sendCodeButton.hidden = YES;
    }
    cell.sendCodeBlock = ^(UIButton * _Nonnull button) {
        
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        if (xNullString([self.infoDic valueForKey:@"accountName"])) {
            [TipsView showCenterTitle:@"请输入您的真实姓名" duration:1 completion:nil];
            return;
        }
        else if (xNullString([self.infoDic valueForKey:@"idNo"])) {
            
            [TipsView showCenterTitle:@"请输入您的身份证号" duration:1 completion:nil];
            return;
        }
        else if (xNullString([self.infoDic valueForKey:@"accountNo"])) {
            
            [TipsView showCenterTitle:@"请输入您的银行卡号" duration:1 completion:nil];
            return;
        }
        else if (xNullString([self.infoDic valueForKey:@"tel"])) {
            
            [TipsView showCenterTitle:@"请输入银行预留手机" duration:1 completion:nil];
            return;
        }
        
        [self openCountdown:button];
        [self GetSignCode];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)gotoSuccess {
    
    if (xNullString([self.infoDic valueForKey:@"accountName"])) {
        [TipsView showCenterTitle:@"请输入您的真实姓名" duration:1 completion:nil];
        return;
    }
    else if (xNullString([self.infoDic valueForKey:@"idNo"])) {
        
        [TipsView showCenterTitle:@"请输入您的身份证号" duration:1 completion:nil];
        return;
    }
    else if (xNullString([self.infoDic valueForKey:@"accountNo"])) {
        
        [TipsView showCenterTitle:@"请输入您的银行卡号" duration:1 completion:nil];
        return;
    }
    else if (xNullString([self.infoDic valueForKey:@"tel"])) {
        
        [TipsView showCenterTitle:@"请输入银行预留手机" duration:1 completion:nil];
        return;
    }
    
    else if (xNullString([self.infoDic valueForKey:@"vercode"])) {
        
        [TipsView showCenterTitle:@"请输入短信验证码" duration:1 completion:nil];
        return;
    }
    
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    [self VerifySignCode];
    
}

- (void)changeStatus:(UIButton *)button {
    
    if (button.selected) {
        
         [button setImage:[UIImage imageNamed:@"unSelectedIconXieyi"] forState:UIControlStateNormal];
    } else {
        [button setImage:[UIImage imageNamed:@"selectedIconXieyi"] forState:UIControlStateNormal];
    }
    
    button.selected = !button.selected;
    
}

- (void)gotoAgreement {
    
    
}

- (void)openCountdown:(UIButton *)button {
    
    // 倒计时时间
    __block NSInteger time = 59;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        // 倒计时结束，关闭
        if (time <= 0) {
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 设置按钮的样式
                [button setTitle:@"重新获取" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithHexString:@"#ff410e"] forState:0];
                button.userInteractionEnabled = YES;
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
                [self.mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            });
            
        } else {
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置按钮显示读秒效果
                [button setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
                [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:0];
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
                [self.mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            });
            
            time--;
        }
    });
    
    dispatch_resume(_timer);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (textField.tag == 800) {
        [_infoDic setValue:textField.text forKey:@"accountName"];
    }
    else if (textField.tag == 801) {
        [_infoDic setValue:textField.text forKey:@"idNo"];
    }
    else if (textField.tag == 802) {
        [_infoDic setValue:textField.text forKey:@"accountNo"];
    }
    else if (textField.tag == 803) {
        [_infoDic setValue:textField.text forKey:@"tel"];
    }
    else if (textField.tag == 804) {
        [_infoDic setValue:textField.text forKey:@"vercode"];
    }
}

- (void)GetSignCode {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [parameter setValue:[_infoDic valueForKey:@"accountName"] forKey:@"accountName"];
    [parameter setValue:[_infoDic valueForKey:@"idNo"] forKey:@"idNo"];
    [parameter setValue:[_infoDic valueForKey:@"tel"] forKey:@"tel"];
    [parameter setValue:[_infoDic valueForKey:@"accountNo"] forKey:@"accountNo"];
    [HttpRequestManager postWithUrlString:SignApply parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        
        if ([responseObject[@"success"] boolValue] == YES) {
            
            self.srcreqsn = responseObject[@"data"][@"srcreqsn"];
        } else {
            
            NSString *msg = responseObject[@"msg"];
            [TipsView showCenterTitle:msg duration:1 completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)VerifySignCode {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [parameter setValue:_srcreqsn forKey:@"srcreqsn"];
    [parameter setValue:[_infoDic valueForKey:@"vercode"] forKey:@"vercode"];
    [HttpRequestManager postWithUrlString:SignRequest parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        
        if ([responseObject[@"success"] boolValue] == YES) {
            
            if (self.theType == FromNewBind) {
                ConfirmPayVC *vc= [[ConfirmPayVC alloc]init];
                vc.orderPrice = self.orderPrice;
                vc.orderIds = self.orderIds;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            
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
