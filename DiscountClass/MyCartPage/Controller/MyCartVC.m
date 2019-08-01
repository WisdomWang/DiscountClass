//
//  MyCartVC.m
//  DiscountClass
//
//  Created by Cary on 2019/4/30.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "MyCartVC.h"
#import "MyCartCell.h"
#import "ThirdLibsHeader.h"
#import "CartBottomView.h"
#import "OrderDetailVC.h"
#import "CartModel.h"
#import "CartSectionHeaderView.h"
#import "LoginVC.h"

NSString *const xMyCartCell = @"MyCartCell";
NSString *const xMyCartSectionHeader = @"MyCartSectionHeader";

@interface MyCartVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>  {
    
    
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *EduArr;
@property (nonatomic,strong) NSMutableArray *selectedArr;
@property (nonatomic,strong) CartBottomView *bottomView;
@property (nonatomic,copy) NSString *allPrice;

@end

@implementation MyCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    self.navigationItem.title = @"购物车";
    
    _EduArr = [[NSMutableArray alloc]init];
    _selectedArr = [[NSMutableArray alloc]init];
    [self createUI];
    [self loadCartList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification:) name:LoginNoti object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (xNullString([[NSUserDefaults standardUserDefaults] valueForKey:UserId])) {
        
        self.bottomView.hidden = YES;
        
        if (_EduArr.count > 0) {
            [_EduArr removeAllObjects];
        }
        if (_selectedArr.count > 0) {
            [_selectedArr removeAllObjects];
        }
        [self.mainTableView reloadData];
        return;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [TipsView dismiss];
}

- (void)createUI { 
    
    CGFloat height;
    
    if (self.tabBarController.tabBar.isHidden == YES) {
        height = xScreenHeight-55-xTabbarSafeBottomMargin;
    } else {
        height = xScreenHeight-xTabBarHeight-55;
    }
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, height) style:UITableViewStyleGrouped];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
//    _mainTableView.emptyDataSetSource = self;
//    _mainTableView.emptyDataSetDelegate = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.estimatedRowHeight = 200;
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mainTableView registerClass:[MyCartCell class] forCellReuseIdentifier:xMyCartCell];
    [_mainTableView registerClass:[CartSectionHeaderView class] forHeaderFooterViewReuseIdentifier:xMyCartSectionHeader];
    [self.view addSubview:_mainTableView];
    
     [self createBottomView];
    self.bottomView.hidden = YES;
    
}

- (void)createBottomView {
    
    _bottomView = [[CartBottomView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
        make.width.mas_equalTo(xScreenWidth);
        make.height.mas_equalTo(55);
    }];
    
    [self clickAllSelectBottomView:self.bottomView];
    
    __weak typeof(self) weakSelf = self;
    _bottomView.PayBlock = ^{
        
        if (weakSelf.selectedArr.count == 0) {
            [TipsView showCenterTitle:@"您还没有选择课程哦" duration:1 completion:nil];
            return ;
        }
        OrderDetailVC *vc = [[OrderDetailVC alloc]init];
        vc.selectedArr = weakSelf.selectedArr;
        vc.orderPrice = weakSelf.allPrice;
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 66;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CartSectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:xMyCartSectionHeader];
    CartEduModel *eduModel = _EduArr[section];
    sectionHeaderView.eduModel = eduModel;
    [self clickSectionHeaderView:sectionHeaderView andModel:eduModel];
    
    return sectionHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _EduArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CartEduModel *eduModel = _EduArr[section];
    return eduModel.courseList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CartEduModel *eduModel = _EduArr[indexPath.section];
    CartLessonModel *lessonModel = eduModel.courseList[indexPath.row];
    MyCartCell *cell = [tableView dequeueReusableCellWithIdentifier:xMyCartCell];
    cell.lessonModel = lessonModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self shoppingCartCellClickAction:cell eduModel:eduModel lessonModel:lessonModel indexPath:indexPath];
    
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *deleteArr = [[NSMutableArray alloc]init];
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除么？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
            CartEduModel *eduModel = self.EduArr[indexPath.section];
            CartLessonModel *lessonModel = eduModel.courseList[indexPath.row];
            [deleteArr addObject:lessonModel.courseId];
            [self deleteCartCourse:deleteArr indexPath:indexPath];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)clickAllSelectBottomView:(CartBottomView *)bottomView {
    
    bottomView.AllClickRowBlock = ^(BOOL isClick) {
        for (CartLessonModel *lessonModel in self.selectedArr) {
            lessonModel.isSelect = NO;
        }
        [self.selectedArr removeAllObjects];
        if (isClick) {
            for (CartEduModel *eduModel in self.EduArr) {
                eduModel.isSelect = YES;
                for (CartLessonModel *lessonModel in eduModel.courseList) {
                    lessonModel.isSelect = YES;
                    [self.selectedArr addObject:lessonModel];
                }
            }
        } else {
            
            for (CartEduModel *eduModel in self.EduArr) {
                eduModel.isSelect = NO;
            }
        }
        [self.mainTableView reloadData];
        [self countPrice];
    };
    
}

