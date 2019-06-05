//
//  OpinionSuccessVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/28.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "OpinionSuccessVC.h"
#import "ThirdLibsHeader.h"

@interface OpinionSuccessVC ()

@end

@implementation OpinionSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"反馈提交成功";
    [self createUI];
}

- (void)createUI {
    
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"successImg"];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(xStatusBarHeight+xNavBarHeight+30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(120);
    }];
    
    UILabel * label = [[UILabel alloc]init];
    label.text = @"提交成功，十分感谢您的反馈";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(img.mas_bottom).offset(15);
        make.width.mas_equalTo(xScreenWidth-50);
        make.height.mas_equalTo(20);
    }];
    
    UILabel * label1 = [[UILabel alloc]init];
    label1.text = @"帮助我们更好服务于广大学子";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor colorWithHexString:@"#999999"];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(label.mas_bottom).offset(5);
        make.width.mas_equalTo(xScreenWidth-50);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"我还要提建议" forState:0];
    [nextButton setTitleColor:[UIColor whiteColor] forState:0];
    nextButton.backgroundColor = [UIColor colorWithHexString:@"#f44640"];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:17];
    nextButton.layer.cornerRadius = 5;
    [nextButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(15);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(xScreenWidth-40);
        make.height.mas_equalTo(44);
    }];
    UIButton *nextButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton1 setTitle:@"返回首页" forState:0];
    [nextButton1 setTitleColor:[UIColor colorWithHexString:@"#f44640"] forState:0];
    nextButton1.titleLabel.font = [UIFont systemFontOfSize:17];
    nextButton1.layer.borderColor= [UIColor colorWithHexString:@"#f44640"].CGColor;
    nextButton1.layer.borderWidth= 1.0f;
    nextButton1.layer.cornerRadius = 5;
    [nextButton1 addTarget:self action:@selector(gotoNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton1];
    [nextButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nextButton.mas_bottom).offset(15);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(xScreenWidth-40);
        make.height.mas_equalTo(44);
    }];
}
- (void)gotoNext {

    [self.navigationController popToRootViewControllerAnimated:YES];
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
