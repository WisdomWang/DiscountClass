//
//  MainVC.m
//  DiscountClass
//
//  Created by Cary on 2019/4/30.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "MainVC.h"
#import "ThirdLibsHeader.h"
#import "MainListCell.h"
#import "LessonDetailVC.h"
#import "MainEduListCell.h"
#import "AllLessonVC.h"
#import "AllEduVC.h"
#import "MainSearchView.h"
#import "LessonModel.h"
#import "EduModel.h"
#import "EduDetailVC.h"

NSString *const xMainListCell = @"MainListCell";
NSString *const xMainEduListCell = @"MainEduListCell";

@interface MainVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SDCycleScrollViewDelegate> {
    
    NSArray *titileArr;
    UIScrollView *scrollView;
    NSString *kindStr;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIView *userHeaderView;
@property (nonatomic,strong) MainSearchView  *mainSearchView;
@property (nonatomic,strong) NSMutableArray *lessonListArr;
@property (nonatomic,strong) NSMutableArray *eduListArr;
@property (nonatomic,strong) NSMutableArray *advArr;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    self.navigationItem.title = @"首页";
    
    titileArr = @[@"推荐",@"学历",@"语言",@"K12",@"职业技能"];
    _lessonListArr = [[NSMutableArray alloc]init];
    _eduListArr = [[NSMutableArray alloc]init];
    _advArr = [[NSMutableArray alloc]init];
    kindStr = @"推荐";
    [self loadBanner];
     [self loadEduIcon];
    [self createUI];
    [self loadLessonList:@""];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (@available(iOS 11.0, *)) {
        [[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:1].alpha = 0;
        [[[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:0] setHidden:NO];
    } else {
        
        self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    }
    
     [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    
    [super viewWillDisappear:animated];
    
    if (@available(iOS 11.0, *)) {
        [[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:1].alpha = 1;
        [[[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:0] setHidden:NO];
    } else {
        
        self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
    }
    
     [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}


- (void)createUI {
    
    UITextField *searchText = [[UITextField alloc]init];
    searchText.placeholder = @"搜索课程名称";
    searchText.backgroundColor = [UIColor whiteColor];
    searchText.alpha = 0.8;
    searchText.textColor = [UIColor colorWithHexString:@"#333333"];
    searchText.font = [UIFont systemFontOfSize:14];
    searchText.layer.masksToBounds = YES;
    searchText.layer.cornerRadius = 15;
    searchText.layer.borderColor= [UIColor colorWithHexString:@"#f8f6f9"].CGColor;
    searchText.layer.borderWidth= 1.0f;
    searchText.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,40,30)];
    searchText.leftViewMode=UITextFieldViewModeAlways;
    searchText.delegate = self;
    [self.view addSubview:searchText];
    searchText.userInteractionEnabled = YES;
    [searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(xStatusBarHeight+7);
        make.left.equalTo(self.view.mas_left).offset(14);
        make.width.mas_equalTo(309);
        make.height.mas_equalTo(30);
        
    }];
    
    UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchIcon"]];
    [searchText addSubview:searchIcon];
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchText.mas_centerY);
        make.left.equalTo(searchText.mas_left).offset(15);

    }];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, xTopHeight, xScreenWidth, 52)];
    if (xScreenWidth == 320) {
       scrollView.contentSize = CGSizeMake(xScreenWidth+60, 0);
    } else {
       scrollView.contentSize = CGSizeMake(xScreenWidth, 0);
    }

    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    for (int i=0; i<5; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0 ||i == 4) {
            button.frame = CGRectMake(14+i%5*60, 11, 70, 30);
        } else {
            button.frame = CGRectMake(14+i%5*60, 11, 65, 30);
        }
        
        [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titileArr[i] forState:UIControlStateNormal];
        if (i==0) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        }else {
            button.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        button.tag = i+1;
        [scrollView addSubview:button];
    }
    
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, xTopHeight+52, xScreenWidth, xScreenHeight-xTabBarHeight-xTopHeight-52) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.tableHeaderView = self.userHeaderView;
    _mainTableView.estimatedRowHeight = 200;
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    [_mainTableView registerClass:[MainListCell class] forCellReuseIdentifier:xMainListCell];
     [_mainTableView registerClass:[MainEduListCell class] forCellReuseIdentifier:xMainEduListCell];
    [self.view addSubview:_mainTableView];
    
}

