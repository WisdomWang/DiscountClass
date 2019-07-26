//
//  SettingVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/7.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "SettingVC.h"
#import "OpinionVC.h"
#import "ThirdLibsHeader.h"

NSString *const xSettingCell = @"SettingCell";

@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSArray *arrName;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIView *userHeaderView;
@property (nonatomic,strong) UIView *userFooterView;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置";
    
     arrName = @[@"意见反馈",@"去好评"];
    [self initUserTable];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        
        NSLog(@"clicked navigationbar back button");
    }

}

- (void)initUserTable {
    
    CGRect  tableViewFrame = CGRectMake(0, 0, xScreenWidth, xScreenHeight);
    _mainTableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:PhoneNum]) {
        
     _mainTableView.tableFooterView = self.userFooterView;
    } else {
     _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    _mainTableView.tableHeaderView = self.userHeaderView;
    _mainTableView.rowHeight = 60;
    [self.view addSubview:_mainTableView];
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:xSettingCell];
}

- (UIView *)userHeaderView {
    
    if (!_userHeaderView) {
        
        _userHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 180)];
        _userHeaderView.userInteractionEnabled = YES;
        _userHeaderView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        
        UIImageView *headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginLogo"]];
        [_userHeaderView addSubview:headerImg];
        [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.userHeaderView.mas_centerX);
            make.top.equalTo(self.userHeaderView.mas_top).offset(30);
        }];
        
        UILabel * headerLabel = [[UILabel alloc] init];
        headerLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        headerLabel.font = [UIFont boldSystemFontOfSize:18];
        headerLabel.textAlignment = NSTextAlignmentCenter;
        NSString *version = [xCommonFunction getAppVersion];
        headerLabel.text = [NSString stringWithFormat:@"Version:%@",version];
        [_userHeaderView addSubview:headerLabel];
        [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.userHeaderView.mas_centerX);
            make.bottom.equalTo(self.userHeaderView.mas_bottom).offset(-20);
            make.width.mas_equalTo(100);
        }];
        
        

    }
    
    return _userHeaderView;
}

- (UIView *)userFooterView {
    if (!_userFooterView) {
        _userFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 80)];
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setTitle:@"安全退出" forState:0];
        [nextButton setTitleColor:[UIColor colorWithHexString:@"#f44640"] forState:0];
        nextButton.backgroundColor = [UIColor whiteColor];
        nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [nextButton addTarget:self action:@selector(LoginedPopBack) forControlEvents:UIControlEventTouchUpInside];
        [_userFooterView addSubview:nextButton];
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userFooterView.mas_top).offset(20);
            make.centerX.equalTo(self.userFooterView.mas_centerX);
            make.width.mas_equalTo(xScreenWidth);
            make.height.mas_equalTo(60);
        }];
        
    }
    
    return _userFooterView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  //  return arrName.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xSettingCell];
    cell.textLabel.text = arrName[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        OpinionVC *vc= [[OpinionVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    else if (indexPath.row == 1) {
        
          [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1388210344&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
    }
}

- (void)LoginedPopBack {
    
    //初始化
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您确定要退出登录么？" preferredStyle:UIAlertControllerStyleAlert];
    
    //创建action 添加到alertController上 可根据UIAlertActionStyleDefault创建不同的alertAction
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //回调
        // 模态视图，使用dismiss 隐藏
        [alertController dismissViewControllerAnimated:YES completion:nil];
        NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
        [defaults setValue:nil forKey:PhoneNum];
        [defaults setValue:nil forKey:UserId];
        [defaults synchronize];
        [self.navigationController popToRootViewControllerAnimated:YES];

        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    //往alertViewController上添加alertAction
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    //呈现
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
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
