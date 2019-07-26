

//
//  OpinionVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/7.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "OpinionVC.h"
#import "ThirdLibsHeader.h"
#import "UITextView+Placeholder.h"
#import "OpinionSuccessVC.h"

@interface OpinionVC ()

@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UITextField *infoText;

@end

@implementation OpinionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    self.navigationItem.title = @"意见反馈";
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    _textView.text = @"";
    _infoText.text = @"";
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [TipsView dismiss];
}

- (void)createUI {
    
    UIImageView *bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, xStatusBarHeight+xNavBarHeight, xScreenWidth, xScreenWidth/1.875)];
    bg.image = [UIImage imageNamed:@"setOpinionBg"];
    [self.view addSubview:bg];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"popBack_white"] forState:0];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    _textView = [[UITextView alloc]init];
    _textView.placeholder = @"为了提供更好的服务，请详细描述您的问题或建议，我们将及时跟进解决";
    _textView.placeholderColor = [UIColor colorWithHexString:@"#999999"];
    _textView.placeholderLabel.font = [UIFont systemFontOfSize:15];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(bg.mas_bottom).offset(0);
        make.width.mas_equalTo(xScreenWidth);
        make.height.mas_equalTo(xScreenWidth/2.20 );
    }];
    
    _infoText = [[UITextField alloc]init];
    NSString *str = @"请输入手机号、邮箱（选填，方便我们联系你）";
    _infoText.backgroundColor = [UIColor whiteColor];
    _infoText.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:str];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithHexString:@"#999999"]
                        range:NSMakeRange(0, str.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14]
                        range:NSMakeRange(0, str.length)];
    _infoText.attributedPlaceholder = placeholder;
    _infoText.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10,40)];
    _infoText.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_infoText];
    [_infoText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.textView.mas_bottom).offset(15);
        make.width.mas_equalTo(xScreenWidth);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"提交" forState:0];
    [nextButton setTitleColor:[UIColor whiteColor] forState:0];
    nextButton.backgroundColor = [UIColor colorWithHexString:@"#f44640"];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:17];
    nextButton.layer.cornerRadius = 5;
    [nextButton addTarget:self action:@selector(gotoNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoText.mas_bottom).offset(15);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(xScreenWidth-40);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)gotoNext {
    
    if (xNullString(_textView.text)) {
        [TipsView showCenterTitle:@"请描述您的问题或建议"duration:1 completion:nil];
        return;
    }
    OpinionSuccessVC *vc = [[OpinionSuccessVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)popBack {
    
    [self.navigationController popViewControllerAnimated:YES];
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
