
//
//  HelpCenterVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/20.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "HelpCenterVC.h"
#import <WebKit/WebKit.h>
#import "ThirdLibsHeader.h"

NSString *const xHelpCell = @"HelpCell";

@interface HelpCenterVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *arrQA;
}

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) UITableView *mainTableView;

@end

@implementation HelpCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"帮助中心";
//    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, xTopHeight, xScreenWidth, xScreenHeight-xTopHeight)];
//    if ([UIDevice currentDevice].systemVersion.doubleValue <11.0) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://weixin.huifintech.com/account.html#FAQ"]]];
//
//    [self.view addSubview:_webView];
    
    arrQA = @[@"惠课堂APP能做什么？",@"惠课堂APP是一款为用户提供课程,教育机构搜索,浏览及购买等在线功能服务的。",@"有哪些课程类型可供选择？",@"可供选择的课程类型有：学历教育，语言教育，K12教育，职业技能等课程选购服务。",@"如何取消已经预定的课程？",@"提交订单后，若超过1小时没有付款，预定的课程将自动取消。同时，也可以我的订单中直接删除不要的课程。",@"线上购买的课程如何在线下使用？",@"购买完课程后，在我的订单-待使用订单中，会出现已购买的课程信息，线下使用，将待使用订单信息展示给机构确认使用即可，已使用后的订单不可重复使用。",@"手机收不到验证码，怎么办？",@"首先请确认，当前的手机号与输入的手机号是否一致，如果不一致，请输入当前正在使用的手机号；如果一致，可能是短信通道的问题，稍等即可，不要在一个时间段里多次发送验证码，系统有安全防护机制，频繁发送验证码手机号会被拉黑，可以换个时间段再尝试。",@"我的惠课堂APP页面打不开了，怎么办?",@"原因1：请检查您的网络情况，如果是无网络连接或弱网情况下，会因为页面无法加载或加载速度过慢，而导致页面打开失败。您可以切换网络，或者直接关闭网络试一下能否打开。\n原因2：其他情况 ，请联系惠课堂客服，客服电话为：021-4001559997",@"安装速度慢，一直显示等待中，或者正在下载的进度是怎么回事？",@"这种情况请检查网络，或者删除应用在appstore重新搜索下载就可以了。"];
    
    [self createTableView];
}

- (void)createTableView {
    
    CGRect  tableViewFrame = CGRectMake(0, 0, xScreenWidth, xScreenHeight);
    _mainTableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_mainTableView];
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:xHelpCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrQA.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xHelpCell];
    cell.textLabel.text = arrQA[indexPath.row];
    if (indexPath.row%2 == 0) {
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.numberOfLines = 0;
    } else {
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines = 0;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