- (void)countPrice {
    
    double totlePrice = 0.0;
    for (CartLessonModel *lessonModel in self.selectedArr) {
        double price = [lessonModel.price doubleValue];
        totlePrice += price;
    }
    self.bottomView.allPriceLabel.text = [NSString stringWithFormat:@"合计￥%.2f", totlePrice];
    _allPrice = [NSString stringWithFormat:@"%.2f",totlePrice];
}

- (void)shoppingCartCellClickAction:(MyCartCell *)cell
                         eduModel:(CartEduModel *)eduModel
                         lessonModel:(CartLessonModel *)lessonModel
                          indexPath:(NSIndexPath *)indexPath {
    //选中某一行
    cell.ClickRowBlock = ^(BOOL isClick) {
        lessonModel.isSelect = isClick;
        if (isClick) {//选中
            NSLog(@"选中");
            [self.selectedArr addObject:lessonModel];
        } else {//取消选中
            NSLog(@"取消选中");
            [self.selectedArr removeObject:lessonModel];
        }
        
        [self judgeIsSelectSection:indexPath.section];
        [self judgeIsAllSelect];
        [self countPrice];
    };
  
}

/**
 判断分区有没有被全选
 @param section 分区坐标
 */
- (void)judgeIsSelectSection:(NSInteger)section {
    CartEduModel *eduModel = self.EduArr[section];
    BOOL isSelectSection = YES;
    //遍历分区商品, 如果有商品的没有被选择, 跳出循环, 说明没有全选
    for (CartLessonModel *lessonModel in eduModel.courseList) {
        if (lessonModel.isSelect == NO) {
            isSelectSection = NO;
            break;
        }
    }
    //全选了以后, 改变一下选中状态
    CartSectionHeaderView *headerView = (CartSectionHeaderView *)[self.mainTableView headerViewForSection:section];
    headerView.isClick = isSelectSection;
    eduModel.isSelect = isSelectSection;
}

/**
 是否全选
 */
- (void)judgeIsAllSelect {
    NSInteger count = 0;
    //先遍历购物车商品, 得到购物车有多少商品
    for (CartEduModel *eduModel in self.EduArr) {
        count += eduModel.courseList.count;
    }
    //如果购物车总商品数量 等于 选中的商品数量, 即表示全选了
    if (count == self.selectedArr.count) {
        self.bottomView.isClick = YES;
    } else {
        self.bottomView.isClick = NO;
    }
}

/**
 区头点击----选中某个分区/取消选中某个分区
 */
