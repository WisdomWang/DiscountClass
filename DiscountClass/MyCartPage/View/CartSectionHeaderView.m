
//
//  CartSectionHeaderView.m
//  DiscountClass
//
//  Created by Cary on 2019/5/17.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "CartSectionHeaderView.h"
#import "ThirdLibsHeader.h"

@implementation CartSectionHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, xScreenWidth, 66);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(16, 16, xScreenWidth-32, 48)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton setImage:[UIImage imageNamed:@"unselectedButton"] forState:UIControlStateNormal];
        [_selectedButton addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_selectedButton];
        [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view.mas_centerY);
            make.left.mas_equalTo(view.mas_left).offset(16);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(22);
        }];
        
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _headerLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        _headerLabel.font = [UIFont systemFontOfSize:13];
        _headerLabel.text = @"新世界教育";
        [view addSubview:_headerLabel];
        [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view.mas_centerY);
            make.left.mas_equalTo(self.selectedButton.mas_right).offset(8);
            make.right.mas_equalTo(view.mas_right).offset(-16);
            make.height.mas_equalTo(50);
        }];
        
         }
    
          return self;
}

- (void)setEduModel:(CartEduModel *)eduModel {
    
    self.headerLabel.text = eduModel.eduName;
    self.isClick = eduModel.isSelect;
    
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
