

//
//  EduDetailVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/15.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "EduDetailVC.h"
#import "LessonModel.h"
#import "ThirdLibsHeader.h"
#import "MainListCell.h"
#import "LessonDetailVC.h"

NSString *const xEduDetailCell = @"EduDetailCell";

@interface EduDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIView *userHeaderView;
@property (nonatomic,strong) NSMutableArray *eduDetailArr;

@end

@implementation EduDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"机构详情";
    _eduDetailArr = [[NSMutableArray alloc]init];
    [self initTableView];
    [self loadLessonList:_model.eduId];
}

- (void)initTableView {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.tableHeaderView = self.userHeaderView;
    _mainTableView.estimatedRowHeight = 200;
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    [_mainTableView registerClass:[MainListCell class] forCellReuseIdentifier:xEduDetailCell];
    [self.view addSubview:_mainTableView];
}

- (UIView *)userHeaderView {
    
    if (!_userHeaderView) {
        
        _userHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 155)];
        _userHeaderView.userInteractionEnabled = YES;
        UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 155)];
        bgView.image = [UIImage imageNamed:@"ConfirmOrderTop"];
        [_userHeaderView addSubview:bgView];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:22];
        titleLabel.text = _model.eduName;
        titleLabel.numberOfLines = 0;
        [bgView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).offset(50);
            make.left.equalTo(bgView.mas_left).offset(17);
            make.right.equalTo(bgView.mas_right).offset(-17);
        }];
        
        
        UILabel *addressLabel = [[UILabel alloc]init];
        addressLabel.textColor = [UIColor whiteColor];
        addressLabel.font = [UIFont boldSystemFontOfSize:12];
        addressLabel.numberOfLines = 0;
        addressLabel.text = _model.address;
        [bgView addSubview:addressLabel];
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel .mas_bottom).offset(11);
            make.left.equalTo(titleLabel.mas_left);
            make.right.equalTo(bgView.mas_right).offset(-17);
        }];
        
    }
    
    return _userHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _eduDetailArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LessonArrModel *m = _eduDetailArr[indexPath.row];
    MainListCell *cell = [tableView dequeueReusableCellWithIdentifier:xEduDetailCell];
    cell.model = m;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LessonArrModel *m = _eduDetailArr[indexPath.row];
    LessonDetailVC *vc = [[LessonDetailVC alloc]init];
    vc.m = m;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadLessonList:(NSString *)eduId {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"30"forKey:@"size"];
    [parameter setValue:@"1"  forKey:@"current"];
    [parameter setValue:eduId forKey:@"eduId"];
    
    NSLog(@"%@",parameter);
    
    [HttpRequestManager postWithUrlString:GetAllCourse parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        LessonModel *baseData = [[LessonModel alloc]initWithDic:responseObject];
        if (baseData.success == YES) {
            for (LessonArrModel *m in baseData.data) {
                [self.eduDetailArr addObject:m];
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
