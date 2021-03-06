//
//  MainSearchView.m
//  DiscountClass
//
//  Created by Cary on 2019/5/9.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "MainSearchView.h"
#import "ThirdLibsHeader.h"
#import "MainListCell.h"


NSString *const xMainSearchCell = @"MainSearchCell";

@interface MainSearchView ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
    NSInteger a;
    
}

@property (nonatomic,strong) NSString *keyWords;

@end

@implementation MainSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        a = 1;
        [self createViews];
        self.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        self.arrLessonList = [[NSMutableArray alloc]init];
        [self addRefresh];
    }
    return self;
}

- (void)addRefresh {
    
    if (_arrLessonList.count == 0) {
        self.mainTableView.mj_footer = nil;
        return;
    }
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.mainTableView.mj_footer = footer;
    footer.stateLabel.hidden = YES;
}

- (void)loadMoreData {
    a++;
    [self loadLessonList:_keyWords];
    
}
            
- (void)createViews {
    
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
    searchText.clearButtonMode = YES;
    [self addSubview:searchText];
    searchText.userInteractionEnabled = YES;
    searchText.delegate = self;
    [searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(xStatusBarHeight+7);
        make.left.equalTo(self.mas_left).offset(14);
        make.width.mas_equalTo(309);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [popButton setTitle:@"取消" forState:0];
    [popButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:0];
    popButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [popButton addTarget:self action:@selector(popClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:popButton];
    [popButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchText.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-14);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchIcon"]];
    [searchText addSubview:searchIcon];
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchText.mas_centerY);
        make.left.equalTo(searchText.mas_left).offset(15);
        
    }];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, xTopHeight, xScreenWidth, xScreenHeight-xTopHeight) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.estimatedRowHeight = 200;
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self addSubview:_mainTableView];
    [_mainTableView registerClass:[MainListCell class] forCellReuseIdentifier:xMainSearchCell];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrLessonList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LessonArrModel *m = _arrLessonList[indexPath.row];
    MainListCell *cell = [tableView dequeueReusableCellWithIdentifier:xMainSearchCell];
    cell.model = m;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     LessonArrModel *m = _arrLessonList[indexPath.row];
     self.searchLessonBlock(m);
}

- (void)popClick:(UIButton *)button {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, xScreenHeight, xScreenWidth, xScreenHeight);
        self.cancelBlock();
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([textField.text isEqualToString:_keyWords]) {
        
        return;
       
    } else {
        
        if (self.arrLessonList.count > 0) {
            [self.arrLessonList removeAllObjects];
        }
    }
    _keyWords = textField.text;
    a = 1;
    if (![textField.text isEqualToString:@""]) {
        [self loadLessonList:_keyWords];
       
    } else {
        if (self.arrLessonList.count > 0) {
            [self.arrLessonList removeAllObjects];
        }
        [self addRefresh];
        [self.mainTableView reloadData];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if (self.arrLessonList.count > 0) {
        [self.arrLessonList removeAllObjects];
        [self.mainTableView reloadData];
    }
    return YES;
}

- (void)loadLessonList:(NSString *)keywords {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"20"forKey:@"size"];
    [parameter setValue:@(a)  forKey:@"current"];
    [parameter setValue:keywords forKeyPath:@"keywords"];
    
    NSLog(@"%@",parameter);
    
    [HttpRequestManager postWithUrlString:GetAllCourse parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        LessonModel *baseData = [[LessonModel alloc]initWithDic:responseObject];
        if (baseData.success == YES) {
            
                if (baseData.data.count == 0) {
                    [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
                    self->a--;
                    return;
                }

                [self.mainTableView.mj_footer endRefreshing];
            
            for (LessonArrModel *m in baseData.data) {
                [self.arrLessonList addObject:m];
            }
            [self.mainTableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
