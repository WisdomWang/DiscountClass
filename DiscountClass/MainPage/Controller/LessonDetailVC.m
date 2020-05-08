//
//  LessonDetailVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/8.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "LessonDetailVC.h"
#import "LessonDetailCell.h"
#import "ThirdLibsHeader.h"
#import "LessonDetailTwoCell.h"
#import "LessonDetailThreeCell.h"
#import "LessonDetailBottomView.h"
#import "ConfirmOrderVC.h"
#import "MyCartVC.h"
#import "AddressListModel.h"
#import "SelectedAddressView.h"
#import "LoginVC.h"
#import "SingletonWebView.h"

NSString *const xLessonDetailCell = @"LessonDetailCell";
NSString *const xLessonDetailTwoCell = @"LessonDetailTwoCell";
NSString *const xLessonDetailThreeCell = @"LessonDetailThreeCell";

@interface LessonDetailVC ()<UITableViewDelegate,UITableViewDataSource> 

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *addressArr;
@property (nonatomic,strong) SelectedAddressView *addressView;
@property (nonatomic,strong) AddressListDetailModel *model;
@property (nonatomic,strong) MBProgressHUD *HUD;
@property (nonatomic,copy) NSString *eduTel;
@property (nonatomic,copy) NSString *htmlStr;

@end

@implementation LessonDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"课程详情";
    
    _addressArr = [[NSMutableArray alloc]init];
    
    [self initTableView];
    [self loadEduInfo];
    [self loadCourseInfo];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [TipsView dismiss];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        
        NSLog(@"clicked navigationbar back button");
        NSNotification * notice = [NSNotification notificationWithName:LoginNoti object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
}

