//
//  LoginVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/21.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "LoginVC.h"
#import "ThirdLibsHeader.h"

@interface LoginVC ()

@property (nonatomic,strong) UITextField *phoneText;
@property (nonatomic,strong) UITextField *numText;
@property (nonatomic,strong) UIButton *codeButton;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)createUI {
    
    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.image = [UIImage imageNamed:@"loginLogo"];
    [self.view addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(138);
    }];
    
    _phoneText = [[UITextField alloc]init];
    _phoneText.placeholder = @"请输入手机号";
    _phoneText.textColor = [UIColor colorWithHexString:@"#333333"];
    _phoneText.font = [UIFont systemFontOfSize:14];
    _phoneText.layer.masksToBounds = YES;
    _phoneText.layer.cornerRadius = 20;
    _phoneText.layer.borderColor= [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    _phoneText.layer.borderWidth= 1.0f;
    _phoneText.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16,40)];
    _phoneText.leftViewMode=UITextFieldViewModeAlways;
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
   // _phoneText.delegate = self;
    //[_phoneText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneText];
    
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(bgImage.mas_bottom).offset(48);
        make.width.mas_equalTo(303);
        make.height.mas_equalTo(40);
    }];
    
    _numText = [[UITextField alloc]init];
    _numText.placeholder = @"请输入验证码";
    _numText.textColor = [UIColor colorWithHexString:@"#333333"];
    _numText.font = [UIFont systemFontOfSize:14];
    _numText.layer.masksToBounds = YES;
    _numText.layer.cornerRadius = 20;
    _numText.layer.borderColor= [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    _numText.layer.borderWidth= 1.0f;
    _numText.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16,40)];
    _numText.leftViewMode=UITextFieldViewModeAlways;
    _numText.keyboardType = UIKeyboardTypeNumberPad;
  //  _numText.delegate = self;
   // [_numText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_numText];
    [_numText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.phoneText.mas_bottom).offset(8);
        make.width.mas_equalTo(303);
        make.height.mas_equalTo(40);
    }];
    
   _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_codeButton setTitle:@"获取验证码" forState:0];
    [_codeButton setTitleColor:[UIColor colorWithHexString:@"#f44640"] forState:0];
    [_codeButton addTarget:self action:@selector(getCodeClicked) forControlEvents:UIControlEventTouchUpInside];
    _codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _codeButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_codeButton];
    [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.numText.mas_centerY);
        make.right.equalTo(self.phoneText.mas_right).offset(-16);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:0];
    [loginButton setTitleColor:[UIColor whiteColor] forState:0];
    loginButton.backgroundColor = [UIColor colorWithHexString:@"#f44640"];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 20;
    [loginButton addTarget:self action:@selector(gotoLogined) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.numText.mas_bottom).offset(8);
        make.width.mas_equalTo(303);
        make.height.mas_equalTo(40);
    }];
}

- (void)openCountdown {
    
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
                [self.codeButton setTitle:@"重新获取" forState:UIControlStateNormal];
                [self.codeButton setTitleColor:[UIColor colorWithHexString:@"#f44640"] forState:0];
                self.codeButton.userInteractionEnabled = YES;
            });
            
        } else {
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置按钮显示读秒效果
                [self.codeButton setTitle:[NSString stringWithFormat:@"%.2ds后重新获取", seconds] forState:UIControlStateNormal];
                self.codeButton.userInteractionEnabled = NO;
                [self.codeButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:0];
            });
            
            time--;
        }
    });
    
    dispatch_resume(_timer);
}

- (void)getCodeClicked {
    
    if (!xNullString(_phoneText.text)) {
        [self getCode];
    } else {
        [TipsView showCenterTitle:@"请输入您的手机号" duration:1 completion:nil];
    }
}

- (void)gotoLogined {
    
    if (xNullString(_phoneText.text)||xNullString(_numText.text)) {
        [TipsView showCenterTitle:@"请输入您的手机号和验证码" duration:1 completion:nil];
        return;
    }
    [self verifyCode];
}

- (void)getCode {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"请稍侯";
    hud.backgroundColor = [UIColor clearColor];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:_phoneText.text forKey:@"phone"];
    [parameter setValue:@"101" forKey:@"firmId"];
    
    [HttpRequestManager postWithUrlString:GetLoginCode parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hideAnimated:YES];
        [self openCountdown];
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        NSString *msg = responseObject[@"message"];
        if ([responseObject[@"success"] boolValue] == YES) {
            [TipsView showCenterTitle:msg duration:1 completion:nil];
        } else {
            [self alertViewWithMessage:msg cancelTitle:@"知道了"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        NSDictionary *dic = error.userInfo;
        NSString *str = dic[@"NSLocalizedDescription"];
        [TipsView showCenterTitle:str duration:1 completion:nil];
    }];
}

- (void)verifyCode {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"请稍侯";
    hud.backgroundColor = [UIColor clearColor];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:_phoneText.text forKey:@"phone"];
    [parameter setValue:@"101" forKey:@"firmId"];
    [parameter setValue:_numText.text forKey:@"code"];
    
    [HttpRequestManager postWithUrlString:Login parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        [hud hideAnimated:YES];
        if ([responseObject[@"success"] boolValue] == YES) {
            
            NSDictionary *dic = responseObject[@"data"];
            NSString *useid = dic[@"userId"];
            NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
            [defaults setValue:self.phoneText.text forKey:PhoneNum];
            [defaults setValue:useid forKey:UserId];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            NSString *msg = responseObject[@"message"];
            [TipsView showCenterTitle:msg duration:1 completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        NSDictionary *dic = error.userInfo;
        NSString *str = dic[@"NSLocalizedDescription"];
        [TipsView showCenterTitle:str duration:1 completion:nil];
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
