

//
//  AboutVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/20.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "AboutVC.h"
#import <WebKit/WebKit.h>
#import "ThirdLibsHeader.h"

NSString *const xAboutCell = @"AboutCell";

@interface AboutVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *arrQA;
}

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) UITableView *mainTableView;

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"关于惠课堂";
    
    arrQA = @[@"什么是惠课堂？",@"惠课堂是上海泽学教育科技有限公司旗下品牌,与国内众多大型连锁教育培训机构紧密合作,面向全国有接受教育意愿的学员提供课程选购服务的软件，让您随时随地拥有课程及教育机构搜索、浏览、购买等在线功能。",@"惠课堂与教育机构是什么关系？",@"惠课堂与教育培训机构是商业合作关系。请您理解并确认惠课堂非商品/服务的提供者，并与提供商品/服务的教育培训机构之间无任何广告、保证 或经销关系，惠课堂不会诱导用户进行购买课程。\n惠课堂不对教育培训机构的商品/服务等提供任何担保，有关教育培训机构商品/服务的质量、售后等相关事宜均由教育培训机构自行负责，若用户与教育培训机构发生争议，由用户与教育培训机构协商自行处理，惠课堂无法进行干预。",@"通过惠课堂购买课程后，如果与教育培训机构产生纠纷该怎么办？",@"惠课堂仅提供课程选购服务，请您理解并确认惠课堂非商品/服务的提供者。\n对于产生纠纷等情况，请您与教育培训机构自行沟通协商，惠课堂无法进行干预。\n协商无法解决时，可以通过合法手段向有关主管部门申诉。"];
    
    [self createTableView];
    
//    if ([UIDevice currentDevice].systemVersion.doubleValue <11.0) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//
//    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, xTopHeight, xScreenWidth, xScreenHeight-xTopHeight)];
//    [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.huifintech.com/aboutus.html"]]];
//    [self.view addSubview:_webView];
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
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:xAboutCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     return arrQA.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xAboutCell];
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