- (void)initTableView {
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight-50-xTabbarSafeBottomMargin) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.estimatedRowHeight = 200;
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    [_mainTableView registerClass:[LessonDetailCell class] forCellReuseIdentifier:xLessonDetailCell];
    [_mainTableView registerClass:[LessonDetailTwoCell class] forCellReuseIdentifier:xLessonDetailTwoCell];
    [_mainTableView registerClass:[LessonDetailThreeCell class] forCellReuseIdentifier:xLessonDetailThreeCell];
    [self.view addSubview:_mainTableView];
    
    __weak typeof(self) weakSelf = self;
    LessonDetailBottomView *bottomView = [[LessonDetailBottomView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    bottomView.confirmBlock = ^{
        
        if (self.model) {
            
            if ([[NSUserDefaults standardUserDefaults] valueForKey:UserId]) {
                
                ConfirmOrderVC *vc= [[ConfirmOrderVC alloc]init];
                vc.m = weakSelf.m;
                vc.addressModel = weakSelf.model;
                vc.orderPrice = weakSelf.m.price;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            } else {
               
                LoginVC *vc= [[LoginVC alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            

        } else {  
            [TipsView showCenterTitle:@"请先选择上课地点!" duration:1 completion:^{
                
            }];
        }
    };
    
    bottomView.linkEduBlock = ^{
        
        if (xNullString(self.eduTel)) {
            [TipsView showCenterTitle:@"暂无联系方式" duration:1 completion:nil];
            return;
        }
//        NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.eduTel];
//        UIWebView *callWebview = [SingletonWebView shareManager];
//        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
//        [self.view addSubview:callWebview];
        
        
        if (@available(iOS 10.0, *)) {
            NSString * telprompt = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.eduTel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: telprompt] options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.eduTel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
        
        
    };
    
    bottomView.linkCartBlock = ^{
        
        MyCartVC *vc = [[MyCartVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    bottomView.addCartBlock = ^{
        if (!self.model) {
            [TipsView showCenterTitle:@"请先选择上课地点!" duration:1 completion:^{
                
            }];
        } else {
            
            if ([[NSUserDefaults standardUserDefaults] valueForKey:UserId]) {
                
                [self addCart:self.model.courseId];
                
            } else {
                
                LoginVC *vc= [[LoginVC alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }
    };
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(50);
    } ];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    } else {
         return 16;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, 16)];
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
     
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     
     if (section == 0) {
         return 2;
     } else {
         return 1;
     }
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     if (indexPath.section == 0 && indexPath.row == 0) {
         
         LessonDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:xLessonDetailCell];
         cell.model = _m;
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
     }
     else if (indexPath.section == 0 && indexPath.row == 1) {
         LessonDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:xLessonDetailTwoCell];
         cell.label.text = @"地点";
         if (!self.model) {
             cell.detailLabel.text = @"请选择";
         } else {
             cell.detailLabel.text = self.model.address;
         }
         
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         return cell;
     }
     else if (indexPath.section == 1) {
         
         LessonDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:xLessonDetailTwoCell];
         cell.label.text = @"声明";
         cell.detailLabel.text = @"报名多个课程时请尽量避免课程时间段重合\n请您理解并确认惠学习非商品/服务的提供者。对于产生纠纷等情况，请您与教育培训机构自行沟通协商，惠学习无法进行干预。";
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
     } else {
         
         LessonDetailThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:xLessonDetailThreeCell];
         if (!xNullString(_htmlStr)) {
              cell.htmlStr = _htmlStr;
         }
        
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
     }

 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section ==0 && indexPath.row == 1) {
        
        [self loadAddressList];
    }
}

- (void)loadAddressList {
    
    if (_addressArr.count > 0) {
        [_addressArr removeAllObjects];
    }
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue: _m.courseId forKey:@"courseId"];
    [HttpRequestManager postWithUrlString:GetAllEduAddress parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        AddressListModel *baseData = [[AddressListModel alloc]initWithDic:responseObject];
        if (baseData.success == YES) {
            for (AddressListDetailModel *m in baseData.data) {
                [self.addressArr addObject:m];
            }
            
            self.addressView = [[SelectedAddressView alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight)];
            self.addressView.addressArr = self.addressArr;

            __weak typeof(self) weakSelf = self;
            
            [UIView animateWithDuration:2 animations:^{
                
            } completion:^(BOOL finished) {
             [self.view insertSubview:self.addressView aboveSubview:self.view];
            }];
            
            self.addressView.popBackBlock = ^{
               
                [UIView animateWithDuration:2 animations:^{
                    
                } completion:^(BOOL finished) {
                    [weakSelf.addressView removeFromSuperview];
                }];
               
           };
        
            self.addressView.selectedBlock = ^(AddressListDetailModel * _Nonnull m) {
              
                weakSelf.model = m;
                [weakSelf.mainTableView reloadData];
                [UIView animateWithDuration:2 animations:^{
                    
                } completion:^(BOOL finished) {
                    [weakSelf.addressView removeFromSuperview];
                }];
            };
            
        }
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        
    }];
}

- (void)addCart:(NSString *)courserId {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue: _model.courseId forKey:@"courseId"];
    [parameter setValue: [[NSUserDefaults standardUserDefaults] valueForKey:UserId] forKey:@"userId"];
    [HttpRequestManager postWithUrlString:AddCourseCart parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        if ([responseObject[@"success"] boolValue] == YES) {
            
            NSNotification * notice = [NSNotification notificationWithName:LoginNoti object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self.view addSubview:self.HUD];
            self.HUD.mode = MBProgressHUDModeCustomView;
            self.HUD.label.text = @"加入购物车成功";
            self.HUD.label.textColor = [UIColor whiteColor];
            self.HUD.bezelView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
            [self.HUD hideAnimated:YES afterDelay:1];
        } else {
            
            NSString *msg = responseObject[@"msg"];
            [TipsView showCenterTitle:msg duration:1 completion:^{
                
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)loadEduInfo {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue: _m.eduId forKey:@"eduId"];
    [HttpRequestManager postWithUrlString:GetEduInfo parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *repData = [xCommonFunction dictionaryToJson:responseObject];
        NSLog(@"%@",repData);
        NSDictionary *dic = responseObject[@"data"];
        self.eduTel = dic[@"linkMobile"];
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

- (void)loadCourseInfo {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue: _m.courseId forKey:@"courseId"];
    NSLog(@"%@",_m.courseId);
    
   AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:GetCourseDetailHtml parameters: parameter progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
        self.htmlStr = result;
        [self.mainTableView reloadData];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
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
