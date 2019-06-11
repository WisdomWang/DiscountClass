


//
//  BankListCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/29.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "BankListCell.h"
#import "ThirdLibsHeader.h"

@implementation BankListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        _bgView = [UIImageView new];
        _bgView.layer.cornerRadius = 8;
        _bgView.layer.masksToBounds = YES;
        _bgView.userInteractionEnabled = YES;
        _bgView.image = [UIImage imageNamed:@"bankBg"];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.width.mas_equalTo(xScreenWidth-30);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
        }];
        
        _iconImage = [[UIImageView alloc]init];
        _iconImage.image = [UIImage imageNamed:@"smallUnionPayIcon"];
        [_bgView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView.mas_top).offset(19);
            make.left.equalTo(self.bgView.mas_left).offset(18);
        }];
        _label = [UILabel new];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:18];
        [_bgView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY);
            make.left.equalTo(self.iconImage.mas_right).offset(5);
        }];
        
        _detailLabel = [UILabel new];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.font = [UIFont systemFontOfSize:20];
        [_bgView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImage.mas_left);
            make.width.mas_equalTo(xScreenWidth-70);
            make.bottom.equalTo(self.bgView.mas_bottom).offset(-19);
        }];
        
    }
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:0];
    [self.confirmButton setTitle:@"解除" forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.confirmButton addTarget:self action:@selector(changeBankCard) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.detailLabel.mas_centerY);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];

    return self;
}

- (void)changeBankCard {
    
    self.changeBankCardBlock();
}

- (void)setModel:(BankInfoModel *)model {
    
    _label.text = model.bankName;
    _detailLabel.text = model.accountNo;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
