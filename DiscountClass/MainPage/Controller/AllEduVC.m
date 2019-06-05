
//
//  AllEduVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/9.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "AllEduVC.h"
#import "ThirdLibsHeader.h"
#import "AllEduListCell.h"
#import "EduModel.h"
#import "EduDetailVC.h"

NSString *const xAllEduListCell = @"AllEduListCell";

@interface AllEduVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    
    NSInteger a;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *eduListArr;
@property (nonatomic,strong) UIView *userHeaderView;

@end

@implementation AllEduVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"合作机构";
    _eduListArr = [[NSMutableArray alloc]init];
    a = 1;
    [self initTableView];
    [self addRefresh];
}

- (void)initTableView {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.estimatedRowHeight = 150;
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    _mainTableView.tableHeaderView = self.userHeaderView;
    [_mainTableView registerClass:[AllEduListCell class] forCellReuseIdentifier:xAllEduListCell];
    [self.view addSubview:_mainTableView];
    
}


- (UIView *)userHeaderView {
    
    if (!_userHeaderView) {
        
        _userHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 50)];
        _userHeaderView.userInteractionEnabled = YES;
        
        UITextField *searchText = [[UITextField alloc]init];
        searchText.placeholder = @"搜索机构";
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
        searchText.clearButtonMode = YES;
        [_userHeaderView addSubview:searchText];
        searchText.userInteractionEnabled = YES;
        [searchText mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.userHeaderView.mas_top).offset(10);
            make.left.equalTo(self.userHeaderView.mas_left).offset(14);
            make.width.mas_equalTo(309);
            make.height.mas_equalTo(30);
            
        }];
        
        UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchIcon"]];
        [searchText addSubview:searchIcon];
        [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(searchText.mas_centerY);
            make.left.equalTo(searchText.mas_left).offset(15);
            
        }];
        
    }
    
    return _userHeaderView;
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
    [self loadEduIcon];
}

- (void)loadMoreData {
    a++;
   [self loadEduIcon];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        return _eduListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EduArrModel *m = _eduListArr[indexPath.row];
    
    AllEduListCell *cell = [tableView dequeueReusableCellWithIdentifier:xAllEduListCell];
    cell.model = m;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    EduArrModel *m = _eduListArr[indexPath.row];
    EduDetailVC *vc = [[EduDetailVC alloc]init];
    vc.model = m;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (xNullString(textField.text)) {
        
        return;
        
    }
    
    self.mainTableView.mj_header = nil;
    self.mainTableView.mj_footer = nil;
    [self searchEduInfo:textField.text];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    a = 1;
    [self addRefresh];
    return YES;
}


- (void)loadEduIcon {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"20"forKey:@"size"];
    [parameter setValue:@(a)  forKey:@"current"];
    
    [HttpRequestManager postWithUrlString:GetAllEduIcon parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        EduModel *baseData = [[EduModel alloc]initWithDic:responseObject];
        if (baseData.success == YES) {
            
            if (self->a == 1) {
                if (self.eduListArr.count>0) {
                    [self.eduListArr removeAllObjects];
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
            
            for (EduArrModel *m in baseData.data) {
                [self.eduListArr addObject:m];
            }
            [self.mainTableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)searchEduInfo:(NSString *)keywords {
    
    if (_eduListArr.count > 0) {
        [_eduListArr removeAllObjects];
    }
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"30"forKey:@"size"];
    [parameter setValue:@(1)  forKey:@"current"];
    [parameter setValue:keywords forKey:@"keywords"];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
