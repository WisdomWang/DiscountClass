//
//  BindInfoPayCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/17.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "BindInfoPayCell.h"
#import "ThirdLibsHeader.h"

@implementation BindInfoPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _label = [UILabel new];
        _label.textColor = [UIColor colorWithHexString:@"#333333"];
        _label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(44);
        }];
        
        _textField = [[UITextField alloc]init];
        _textField.textColor = [UIColor colorWithHexString:@"#333333"];
        _textField.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.label.mas_right);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.height.mas_equalTo(44);
        }];
        
        _sendCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendCodeButton setTitle:@"获取验证码" forState:0];
        [_sendCodeButton setTitleColor:[UIColor colorWithHexString:@"#f4410e"] forState:0];
        _sendCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _sendCodeButton.layer.cornerRadius = 5;
        _sendCodeButton.layer.borderWidth = 0.5;
        _sendCodeButton.layer.borderColor = [[UIColor colorWithHexString:@"#f4410e"] CGColor];
        [_sendCodeButton addTarget:self action:@selector(sendCodeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_sendCodeButton];
        [_sendCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
        }];
        
    }
    
    return self;
}

- (void)sendCodeClick:(UIButton *)button {
    
    self.sendCodeBlock(button);
}

@end
