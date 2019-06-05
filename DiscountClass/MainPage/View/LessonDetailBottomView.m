


//
//  LessonDetailBottomView.m
//  DiscountClass
//
//  Created by Cary on 2019/5/15.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "LessonDetailBottomView.h"
#import "ThirdLibsHeader.h"
#import "UIButton+zt_adjustImageAndTitle.h"

@implementation LessonDetailBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIButton  *linkEduButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [linkEduButton setImage:[UIImage imageNamed:@"linkEduButton"] forState:UIControlStateNormal];
        [linkEduButton setTitle:@"联系机构" forState:UIControlStateNormal];
        linkEduButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [linkEduButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [linkEduButton addTarget:self action:@selector(lickEduClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:linkEduButton];
        [linkEduButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY).offset(3);
            make.left.mas_equalTo(self.mas_left).offset(12);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(50);
        }];
        
        linkEduButton.zt_contentAdjustType = ZTContentAdjustImageDownTitleUp;
        linkEduButton.zt_space = 5;
        [linkEduButton zt_beginAdjustContent];
        
        UIButton  *linkCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [linkCartButton setImage:[UIImage imageNamed:@"linkCartButton"] forState:UIControlStateNormal];
        [linkCartButton setTitle:@"购物车" forState:UIControlStateNormal];
        linkCartButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [linkCartButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [linkCartButton addTarget:self action:@selector(gotoCartClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:linkCartButton];
        [linkCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY).offset(3);
            make.left.mas_equalTo(linkEduButton.mas_right).offset(0);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(50);
        }];
        
        linkCartButton.zt_contentAdjustType = ZTContentAdjustImageUpTitleDown;
        linkCartButton.zt_space = 5;
        [linkCartButton zt_beginAdjustContent];
        
        UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [payButton setTitle:@"立即购买" forState:0];
        [payButton setTitleColor:[UIColor whiteColor] forState:0];
        payButton.backgroundColor = [UIColor colorWithHexString:@"#ff9600"];
        payButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:payButton];
        [payButton addTarget:self action:@selector(confirmOrderClick) forControlEvents:UIControlEventTouchUpInside];
        [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(50);
        }];
        
        UIButton *addCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addCartButton setTitle:@"加入购物车" forState:0];
        [addCartButton setTitleColor:[UIColor whiteColor] forState:0];
        addCartButton.backgroundColor = [UIColor colorWithHexString:@"#ff410e"];
        addCartButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:addCartButton];
        [addCartButton addTarget:self action:@selector(addCartClick) forControlEvents:UIControlEventTouchUpInside];
        [addCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(payButton.mas_left);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(50);
        }];
        
        UIView *bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(xScreenWidth);
            make.height.mas_equalTo(1);
        }];
        
        UIView *topLine = [[UIView alloc]init];
        topLine.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        [self addSubview:topLine];
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.width.mas_equalTo(xScreenWidth);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

- (void)confirmOrderClick {
    
    self.confirmBlock();
}

- (void)gotoCartClick {
    
    self.linkCartBlock();
}

- (void)lickEduClick {
    self.linkEduBlock();
}

- (void)addCartClick {
    
    self.addCartBlock();
}

@end
