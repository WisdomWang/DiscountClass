//
//  MainVC.m
//  DiscountClass
//
//  Created by Cary on 2019/4/30.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "MainVC.h"
#import "ThirdLibsHeader.h"

@interface MainVC ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSArray *titileArr;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIView *userHeaderView;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    titileArr = @[@"推荐",@"学历",@"语言",@"K12",@"职业技能"];
    
    [self createUI];
}

- (void)createUI {
    
    for (int i=0; i<5; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0 ||i == 4) {
            button.frame = CGRectMake(17+i%5*60, xTopHeight+18, 70, 40);
        } else {
            button.frame = CGRectMake(17+i%5*60, xTopHeight+18, 65, 40);
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
        [self.view addSubview:button];
    }
    
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, xTopHeight+78, xScreenWidth, xScreenHeight-xTabBarHeight) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.tableHeaderView = self.userHeaderView;
    [self.view addSubview:_mainTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (void)buttonClick:(UIButton *)button {
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    
    if (button.tag == 5) {
        button.frame = CGRectMake(17+(button.tag-1)%5*60, xTopHeight+18, 120, 40);
    } else {
        UIButton *lastButton = [self.view viewWithTag:5];
        lastButton.frame = CGRectMake(17+(5-1)%5*60, xTopHeight+18, 70, 40);
    }
    
    for (int i=0; i<5; i++) {
        
        UIButton *otherButton = [self.view viewWithTag:i+1];
        if (i != button.tag -1) {
        otherButton.titleLabel.font = [UIFont systemFontOfSize:15];
        }
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