- (UIView *)userHeaderView {
    
    if (!_userHeaderView) {
        
        _userHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 155)];
        _userHeaderView.userInteractionEnabled = YES;
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(14, 15, xScreenWidth-28, 125) delegate:self placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        [_userHeaderView addSubview:_cycleScrollView];
        
    }
    
    return _userHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, 48)];
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
        make.height.mas_equalTo(38);
    }];
    
    if (section == 0) {
        headerLabel.text = @"热门课程";
    } else {
        headerLabel.text = @"教育机构";
    }
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitle:@"更多" forState:0];
    [moreButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:0];
    moreButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [moreButton addTarget:self action:@selector(gotoMoreClick:) forControlEvents:UIControlEventTouchUpInside];
    moreButton.tag = section + 100;
    [view addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.right.equalTo(view.mas_right).offset(-17);
        make.height.mas_equalTo(16);
    }];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return _lessonListArr.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        LessonArrModel *m = _lessonListArr[indexPath.row];
        MainListCell *cell = [tableView dequeueReusableCellWithIdentifier:xMainListCell];
        cell.model = m;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        MainEduListCell *cell = [tableView dequeueReusableCellWithIdentifier:xMainEduListCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.eduListArr = _eduListArr;
        [cell.cellCollectionView reloadData];
        cell.EduDetailBlcok = ^(NSIndexPath * _Nonnull indexPath) {
            EduDetailVC *vc = [[EduDetailVC alloc]init];
            vc.model = self.eduListArr[indexPath.row];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        LessonArrModel *m = _lessonListArr[indexPath.row];
        LessonDetailVC *vc = [[LessonDetailVC alloc]init];
        vc.m = m;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)buttonClick:(UIButton *)button {
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    
    
    if (button.tag == 5) {
        button.frame = CGRectMake(14+(button.tag-1)%5*60, 11, 120, 30);
        if (xScreenWidth == 320) {
            scrollView.contentOffset = CGPointMake(60, 0);
        }
    } else {
        UIButton *lastButton = [self.view viewWithTag:5];
        lastButton.frame = CGRectMake(14+(5-1)%5*60, 11, 70, 30);
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    for (int i=0; i<5; i++) {
        
        UIButton *otherButton = [self.view viewWithTag:i+1];
        if (i != button.tag -1) {
        otherButton.titleLabel.font = [UIFont systemFontOfSize:15];
        }
    }
    if (button.tag == 1) {
        [self loadLessonList:@""];
    } else {
        [self loadLessonList:titileArr[button.tag-1]];
    }
    
    kindStr = titileArr[button.tag-1];
}

- (void)gotoMoreClick:(UIButton *)button {
    
    if (button.tag == 100) {
        NSLog(@"点击了热门课程更多按钮");
        AllLessonVC *vc = [[AllLessonVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.kindStr = kindStr;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSLog(@"点击了教育机构更多按钮");
        AllEduVC *vc = [[AllEduVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    _mainSearchView = [[MainSearchView alloc]initWithFrame:CGRectMake(0, xScreenHeight, xScreenWidth, xScreenHeight-xTopHeight)];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
     [window insertSubview:_mainSearchView aboveSubview:window];
    [UIView animateWithDuration:0.5 animations:^{
        self.mainSearchView.frame = CGRectMake(0, 0, xScreenWidth, xScreenHeight);

    } completion:^(BOOL finished) {
        
    }];
     __weak typeof(self) weakSelf = self;
    _mainSearchView.cancelBlock = ^{
    };
    _mainSearchView.searchLessonBlock = ^(LessonArrModel * _Nonnull m) {
        
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.mainSearchView.frame = CGRectMake(0, xScreenHeight, xScreenWidth, xScreenHeight);
        } completion:^(BOOL finished) {
            [weakSelf.mainSearchView removeFromSuperview];
        }];
        
        LessonDetailVC *vc = [[LessonDetailVC alloc]init];
        vc.m = m;
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    return NO;
}

- (void)loadLessonList:(NSString *)lessonKind {
    
    if (_lessonListArr.count > 0) {
        [_lessonListArr removeAllObjects];
    }
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"5"forKey:@"size"];
    [parameter setValue:@"1"  forKey:@"current"];
    if ([lessonKind isEqualToString:@""]) {
         [parameter setValue:@"1"forKey:@"isHot"];
    }
    [parameter setValue:lessonKind forKey:@"courseType"];
    
    NSLog(@"%@",parameter);
    
    [HttpRequestManager postWithUrlString:GetAllCourse parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        LessonModel *baseData = [[LessonModel alloc]initWithDic:responseObject];
        if (baseData.success == YES) {
            for (LessonArrModel *m in baseData.data) {
                [self.lessonListArr addObject:m];
            }
            [self.mainTableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loadEduIcon {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"9"forKey:@"size"];
    [parameter setValue:@"1"  forKey:@"current"];
    
    [HttpRequestManager postWithUrlString:GetAllEduIcon parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        EduModel *baseData = [[EduModel alloc]initWithDic:responseObject];
        if (baseData.success == YES) {
            
            for (EduArrModel *m in baseData.data) {
                [self.eduListArr addObject:m];
            }
            [self.mainTableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loadBanner {
    
    [HttpRequestManager postWithUrlString:GetAllAdv parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        if ([responseObject[@"success"] boolValue]) {
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                
                NSString *address = dic[@"img"];
                [self.advArr addObject:address];
                
            }
            NSLog(@"%@",self->_advArr);
            self.cycleScrollView.imageURLStringsGroup = self.advArr;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)NetworkMonitoring
{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //2.开启监听
    [manger startMonitoring];
    //3.监听网络状态的改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown = -1,
         AFNetworkReachabilityStatusNotReachable = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"此时没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"移动网络");
                [self loadBanner];
                [self loadEduIcon];
                [self loadLessonList:@""];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                [self loadBanner];
                [self loadEduIcon];
                [self loadLessonList:@""];
                
                break;
            default:
                break;
        }
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