- (void)clickSectionHeaderView:(CartSectionHeaderView *)headerView andModel:(CartEduModel *)eduModel {
    headerView.AllClickRowBlock = ^(BOOL isClick) {
        eduModel.isSelect = isClick;
        
        if (isClick) {//选中
            NSLog(@"选中");
            for (CartLessonModel *lessonModel in eduModel.courseList) {
                lessonModel.isSelect = YES;
                if (![self.selectedArr containsObject:lessonModel]) {
                    [self.selectedArr addObject:lessonModel];
                }
            }
            
        } else {//取消选中
            NSLog(@"取消选中");
            
            for (CartLessonModel *lessonModel in eduModel.courseList) {
                lessonModel.isSelect = NO;
                if ([self.selectedArr containsObject:lessonModel]) {
                    [self.selectedArr removeObject:lessonModel];
                }
            }
        }
        [self judgeIsAllSelect];
        [self.mainTableView reloadData];
        [self countPrice];
    };
}

/**
 删除某个商品
 @param indexPath 坐标
 */
- (void)deleteGoodsWithIndexPath:(NSIndexPath *)indexPath {
    CartEduModel *eduModel = [self.EduArr objectAtIndex:indexPath.section];
    CartLessonModel *lessonModel = [eduModel.courseList objectAtIndex:indexPath.row];
    [eduModel.courseList removeObjectAtIndex:indexPath.row];
    [self.mainTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    if (eduModel.courseList.count == 0) {
        [self.EduArr removeObjectAtIndex:indexPath.section];
    }
    
    if ([self.selectedArr containsObject:lessonModel]) {
        [self.selectedArr removeObject:lessonModel];
        [self countPrice];
    }
    
    NSInteger count = 0;
    for (CartEduModel *eduModel in self.EduArr) {
        count += eduModel.courseList.count;
    }
    if (self.selectedArr.count == count) {
        _bottomView.selectedButton.selected = YES;
    } else {
        _bottomView.selectedButton.selected = NO;
    }
    
    if (count == 0) {
        //此处加载购物车为空的视图
        self.bottomView.hidden = YES;
    }
    [self.mainTableView reloadData];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"购物车是空的";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#515151"],
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"emptyCart"];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 0;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:UserId]);
    if (![[NSUserDefaults standardUserDefaults] valueForKey:UserId]) {
        NSString *text = @"去登录";
        UIFont *font = [UIFont systemFontOfSize:18];
        UIColor *textColor = [UIColor colorWithHexString:@"#f44640"];
        
        NSMutableDictionary *attributes = [NSMutableDictionary new];
        [attributes setObject:font forKey:NSFontAttributeName];
        [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    } else {
        
        return nil;
    }
   
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
   
    LoginVC *vc = [[LoginVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//接收到通知的操作
-(void) getNotification:(id)sender{
    //接收的sender是发送的NSNotification通知
    NSLog(@"%@",sender);
    [self loadCartList];
    //[self judgeIsAllSelect];
    self.bottomView.isClick = NO;
    [self countPrice];
 }


- (void)loadCartList {
    
    if (_EduArr.count > 0) {
        [_EduArr removeAllObjects];
    }
    
    if (_selectedArr.count > 0) {
        [_selectedArr removeAllObjects];
    }
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    
    [HttpRequestManager postWithUrlString:GetCourseCart parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        
        CartModel *baseData = [[CartModel alloc]initWithDic:responseObject];
        if (baseData.success == YES) {
            for (CartEduModel *EduModel in baseData.data) {
                [self.EduArr addObject:EduModel];
            }
            if (self.EduArr.count > 0) {
                self.bottomView.hidden = NO;
            }
            else if (self.EduArr.count == 0) {
                self.bottomView.hidden = YES;
            }
            
            self.mainTableView.emptyDataSetSource = self;
            self.mainTableView.emptyDataSetDelegate = self;
            
            [self.mainTableView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)deleteCartCourse:(NSMutableArray *)courseIds  indexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
     [parameter setValue:courseIds forKey:@"courseIds"];
    [HttpRequestManager postWithUrlString:UpdateCourseCart parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        [self deleteGoodsWithIndexPath:indexPath];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
