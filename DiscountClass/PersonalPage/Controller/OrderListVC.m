

//
//  OrderListVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/9.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "OrderListVC.h"
#import "ThirdLibsHeader.h"
#import "OrderListOneCell.h"
#import "OrderListModel.h"
#import "PayOrderVC.h"
#import "ConfirmPayVC.h"

NSString *const xOrderListOneCell = @"OrderListOneCell";

@interface OrderListVC ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate> {
    
    NSArray *titleArr;
    NSDictionary *titleDic;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *orderListArr;
@property (nonatomic,strong) NSMutableArray *orderIds;

@end

@implementation OrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的订单";
    titleArr = @[@"全部",@"待付款",@"已完成",@"已取消",@"待使用"];
    titleDic = @{@"全部":@"",@"待付款":@"1",@"已完成":@"4",@"已取消":@"0",@"待使用":@"2"};
    _orderListArr = [[NSMutableArray alloc]init];
    _orderIds = [[NSMutableArray alloc]init];
    [self createUI];
    [self loadOrderList:@""];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [TipsView dismiss];
}

- (void)createUI {
    
    for (int i=0; i<5; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        int col = i%5;
     //   int row = i/4;
        CGFloat margin = (xScreenWidth - 68*5)/6;
        CGFloat btnX = margin + (68 + margin) * col;
       // CGFloat btnY = margin + (68 + margin) *row;
        button.frame = CGRectMake(btnX, xTopHeight, 68, 40);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        }else {
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        }
        button.tag = i+20;
        [self.view addSubview:button];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#f44640"];
        lineView.tag = i+30;
        [self.view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(button.mas_bottom);
            make.centerX.equalTo(button.mas_centerX);
            make.height.mas_equalTo(4);
            make.width.mas_equalTo(30);
        }];
        if (i == 0) {
            lineView.hidden = NO;
        } else {
            lineView.hidden = YES;
        }
       
    }
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,xTopHeight+40, xScreenWidth, xScreenHeight-xTopHeight-40) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.emptyDataSetSource = self;
    _mainTableView.emptyDataSetDelegate = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.estimatedRowHeight = 200;
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    [_mainTableView registerClass:[OrderListOneCell class] forCellReuseIdentifier:xOrderListOneCell];
    [self.view addSubview:_mainTableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _orderListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    
    OrderListOneModel *m = _orderListArr[indexPath.row];
    OrderListOneCell *cell = [tableView dequeueReusableCellWithIdentifier:xOrderListOneCell];
    cell.model = m;
    cell.deleteOrderBlock = ^{
      
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除么？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [weakSelf delOrder:m.orderId andRow:indexPath.row];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    };
    
    cell.payOrderBlock = ^{

        [self getAlinSignInfo:m];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)buttonClick:(UIButton *)button {
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    NSString *titleStr = titleDic[button.titleLabel.text];
    if (_orderListArr.count > 0) {
        [_orderListArr removeAllObjects];;
    }
    [self loadOrderList:titleStr];
    
    UIView *lineView = [self.view viewWithTag:button.tag+10];
    lineView.hidden = NO;
    
    for (int i=0; i<5; i++) {
        
         UIView *otherLineView = [self.view viewWithTag:i+30];
        if (i != button.tag -20) {
          otherLineView.hidden = YES;
        }
    }
    for (int i=0; i<5; i++) {
        
        UIButton *otherButton = [self.view viewWithTag:i+20];
        if (i != button.tag -20) {
            otherButton.titleLabel.font = [UIFont systemFontOfSize:16];
            [otherButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        }
    }
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"您还没有相关订单";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#515151"],
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"emptyOrderList"];
}

- (void)loadOrderList:(NSString *)orderStatus {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [parameter setValue:@"100"forKey:@"size"];
    [parameter setValue:@"1"  forKey:@"current"];
    [parameter setValue:orderStatus forKey:@"orderStatus"];
    
    [HttpRequestManager postWithUrlString:GetAllCourseOrder parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        
        OrderListModel *basedata = [[OrderListModel alloc]initWithDic:responseObject];
        if (basedata.success == YES) {
            
            for (OrderListOneModel *model in basedata.data) {
                
                [self.orderListArr addObject:model];
            }
            [self.mainTableView reloadData];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)delOrder:(NSString *)orderId andRow:(NSInteger)indexPathRow {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [parameter setValue:orderId forKey:@"orderId"];
    
    [HttpRequestManager postWithUrlString:DelCourseOrder parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        
        if ([responseObject[@"success"] boolValue] == YES) {
            
            [self.orderListArr removeObjectAtIndex:indexPathRow];
            [self.mainTableView reloadData];
        } else {
            
            NSString *msg = responseObject[@"msg"];
            [TipsView showCenterTitle:msg duration:1 completion:^{
                
            }];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)getAlinSignInfo:(OrderListOneModel *)m {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [HttpRequestManager postWithUrlString:GetAllinSignInfo parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        
        [self.orderIds addObject:m.orderId];
        
        if ([responseObject[@"success"] boolValue] == YES) {
            
            ConfirmPayVC *vc = [[ConfirmPayVC alloc]init];
            vc.orderPrice = m.price;
            vc.orderIds = self.orderIds;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            
            PayOrderVC *vc= [[PayOrderVC alloc]init];
            vc.orderPrice = m.price;
            vc.orderIds = self.orderIds;
            vc.theType =FromNewBind;
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
