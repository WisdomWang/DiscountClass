//
//  AllLessonVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/9.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "AllLessonVC.h"
#import "ThirdLibsHeader.h"
#import "LessonModel.h"
#import "MainListCell.h"
#import "LessonDetailVC.h"

NSString *const xAllLessonListCell = @"AllLessonListCell";

@interface AllLessonVC ()<UITableViewDelegate,UITableViewDataSource> {
    NSInteger a;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *lessonListArr;

@end

@implementation AllLessonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = [NSString stringWithFormat:@"%@课程",_kindStr];
    
    _lessonListArr = [[NSMutableArray alloc]init];
    a = 1;
    [self initTableView];
    [self addRefresh];
}

- (void)addRefresh {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    //header.stateLabel.hidden = YES;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.mainTableView.mj_header = header;
    self.mainTableView.mj_footer = footer;
    [self.mainTableView.mj_header beginRefreshing];
    
}

- (void)loadNewData {
    a = 1;
    if ([_kindStr isEqualToString:@"推荐"]) {
        [self loadLessonList:@""];
    } else {
        [self loadLessonList:_kindStr];
    }
}

- (void)loadMoreData {
    a++;
    if ([_kindStr isEqualToString:@"推荐"]) {
        [self loadLessonList:@""];
    } else {
        [self loadLessonList:_kindStr];
    }
}

- (void)initTableView {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.estimatedRowHeight = 200;
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    [_mainTableView registerClass:[MainListCell class] forCellReuseIdentifier:xAllLessonListCell];
    [self.view addSubview:_mainTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return _lessonListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        LessonArrModel *m = _lessonListArr[indexPath.row];
        MainListCell *cell = [tableView dequeueReusableCellWithIdentifier:xAllLessonListCell];
        cell.model = m;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        LessonArrModel *m = _lessonListArr[indexPath.row];
        LessonDetailVC *vc = [[LessonDetailVC alloc]init];
        vc.m = m;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadLessonList:(NSString *)lessonKind {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"20"forKey:@"size"];
    [parameter setValue:@(a)  forKey:@"current"];
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
            
            if (self->a == 1) {
                if (self.lessonListArr.count>0) {
                    [self.lessonListArr removeAllObjects];
                }
                [self.mainTableView.mj_header endRefreshing];
                
            } else {
                
                if (baseData.data.count == 0) {
                    [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
                    self->a--;
                    return;
                }
                
                [self.mainTableView.mj_footer endRefreshing];
            }
            
            
            for (LessonArrModel *m in baseData.data) {
                [self.lessonListArr addObject:m];
            }
            [self.mainTableView reloadData];
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
