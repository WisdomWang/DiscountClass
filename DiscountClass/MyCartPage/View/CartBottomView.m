//
//  CartBottomView.m
//  DiscountClass
//
//  Created by Cary on 2019/5/6.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "CartBottomView.h"
#import "ThirdLibsHeader.h"

@implementation CartBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton setImage:[UIImage imageNamed:@"unselectedButton"] forState:UIControlStateNormal];
        [_selectedButton addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectedButton];
        [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).offset(32);
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(16);
        }];
        
        UILabel *allLabel = [[UILabel alloc]init];
        allLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        allLabel.font = [UIFont systemFontOfSize:13];
        allLabel.text = @"全选";
        [self addSubview:allLabel];
        [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.selectedButton.mas_right).offset(10);
        }];
        
        _allPriceLabel = [[UILabel alloc]init];
        _allPriceLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        _allPriceLabel.font = [UIFont boldSystemFontOfSize:16];
        _allPriceLabel.text = @"合计:￥0";
        [self addSubview:_allPriceLabel];
        [_allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(allLabel.mas_right).offset(12);
        }];
        
        
        UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [payButton setTitle:@"去结算" forState:0];
        [payButton setTitleColor:[UIColor whiteColor] forState:0];
        payButton.backgroundColor = [UIColor colorWithHexString:@"#ff410e"];
        payButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [payButton addTarget:self action:@selector(gotoPayClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:payButton];
        [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right);
            make.width.mas_equalTo(125);
            make.height.mas_equalTo(55);
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

- (void)selectedClick:(UIButton *)button {
    
    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"selectedButton"] forState:UIControlStateNormal];
    } else {
        [button setImage:[UIImage imageNamed:@"unselectedButton"] forState:UIControlStateNormal];
    }
    if (self.AllClickRowBlock) {
        self.AllClickRowBlock(button.selected);
    }
    
}

- (void)gotoPayClick {
    
    self.PayBlock();
}

- (void)setIsClick:(BOOL)isClick {
    _isClick = isClick;
    self.selectedButton.selected = isClick;
    if (isClick) {
        [self.selectedButton setImage:[UIImage imageNamed:@"selectedButton"] forState:(UIControlStateNormal)];
    } else {
        [self.selectedButton setImage:[UIImage imageNamed:@"unselectedButton"] forState:(UIControlStateNormal)];
    }
}

@end
