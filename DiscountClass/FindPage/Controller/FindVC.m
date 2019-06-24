//
//  FindVC.m
//  DiscountClass
//
//  Created by Cary on 2019/4/30.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "FindVC.h"
#import "ThirdLibsHeader.h"
#import "findHotCell.h"
#import "findListCell.h"
#import "NewsVC.h"


NSString *const xFindListCell = @"FindListCell";
NSString *const xFindHotCell = @"FindHotCell";

@interface FindVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTableView;

@end

@implementation FindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发现";
    [self createUI];
}

- (void)createUI {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight-xTabBarHeight) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;

    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_mainTableView registerClass:[findHotCell class] forCellReuseIdentifier:xFindHotCell];
    [_mainTableView registerClass:[findListCell class] forCellReuseIdentifier:xFindListCell];
    [self.view addSubview:_mainTableView];
}

-  (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 135;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sectionIcon"]];
    [view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(view.mas_left).offset(14);
    }];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    [view addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(img.mas_right).offset(8);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
    if (section == 0) {
        headerLabel.text = @"一周热门";
    } else {
        headerLabel.text = @"资讯文章";
    }
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        findHotCell *cell = [tableView dequeueReusableCellWithIdentifier:xFindHotCell];
        cell.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        findListCell *cell = [tableView dequeueReusableCellWithIdentifier:xFindListCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        NewsVC *vc = [[NewsVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
