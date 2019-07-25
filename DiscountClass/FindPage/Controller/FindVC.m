//
//  FindVC.m
//  DiscountClass
//
//  Created by Cary on 2019/4/30.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "FindVC.h"
#import "ThirdLibsHeader.h"
#import "FindHotCell.h"
#import "FindListCell.h"
#import "NewsVC.h"
#import "NewsModel.h"
#import "LessonModel.h"
#import "BannerModel.h"
#import "LessonDetailVC.h"

NSString *const xFindListCell = @"FindListCell";
NSString *const xFindHotCell = @"FindHotCell";

@interface FindVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *newsListArr;
@property (nonatomic,strong) NSMutableArray *advArr;
@property (nonatomic,strong) NSMutableArray *picArr;

@end

@implementation FindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发现";
    _newsListArr = [[NSMutableArray alloc]init];
    _advArr = [[NSMutableArray alloc]init];
    _picArr = [[NSMutableArray alloc]init];
    [self createUI];
    [self loadNewsList];
    [self loadBanner];
}

- (void)createUI {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight-xTabBarHeight) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;

    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_mainTableView registerClass:[FindHotCell class] forCellReuseIdentifier:xFindHotCell];
    [_mainTableView registerClass:[FindListCell class] forCellReuseIdentifier:xFindListCell];
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
        return _newsListArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    
    if (indexPath.section == 0) {
        FindHotCell *cell = [tableView dequeueReusableCellWithIdentifier:xFindHotCell];
        cell.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cycleScrollView.imageURLStringsGroup = _picArr;
        cell.gotoDetailBlock = ^(NSInteger index) {
            
            BannerDetailModel *m = weakSelf.advArr[index];
            [weakSelf loadBannerDetail:m.courseId];
            
        };
        return cell;
    } else {
        FindListCell *cell = [tableView dequeueReusableCellWithIdentifier:xFindListCell];
        cell.model = _newsListArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        NewsListModel *m = _newsListArr[indexPath.row];
        NewsVC *vc = [[NewsVC alloc]init];
        vc.urlStr = m.url;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)loadNewsList {
    
    
    [HttpRequestManager postWithUrlString:GetAllInformation parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        
        NewsModel *baseData =  [[NewsModel alloc]initWithDic:responseObject];
        if (baseData.success == YES) {
            
            for (NewsListModel *m in baseData.data) {
                [self.newsListArr addObject:m];
            }
            [self.mainTableView reloadData];
        }
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loadBanner {
    
    [HttpRequestManager postWithUrlString:GetWeekHotAdv parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        BannerModel *baseData = [[BannerModel alloc]initWithDic:responseObject];
        if (baseData.success == YES) {
            
        }for (BannerDetailModel *m in baseData.data) {
            
            [self.advArr addObject:m];
            [self.picArr addObject:m.img];
        }
        [self.mainTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loadBannerDetail:(NSString *)courseId {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:courseId  forKey:@"courseId"];
    
    [HttpRequestManager postWithUrlString:GetCourseInfo parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        if ([responseObject[@"success"] boolValue]) {
            
            LessonArrModel *m =  [[LessonArrModel alloc]initWithDic:responseObject[@"data"]];
            LessonDetailVC *vc = [[LessonDetailVC alloc]init];
            vc.m = m;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
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
