//
//  PersonalVC.m
//  DiscountClass
//
//  Created by Cary on 2019/4/30.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "PersonalVC.h"
#import "ThirdLibsHeader.h"
#import "SettingVC.h"
#import "OrderListVC.h"
#import "BankCardVC.h"
#import "HelpCenterVC.h"
#import "AboutVC.h"
#import "LoginVC.h"
#import "SingletonWebView.h"

NSString *const xPersonalCell = @"PersonalCell";

@interface PersonalVC ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSArray *arrName;
    NSArray *arrImg;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIView *userHeaderView;
@property (nonatomic,strong) UIButton *userButton;

@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的";

    arrName = @[@"我的订单",@"银行卡",@"帮助中心",@"关于惠课堂",@"在线客服",@"设置"];
    arrImg  =  @[@"baseInfoIcon",@"bankInfoIcon",@"helpInfoIcon",@"aboutInfoIcon",@"customerInfoIcon",@"settingInfoIcon"];
    
    [self initUserTable];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:animated];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:PhoneNum]) {
        
        NSString *changeStr =  [xCommonFunction getSecretPhoneNum:[[NSUserDefaults standardUserDefaults] valueForKey:PhoneNum]];
        [_userButton setTitle:changeStr forState:0];
        _userButton.userInteractionEnabled = NO;
    } else {
        [_userButton setTitle:@"登录/注册" forState:0];
        _userButton.userInteractionEnabled = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)initUserTable {
    
    CGRect  tableViewFrame = CGRectMake(0, 0, xScreenWidth, xScreenHeight-xTabBarHeight);
    _mainTableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.tableHeaderView = self.userHeaderView;
    _mainTableView.rowHeight = 60;
    [self.view addSubview:_mainTableView];
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:xPersonalCell];
}

- (UIView *)userHeaderView {
    
    if (!_userHeaderView) {
        
        _userHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 108)];
        _userHeaderView.userInteractionEnabled = YES;
        _userHeaderView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        
    
        UIImageView *headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headerImg"]];
        [_userHeaderView addSubview:headerImg];
        [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.userHeaderView.mas_centerY);
            make.right.equalTo(self.userHeaderView.mas_right).offset(-30);
            make.width.mas_equalTo(54);
            make.height.mas_equalTo(54);
        }];
        
        _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
       
        _userButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        [_userButton addTarget:self action:@selector(gotoLogin) forControlEvents:UIControlEventTouchUpInside];
        [_userButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:0];
        [_userHeaderView addSubview:_userButton];
        [_userButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.userHeaderView.mas_centerY);
            make.left.equalTo(self.userHeaderView.mas_left).offset(17);
            make.height.mas_equalTo(54);
        }];
    }
    
    return _userHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 30;}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, 30)];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 2;
    }
    else if (section == 1) {
        
        return 3;
        //return 1;
    }
    
    else {
        
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xPersonalCell];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:arrImg[indexPath.row]];
        cell.textLabel.text = arrName[indexPath.row];
    }
    else if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:arrImg[indexPath.row+2]];
        cell.textLabel.text = arrName[indexPath.row+2];
    }
    else if (indexPath.section == 2) {
        cell.imageView.image = [UIImage imageNamed:arrImg.lastObject];
        cell.textLabel.text = arrName.lastObject;
    }
    
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        
        if (![[NSUserDefaults standardUserDefaults] valueForKey:UserId]) {
            
            LoginVC *vc= [[LoginVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            return;
            
        }
        
        if (indexPath.row == 0) {
            OrderListVC *vc = [[OrderListVC alloc]init];
            vc.hidesBottomBarWhenPushed  = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1) {
            BankCardVC *vc = [[BankCardVC alloc]init];
            vc.hidesBottomBarWhenPushed  = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
     
    }
    else if (indexPath.section == 1) {
   
        if (indexPath.row == 0) {
            HelpCenterVC *vc = [[HelpCenterVC alloc]init];
            vc.hidesBottomBarWhenPushed  = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1) {
            AboutVC *vc = [[AboutVC alloc]init];
            vc.hidesBottomBarWhenPushed  = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 2) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"4001559997"];
//                UIWebView *callWebview = [SingletonWebView shareManager];
//                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
//                [self.view addSubview:callWebview];
                
            if (@available(iOS 10.0, *)) {
                       NSString * telprompt = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4001559997"];
                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString: telprompt] options:@{} completionHandler:nil];
                   } else {
                       // Fallback on earlier versions
                       NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4001559997"];
                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                   }
            });
        }
    }
    else if (indexPath.section == 2) {
       
        SettingVC *vc = [[SettingVC alloc]init];
        vc.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)gotoLogin {
    
    LoginVC *vc = [[LoginVC alloc]init];
    vc.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
